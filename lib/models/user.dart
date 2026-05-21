import 'package:json_annotation/json_annotation.dart';

part 'user.g.dart';

/* 
 * 角色枚举
 */
enum UserRole {
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
 * User信息
 */
@JsonSerializable()
class IUser {
  IUser({
    required this.userId,
    required this.name,
    this.role,
  });

  final String userId;
  final String name; // 名称
  final UserRole? role; // 角色


  factory IUser.fromJson(json) => _$IUserFromJson(json);

  Map<String, dynamic> toJson() => _$IUserToJson(this);
}