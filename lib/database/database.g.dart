// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'database.dart';

// ignore_for_file: type=lint
class $DemosTable extends Demos with TableInfo<$DemosTable, Demo> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DemosTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
    'id',
    aliasedName,
    false,
    hasAutoIncrement: true,
    type: DriftSqlType.int,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'PRIMARY KEY AUTOINCREMENT',
    ),
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _updatedAtMeta = const VerificationMeta(
    'updatedAt',
  );
  @override
  late final GeneratedColumn<DateTime> updatedAt = GeneratedColumn<DateTime>(
    'updated_at',
    aliasedName,
    true,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: false,
    defaultValue: currentDateAndTime,
  );
  static const VerificationMeta _demoTextFieldMeta = const VerificationMeta(
    'demoTextField',
  );
  @override
  late final GeneratedColumn<String> demoTextField = GeneratedColumn<String>(
    'demo_text_field',
    aliasedName,
    false,
    additionalChecks: GeneratedColumn.checkTextLength(maxTextLength: 256),
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _demoDoubleFieldMeta = const VerificationMeta(
    'demoDoubleField',
  );
  @override
  late final GeneratedColumn<double> demoDoubleField = GeneratedColumn<double>(
    'demo_double_field',
    aliasedName,
    false,
    type: DriftSqlType.double,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _demoBoolFieldMeta = const VerificationMeta(
    'demoBoolField',
  );
  @override
  late final GeneratedColumn<bool> demoBoolField = GeneratedColumn<bool>(
    'demo_bool_field',
    aliasedName,
    false,
    type: DriftSqlType.bool,
    requiredDuringInsert: false,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'CHECK ("demo_bool_field" IN (0, 1))',
    ),
    defaultValue: const Constant(false),
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    createdAt,
    updatedAt,
    demoTextField,
    demoDoubleField,
    demoBoolField,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'demos';
  @override
  VerificationContext validateIntegrity(
    Insertable<Demo> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    }
    if (data.containsKey('updated_at')) {
      context.handle(
        _updatedAtMeta,
        updatedAt.isAcceptableOrUnknown(data['updated_at']!, _updatedAtMeta),
      );
    }
    if (data.containsKey('demo_text_field')) {
      context.handle(
        _demoTextFieldMeta,
        demoTextField.isAcceptableOrUnknown(
          data['demo_text_field']!,
          _demoTextFieldMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_demoTextFieldMeta);
    }
    if (data.containsKey('demo_double_field')) {
      context.handle(
        _demoDoubleFieldMeta,
        demoDoubleField.isAcceptableOrUnknown(
          data['demo_double_field']!,
          _demoDoubleFieldMeta,
        ),
      );
    } else if (isInserting) {
      context.missing(_demoDoubleFieldMeta);
    }
    if (data.containsKey('demo_bool_field')) {
      context.handle(
        _demoBoolFieldMeta,
        demoBoolField.isAcceptableOrUnknown(
          data['demo_bool_field']!,
          _demoBoolFieldMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Demo map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Demo(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.int,
        data['${effectivePrefix}id'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      updatedAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}updated_at'],
      ),
      demoTextField: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}demo_text_field'],
      )!,
      demoDoubleField: attachedDatabase.typeMapping.read(
        DriftSqlType.double,
        data['${effectivePrefix}demo_double_field'],
      )!,
      demoBoolField: attachedDatabase.typeMapping.read(
        DriftSqlType.bool,
        data['${effectivePrefix}demo_bool_field'],
      )!,
    );
  }

  @override
  $DemosTable createAlias(String alias) {
    return $DemosTable(attachedDatabase, alias);
  }
}

class Demo extends DataClass implements Insertable<Demo> {
  /// 主键字段，自增整数类型
  /// 每个表都必须有唯一的主键
  final int id;

  /// 创建时间字段
  /// 使用 withDefault(currentDateAndTime) 在插入时自动设置为当前时间
  final DateTime createdAt;

  /// 修改时间字段
  /// 使用 withDefault(currentDateAndTime) 在插入时自动设置为当前时间
  /// 更新时需要手动设置为当前时间
  final DateTime? updatedAt;

  /// 字符串字段示例
  /// - 最大长度限制为 256 个字符
  /// - 不允许为空（必填字段）
  final String demoTextField;

  /// 浮点数字段示例
  /// - 使用 real() 类型存储浮点数
  /// - 对应 Dart 的 double 类型
  final double demoDoubleField;

  /// 布尔类型字段示例
  /// - 使用 boolean() 类型存储布尔值
  /// - 对应 Dart 的 bool 类型
  /// - 默认值为 false
  final bool demoBoolField;
  const Demo({
    required this.id,
    required this.createdAt,
    this.updatedAt,
    required this.demoTextField,
    required this.demoDoubleField,
    required this.demoBoolField,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || updatedAt != null) {
      map['updated_at'] = Variable<DateTime>(updatedAt);
    }
    map['demo_text_field'] = Variable<String>(demoTextField);
    map['demo_double_field'] = Variable<double>(demoDoubleField);
    map['demo_bool_field'] = Variable<bool>(demoBoolField);
    return map;
  }

  DemosCompanion toCompanion(bool nullToAbsent) {
    return DemosCompanion(
      id: Value(id),
      createdAt: Value(createdAt),
      updatedAt: updatedAt == null && nullToAbsent
          ? const Value.absent()
          : Value(updatedAt),
      demoTextField: Value(demoTextField),
      demoDoubleField: Value(demoDoubleField),
      demoBoolField: Value(demoBoolField),
    );
  }

  factory Demo.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Demo(
      id: serializer.fromJson<int>(json['id']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      updatedAt: serializer.fromJson<DateTime?>(json['updatedAt']),
      demoTextField: serializer.fromJson<String>(json['demoTextField']),
      demoDoubleField: serializer.fromJson<double>(json['demoDoubleField']),
      demoBoolField: serializer.fromJson<bool>(json['demoBoolField']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'updatedAt': serializer.toJson<DateTime?>(updatedAt),
      'demoTextField': serializer.toJson<String>(demoTextField),
      'demoDoubleField': serializer.toJson<double>(demoDoubleField),
      'demoBoolField': serializer.toJson<bool>(demoBoolField),
    };
  }

  Demo copyWith({
    int? id,
    DateTime? createdAt,
    Value<DateTime?> updatedAt = const Value.absent(),
    String? demoTextField,
    double? demoDoubleField,
    bool? demoBoolField,
  }) => Demo(
    id: id ?? this.id,
    createdAt: createdAt ?? this.createdAt,
    updatedAt: updatedAt.present ? updatedAt.value : this.updatedAt,
    demoTextField: demoTextField ?? this.demoTextField,
    demoDoubleField: demoDoubleField ?? this.demoDoubleField,
    demoBoolField: demoBoolField ?? this.demoBoolField,
  );
  Demo copyWithCompanion(DemosCompanion data) {
    return Demo(
      id: data.id.present ? data.id.value : this.id,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      updatedAt: data.updatedAt.present ? data.updatedAt.value : this.updatedAt,
      demoTextField: data.demoTextField.present
          ? data.demoTextField.value
          : this.demoTextField,
      demoDoubleField: data.demoDoubleField.present
          ? data.demoDoubleField.value
          : this.demoDoubleField,
      demoBoolField: data.demoBoolField.present
          ? data.demoBoolField.value
          : this.demoBoolField,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Demo(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('demoTextField: $demoTextField, ')
          ..write('demoDoubleField: $demoDoubleField, ')
          ..write('demoBoolField: $demoBoolField')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(
    id,
    createdAt,
    updatedAt,
    demoTextField,
    demoDoubleField,
    demoBoolField,
  );
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Demo &&
          other.id == this.id &&
          other.createdAt == this.createdAt &&
          other.updatedAt == this.updatedAt &&
          other.demoTextField == this.demoTextField &&
          other.demoDoubleField == this.demoDoubleField &&
          other.demoBoolField == this.demoBoolField);
}

class DemosCompanion extends UpdateCompanion<Demo> {
  final Value<int> id;
  final Value<DateTime> createdAt;
  final Value<DateTime?> updatedAt;
  final Value<String> demoTextField;
  final Value<double> demoDoubleField;
  final Value<bool> demoBoolField;
  const DemosCompanion({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    this.demoTextField = const Value.absent(),
    this.demoDoubleField = const Value.absent(),
    this.demoBoolField = const Value.absent(),
  });
  DemosCompanion.insert({
    this.id = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.updatedAt = const Value.absent(),
    required String demoTextField,
    required double demoDoubleField,
    this.demoBoolField = const Value.absent(),
  }) : demoTextField = Value(demoTextField),
       demoDoubleField = Value(demoDoubleField);
  static Insertable<Demo> custom({
    Expression<int>? id,
    Expression<DateTime>? createdAt,
    Expression<DateTime>? updatedAt,
    Expression<String>? demoTextField,
    Expression<double>? demoDoubleField,
    Expression<bool>? demoBoolField,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (createdAt != null) 'created_at': createdAt,
      if (updatedAt != null) 'updated_at': updatedAt,
      if (demoTextField != null) 'demo_text_field': demoTextField,
      if (demoDoubleField != null) 'demo_double_field': demoDoubleField,
      if (demoBoolField != null) 'demo_bool_field': demoBoolField,
    });
  }

  DemosCompanion copyWith({
    Value<int>? id,
    Value<DateTime>? createdAt,
    Value<DateTime?>? updatedAt,
    Value<String>? demoTextField,
    Value<double>? demoDoubleField,
    Value<bool>? demoBoolField,
  }) {
    return DemosCompanion(
      id: id ?? this.id,
      createdAt: createdAt ?? this.createdAt,
      updatedAt: updatedAt ?? this.updatedAt,
      demoTextField: demoTextField ?? this.demoTextField,
      demoDoubleField: demoDoubleField ?? this.demoDoubleField,
      demoBoolField: demoBoolField ?? this.demoBoolField,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (updatedAt.present) {
      map['updated_at'] = Variable<DateTime>(updatedAt.value);
    }
    if (demoTextField.present) {
      map['demo_text_field'] = Variable<String>(demoTextField.value);
    }
    if (demoDoubleField.present) {
      map['demo_double_field'] = Variable<double>(demoDoubleField.value);
    }
    if (demoBoolField.present) {
      map['demo_bool_field'] = Variable<bool>(demoBoolField.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DemosCompanion(')
          ..write('id: $id, ')
          ..write('createdAt: $createdAt, ')
          ..write('updatedAt: $updatedAt, ')
          ..write('demoTextField: $demoTextField, ')
          ..write('demoDoubleField: $demoDoubleField, ')
          ..write('demoBoolField: $demoBoolField')
          ..write(')'))
        .toString();
  }
}

abstract class _$DemoDatabase extends GeneratedDatabase {
  _$DemoDatabase(QueryExecutor e) : super(e);
  $DemoDatabaseManager get managers => $DemoDatabaseManager(this);
  late final $DemosTable demos = $DemosTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [demos];
}

typedef $$DemosTableCreateCompanionBuilder =
    DemosCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      required String demoTextField,
      required double demoDoubleField,
      Value<bool> demoBoolField,
    });
typedef $$DemosTableUpdateCompanionBuilder =
    DemosCompanion Function({
      Value<int> id,
      Value<DateTime> createdAt,
      Value<DateTime?> updatedAt,
      Value<String> demoTextField,
      Value<double> demoDoubleField,
      Value<bool> demoBoolField,
    });

class $$DemosTableFilterComposer extends Composer<_$DemoDatabase, $DemosTable> {
  $$DemosTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get demoTextField => $composableBuilder(
    column: $table.demoTextField,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<double> get demoDoubleField => $composableBuilder(
    column: $table.demoDoubleField,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<bool> get demoBoolField => $composableBuilder(
    column: $table.demoBoolField,
    builder: (column) => ColumnFilters(column),
  );
}

class $$DemosTableOrderingComposer
    extends Composer<_$DemoDatabase, $DemosTable> {
  $$DemosTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<int> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get updatedAt => $composableBuilder(
    column: $table.updatedAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get demoTextField => $composableBuilder(
    column: $table.demoTextField,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<double> get demoDoubleField => $composableBuilder(
    column: $table.demoDoubleField,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<bool> get demoBoolField => $composableBuilder(
    column: $table.demoBoolField,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$DemosTableAnnotationComposer
    extends Composer<_$DemoDatabase, $DemosTable> {
  $$DemosTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<int> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<DateTime> get updatedAt =>
      $composableBuilder(column: $table.updatedAt, builder: (column) => column);

  GeneratedColumn<String> get demoTextField => $composableBuilder(
    column: $table.demoTextField,
    builder: (column) => column,
  );

  GeneratedColumn<double> get demoDoubleField => $composableBuilder(
    column: $table.demoDoubleField,
    builder: (column) => column,
  );

  GeneratedColumn<bool> get demoBoolField => $composableBuilder(
    column: $table.demoBoolField,
    builder: (column) => column,
  );
}

class $$DemosTableTableManager
    extends
        RootTableManager<
          _$DemoDatabase,
          $DemosTable,
          Demo,
          $$DemosTableFilterComposer,
          $$DemosTableOrderingComposer,
          $$DemosTableAnnotationComposer,
          $$DemosTableCreateCompanionBuilder,
          $$DemosTableUpdateCompanionBuilder,
          (Demo, BaseReferences<_$DemoDatabase, $DemosTable, Demo>),
          Demo,
          PrefetchHooks Function()
        > {
  $$DemosTableTableManager(_$DemoDatabase db, $DemosTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$DemosTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$DemosTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$DemosTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                Value<String> demoTextField = const Value.absent(),
                Value<double> demoDoubleField = const Value.absent(),
                Value<bool> demoBoolField = const Value.absent(),
              }) => DemosCompanion(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                demoTextField: demoTextField,
                demoDoubleField: demoDoubleField,
                demoBoolField: demoBoolField,
              ),
          createCompanionCallback:
              ({
                Value<int> id = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<DateTime?> updatedAt = const Value.absent(),
                required String demoTextField,
                required double demoDoubleField,
                Value<bool> demoBoolField = const Value.absent(),
              }) => DemosCompanion.insert(
                id: id,
                createdAt: createdAt,
                updatedAt: updatedAt,
                demoTextField: demoTextField,
                demoDoubleField: demoDoubleField,
                demoBoolField: demoBoolField,
              ),
          withReferenceMapper: (p0) => p0
              .map((e) => (e.readTable(table), BaseReferences(db, table, e)))
              .toList(),
          prefetchHooksCallback: null,
        ),
      );
}

typedef $$DemosTableProcessedTableManager =
    ProcessedTableManager<
      _$DemoDatabase,
      $DemosTable,
      Demo,
      $$DemosTableFilterComposer,
      $$DemosTableOrderingComposer,
      $$DemosTableAnnotationComposer,
      $$DemosTableCreateCompanionBuilder,
      $$DemosTableUpdateCompanionBuilder,
      (Demo, BaseReferences<_$DemoDatabase, $DemosTable, Demo>),
      Demo,
      PrefetchHooks Function()
    >;

class $DemoDatabaseManager {
  final _$DemoDatabase _db;
  $DemoDatabaseManager(this._db);
  $$DemosTableTableManager get demos =>
      $$DemosTableTableManager(_db, _db.demos);
}
