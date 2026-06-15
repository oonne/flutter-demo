import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

// 导入表定义
import 'tables/demo_table.dart';

// 导入 DAO
import 'daos/demo_dao.dart';

// 导入迁移文件
import 'migrations/v1_to_v2.dart';

part 'database.g.dart';

/// 数据库实例
///
/// 使用 @DriftDatabase 注解声明数据库
/// - tables 参数列出所有需要管理的数据表
@DriftDatabase(
  tables: [
    Demos, // 注册 Demo 数据表
  ],
)
class DemoDatabase extends _$DemoDatabase {
  /// Demo 表的 DAO（数据访问对象）
  ///
  /// 通过 DAO 访问特定表的操作方法
  late final DemoDao demoDao;

  /// 单例实例
  static final DemoDatabase _instance = DemoDatabase._internal();

  /// 获取单例实例
  static DemoDatabase get instance => _instance;

  /// 私有构造函数
  DemoDatabase._internal() : super(_openConnection()) {
    // 初始化 DAO
    demoDao = DemoDao(this);
  }

  /// 数据库构造函数（保持向后兼容）
  factory DemoDatabase() => _instance;

  /// 数据库连接配置
  static LazyDatabase _openConnection() {
    return LazyDatabase(() async {
      // 获取应用文档目录路径
      final dbFolder = await getApplicationDocumentsDirectory();
      // 创建数据库文件路径
      final file = File(path.join(dbFolder.path, 'demo_database.sqlite'));
      // 返回数据库连接
      return NativeDatabase.createInBackground(file);
    });
  }

  /// 数据库版本号
  @override
  int get schemaVersion => 2;

  /// 数据库迁移逻辑
  ///
  /// 根据 drift 最佳实践，当需要修改数据库结构时：
  /// 1. 先更新表定义
  /// 2. 增加 schemaVersion
  /// 3. 在 migration 方法中实现从旧版本到新版本的迁移逻辑
  ///
  /// 这样老用户升级应用时，数据库会自动迁移，不会丢失数据
  @override
  MigrationStrategy get migration => MigrationStrategy(
        // 在迁移前调用（可选）
        beforeOpen: (details) async {
          // 确保所有外键约束生效
          await customStatement('PRAGMA foreign_keys = ON');
        },
        // 版本升级迁移逻辑
        onUpgrade: (migration, from, to) async {
          // 从版本 1 升级到版本 2
          if (from == 1 && to == 2) {
            // 调用独立的迁移文件
            await migrateV1ToV2(this);
          }
          // 未来添加更多版本迁移时，可以继续在这里添加
          // 例如：if (from == 2 && to == 3) { await migrateV2ToV3(this); }
        },
      );
}