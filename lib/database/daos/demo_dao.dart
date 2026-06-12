import 'package:drift/drift.dart';
import '../database.dart';
import '../tables/demo_table.dart';

part 'demo_dao.g.dart';

/// Demo 表的数据访问对象（DAO）
///
/// 将 Demo 表的所有操作逻辑封装在此类中
/// 便于代码组织和维护
@DriftAccessor(tables: [Demos])
class DemoDao extends DatabaseAccessor<DemoDatabase> with _$DemoDaoMixin {
  /// 构造函数
  /// [db] 是数据库实例
  DemoDao(super.db);

  /// 插入一条 Demo 记录
  ///
  /// [demoTextField] 字符串字段，最大 200 字符
  /// [demoDoubleField] 浮点数字段
  Future<int> insertDemo({
    required String demoTextField,
    required double demoDoubleField,
  }) {
    return into(demos).insert(
      DemosCompanion(
        demoTextField: Value(demoTextField),
        demoDoubleField: Value(demoDoubleField),
      ),
    );
  }

  /// 获取所有 Demo 记录
  ///
  /// 返回按创建时间倒序排列的所有记录
  Future<List<Demo>> getAllDemos() {
    return (select(demos)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).get();
  }

  /// 根据 ID 获取单条 Demo 记录
  Future<Demo?> getDemoById(int id) {
    return (select(demos)..where((t) => t.id.equals(id))).getSingleOrNull();
  }

  /// 更新 Demo 记录
  ///
  /// 更新时会自动设置 updatedAt 为当前时间
  Future<int> updateDemo(int id, {String? demoTextField, double? demoDoubleField}) {
    return (update(demos)..where((t) => t.id.equals(id))).write(
      DemosCompanion(
        demoTextField: demoTextField != null ? Value(demoTextField) : const Value.absent(),
        demoDoubleField: demoDoubleField != null ? Value(demoDoubleField) : const Value.absent(),
        updatedAt: Value(DateTime.now()),
      ),
    );
  }

  /// 删除 Demo 记录
  Future<int> deleteDemo(int id) {
    return (delete(demos)..where((t) => t.id.equals(id))).go();
  }

  /// 监听 Demo 表的变化（流式查询）
  ///
  /// 当表中的数据发生变化时，会自动推送新数据
  Stream<List<Demo>> watchAllDemos() {
    return (select(demos)..orderBy([(t) => OrderingTerm.desc(t.createdAt)])).watch();
  }

  /// 统计记录总数
  Future<int> countDemos() {
    return (selectOnly(demos)..addColumns([demos.id.count()])).map((row) => row.read(demos.id.count())!).getSingle();
  }
}