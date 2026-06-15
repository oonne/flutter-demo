import 'package:drift/drift.dart';
import 'base.dart';

/// Demo 数据表
/// 继承自 BaseTable，自动获得 id、createdAt、updatedAt 字段
///
/// 使用 @DataClassName 注解指定生成的数据类名称为 Demo
/// 默认会根据表名自动推导为 Demo（表名 demos → 数据类名 Demo）
@DataClassName('Demo')
class Demos extends BaseTable {
  /// 字符串字段示例
  /// - 最大长度限制为 256 个字符
  /// - 不允许为空（必填字段）
  TextColumn get demoTextField => text().withLength(max: 256)();

  /// 浮点数字段示例
  /// - 使用 real() 类型存储浮点数
  /// - 对应 Dart 的 double 类型
  RealColumn get demoDoubleField => real()();

  /// 布尔类型字段示例
  /// - 使用 boolean() 类型存储布尔值
  /// - 对应 Dart 的 bool 类型
  /// - 默认值为 false
  BoolColumn get demoBoolField => boolean().withDefault(const Constant(false))();
}