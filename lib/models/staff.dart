import 'package:json_annotation/json_annotation.dart';

part 'staff.g.dart';

/* 
 * 角色枚举
 */
enum StaffRole {
  @JsonValue(1)
  role1,
  @JsonValue(2)
  role2,
  @JsonValue(3)
  role3,
  @JsonValue(4)
  role4,
}

/* 
 * Staff信息
 */
@JsonSerializable()
class IStaff {
  IStaff({
    required this.staffId,
    required this.name,
    this.role,
  });

  final String staffId;
  final String name; // 名称
  final StaffRole? role; // 角色


  factory IStaff.fromJson(json) => _$IStaffFromJson(json);

  Map<String, dynamic> toJson() => _$IStaffToJson(this);
}