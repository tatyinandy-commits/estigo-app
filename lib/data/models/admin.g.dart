// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AdminUserImpl _$$AdminUserImplFromJson(Map<String, dynamic> json) =>
    _$AdminUserImpl(
      id: json['id'] as String,
      email: json['email'] as String,
      name: json['name'] as String,
      balance: (json['balance'] as num?)?.toDouble() ?? 0,
      role: json['role'] as String? ?? 'INVESTOR',
      roles:
          (json['roles'] as List<dynamic>?)?.map((e) => e as String).toList() ??
              const [],
      kycStatus: json['kycStatus'] as String? ?? 'NONE',
      emailVerified: json['emailVerified'] as bool? ?? false,
      lockedUntil: json['lockedUntil'] as String?,
      locale: json['locale'] as String?,
      createdAt: json['createdAt'] as String,
      count: json['_count'] == null
          ? null
          : AdminUserCount.fromJson(json['_count'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AdminUserImplToJson(_$AdminUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'name': instance.name,
      'balance': instance.balance,
      'role': instance.role,
      'roles': instance.roles,
      'kycStatus': instance.kycStatus,
      'emailVerified': instance.emailVerified,
      'lockedUntil': instance.lockedUntil,
      'locale': instance.locale,
      'createdAt': instance.createdAt,
      '_count': instance.count,
    };

_$AdminUserCountImpl _$$AdminUserCountImplFromJson(Map<String, dynamic> json) =>
    _$AdminUserCountImpl(
      shareOwnerships: (json['shareOwnerships'] as num?)?.toInt() ?? 0,
      transactions: (json['transactions'] as num?)?.toInt() ?? 0,
    );

Map<String, dynamic> _$$AdminUserCountImplToJson(
        _$AdminUserCountImpl instance) =>
    <String, dynamic>{
      'shareOwnerships': instance.shareOwnerships,
      'transactions': instance.transactions,
    };

_$AdminStatsImpl _$$AdminStatsImplFromJson(Map<String, dynamic> json) =>
    _$AdminStatsImpl(
      totalUsers: (json['totalUsers'] as num?)?.toInt() ?? 0,
      totalInvestors: (json['totalInvestors'] as num?)?.toInt() ?? 0,
      totalTransactions: (json['totalTransactions'] as num?)?.toInt() ?? 0,
      activeP2POrders: (json['activeP2POrders'] as num?)?.toInt() ?? 0,
      pendingPayouts: (json['pendingPayouts'] as num?)?.toInt() ?? 0,
      totalBalance: (json['totalBalance'] as num?)?.toDouble() ?? 0,
      portfolioValue: (json['portfolioValue'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$AdminStatsImplToJson(_$AdminStatsImpl instance) =>
    <String, dynamic>{
      'totalUsers': instance.totalUsers,
      'totalInvestors': instance.totalInvestors,
      'totalTransactions': instance.totalTransactions,
      'activeP2POrders': instance.activeP2POrders,
      'pendingPayouts': instance.pendingPayouts,
      'totalBalance': instance.totalBalance,
      'portfolioValue': instance.portfolioValue,
    };

_$AuditLogImpl _$$AuditLogImplFromJson(Map<String, dynamic> json) =>
    _$AuditLogImpl(
      id: json['id'] as String,
      userId: json['userId'] as String?,
      action: json['action'] as String,
      details: json['details'] as String?,
      ip: json['ip'] as String?,
      userAgent: json['userAgent'] as String?,
      createdAt: json['createdAt'] as String,
      user: json['user'] == null
          ? null
          : AuditLogUser.fromJson(json['user'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$$AuditLogImplToJson(_$AuditLogImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'userId': instance.userId,
      'action': instance.action,
      'details': instance.details,
      'ip': instance.ip,
      'userAgent': instance.userAgent,
      'createdAt': instance.createdAt,
      'user': instance.user,
    };

_$AuditLogUserImpl _$$AuditLogUserImplFromJson(Map<String, dynamic> json) =>
    _$AuditLogUserImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      email: json['email'] as String,
    );

Map<String, dynamic> _$$AuditLogUserImplToJson(_$AuditLogUserImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
    };
