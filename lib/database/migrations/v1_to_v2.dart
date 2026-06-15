import 'package:drift/drift.dart';

/// 数据库迁移：版本 1 到版本 2
///
/// 迁移内容：
/// - 在 demos 表中添加 demo_bool_field 字段（布尔类型，默认值为 false）
///
/// 迁移策略：
/// - 使用自定义 SQL 语句添加新字段
/// - 现有数据会自动使用默认值 false，不会丢失
Future<void> migrateV1ToV2(GeneratedDatabase db) async {
  // DEMO表 添加新的布尔字段，默认值为 0 (false)
  await db.customStatement('ALTER TABLE demos ADD COLUMN demo_bool_field INTEGER NOT NULL DEFAULT 0');
}