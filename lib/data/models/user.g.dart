// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserImpl _$$UserImplFromJson(Map<String, dynamic> json) => _$UserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
      phone: json['phone'] as String? ?? '',
      kycStatus: $enumDecodeNullable(_$KycStatusEnumMap, json['kycStatus']) ??
          KycStatus.none,
      role: $enumDecodeNullable(_$UserRoleEnumMap, json['role']) ??
          UserRole.investor,
      roles: (json['roles'] as List<dynamic>?)
              ?.map((e) => $enumDecode(_$UserRoleEnumMap, e))
              .toList() ??
          const [],
      balance: (json['balance'] as num?)?.toDouble() ?? 0,
      avatar: json['avatar'] as String? ?? '',
      registeredAt: json['createdAt'] as String,
      emailVerified: json['emailVerified'] as bool? ?? false,
      twoFactorEnabled: json['twoFactorEnabled'] as bool? ?? false,
      referralCode: json['referralCode'] as String? ?? '',
      referredBy: json['referredBy'] as String?,
    );

Map<String, dynamic> _$$UserImplToJson(_$UserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'phone': instance.phone,
      'kycStatus': _$KycStatusEnumMap[instance.kycStatus]!,
      'role': _$UserRoleEnumMap[instance.role]!,
      'roles': instance.roles.map((e) => _$UserRoleEnumMap[e]!).toList(),
      'balance': instance.balance,
      'avatar': instance.avatar,
      'createdAt': instance.registeredAt,
      'emailVerified': instance.emailVerified,
      'twoFactorEnabled': instance.twoFactorEnabled,
      'referralCode': instance.referralCode,
      'referredBy': instance.referredBy,
    };

const _$KycStatusEnumMap = {
  KycStatus.none: 'NONE',
  KycStatus.pending: 'PENDING',
  KycStatus.verified: 'VERIFIED',
  KycStatus.rejected: 'REJECTED',
};

const _$UserRoleEnumMap = {
  UserRole.investor: 'INVESTOR',
  UserRole.partner: 'PARTNER',
  UserRole.admin: 'ADMIN',
};
