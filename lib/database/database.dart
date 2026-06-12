import 'dart:io';

import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart' as path;

// 导入表定义
import 'tables/demo_table.dart';

// 导入 DAO
import 'daos/demo_dao.dart';

part 'database.g.dart';

/// Demo 数据库实例
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

  /// 数据库构造函数
  DemoDatabase() : super(_openConnection()) {
    // 初始化 DAO
    demoDao = DemoDao(this);
  }

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
  int get schemaVersion => 1;
}