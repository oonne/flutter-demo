// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IUser _$IUserFromJson(Map<String, dynamic> json) => IUser(
  userId: json['userId'] as String,
  name: json['name'] as String,
  role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']),
);

Map<String, dynamic> _$IUserToJson(IUser instance) => <String, dynamic>{
  'userId': instance.userId,
  'name': instance.name,
  'role': _$UserRoleEnumMap[instance.role],
};

const _$UserRoleEnumMap = {
  UserRole.role1: 1,
  UserRole.role2: 2,
  UserRole.role3: 3,
  UserRole.role4: 4,
};
