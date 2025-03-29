// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'staff.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

IStaff _$IStaffFromJson(Map<String, dynamic> json) => IStaff(
  staffId: json['staffId'] as String,
  name: json['name'] as String,
  role: $enumDecodeNullable(_$StaffRoleEnumMap, json['role']),
);

Map<String, dynamic> _$IStaffToJson(IStaff instance) => <String, dynamic>{
  'staffId': instance.staffId,
  'name': instance.name,
  'role': _$StaffRoleEnumMap[instance.role],
};

const _$StaffRoleEnumMap = {
  StaffRole.role1: 1,
  StaffRole.role2: 2,
  StaffRole.role3: 3,
  StaffRole.role4: 4,
};
