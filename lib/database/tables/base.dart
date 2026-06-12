import 'package:drift/drift.dart';

/// 抽象基表类
/// 所有数据表都应该继承此类，确保统一的字段结构
abstract class BaseTable extends Table {
  /// 主键字段，自增整数类型
  /// 每个表都必须有唯一的主键
  IntColumn get id => integer().autoIncrement()();

  /// 创建时间字段
  /// 使用 withDefault(currentDateAndTime) 在插入时自动设置为当前时间
  DateTimeColumn get createdAt => dateTime().withDefault(currentDateAndTime)();

  /// 修改时间字段
  /// 默认为空，需要在更新时手动设置
  DateTimeColumn get updatedAt => dateTime().nullable()();
}