// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'demo_dao.dart';

// ignore_for_file: type=lint
mixin _$DemoDaoMixin on DatabaseAccessor<DemoDatabase> {
  $DemosTable get demos => attachedDatabase.demos;
  DemoDaoManager get managers => DemoDaoManager(this);
}

class DemoDaoManager {
  final _$DemoDaoMixin _db;
  DemoDaoManager(this._db);
  $$DemosTableTableManager get demos =>
      $$DemosTableTableManager(_db.attachedDatabase, _db.demos);
}
