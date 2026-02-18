import 'package:freezed_annotation/freezed_annotation.dart';

part 'admin.freezed.dart';
part 'admin.g.dart';

@freezed
class AdminUser with _$AdminUser {
  const factory AdminUser({
    required String id,
    required String email,
    required String name,
    @Default(0) double balance,
    @Default('INVESTOR') String role,
    @Default([]) List<String> roles,
    @Default('NONE') String kycStatus,
    @Default(false) bool emailVerified,
    String? lockedUntil,
    String? locale,
    required String createdAt,
    @JsonKey(name: '_count') AdminUserCount? count,
  }) = _AdminUser;

  factory AdminUser.fromJson(Map<String, dynamic> json) =>
      _$AdminUserFromJson(json);
}

@freezed
class AdminUserCount with _$AdminUserCount {
  const factory AdminUserCount({
    @Default(0) int shareOwnerships,
    @Default(0) int transactions,
  }) = _AdminUserCount;

  factory AdminUserCount.fromJson(Map<String, dynamic> json) =>
      _$AdminUserCountFromJson(json);
}

@freezed
class AdminStats with _$AdminStats {
  const factory AdminStats({
    @Default(0) int totalUsers,
    @Default(0) int totalInvestors,
    @Default(0) int totalTransactions,
    @Default(0) int activeP2POrders,
    @Default(0) int pendingPayouts,
    @Default(0) double totalBalance,
    @Default(0) double portfolioValue,
  }) = _AdminStats;

  factory AdminStats.fromJson(Map<String, dynamic> json) =>
      _$AdminStatsFromJson(json);
}

@freezed
class AuditLog with _$AuditLog {
  const factory AuditLog({
    required String id,
    String? userId,
    required String action,
    String? details,
    String? ip,
    String? userAgent,
    required String createdAt,
    AuditLogUser? user,
  }) = _AuditLog;

  factory AuditLog.fromJson(Map<String, dynamic> json) =>
      _$AuditLogFromJson(json);
}

@freezed
class AuditLogUser with _$AuditLogUser {
  const factory AuditLogUser({
    required String id,
    required String name,
    required String email,
  }) = _AuditLogUser;

  factory AuditLogUser.fromJson(Map<String, dynamic> json) =>
      _$AuditLogUserFromJson(json);
}

class AdminUsersResponse {
  final List<AdminUser> users;
  final int total;
  final int totalPages;

  const AdminUsersResponse({
    required this.users,
    required this.total,
    required this.totalPages,
  });
}

class AuditLogsResponse {
  final List<AuditLog> logs;
  final int total;
  final int totalPages;

  const AuditLogsResponse({
    required this.logs,
    required this.total,
    required this.totalPages,
  });
}
