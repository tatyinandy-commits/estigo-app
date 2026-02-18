import 'package:dio/dio.dart';
import '../models/models.dart';

class AdminApi {
  final Dio _dio;

  AdminApi(this._dio);

  Future<bool> verifySecret(String secret) async {
    final response = await _dio.post('/admin/verify-secret', data: {
      'secret': secret,
    });
    return response.data['valid'] == true;
  }

  Future<AdminUsersResponse> getUsers({
    int page = 1,
    int limit = 20,
    String? search,
  }) async {
    final response = await _dio.get('/admin/users', queryParameters: {
      'page': page,
      'limit': limit,
      if (search != null && search.isNotEmpty) 'search': search,
    });
    final list = response.data['data'] as List;
    final users = list.map((e) => AdminUser.fromJson(e)).toList();
    final pagination = response.data['pagination'] as Map<String, dynamic>?;
    return AdminUsersResponse(
      users: users,
      total: pagination?['total'] ?? users.length,
      totalPages: pagination?['totalPages'] ?? 1,
    );
  }

  Future<AdminUser> updateUser(String id, Map<String, dynamic> data) async {
    final response = await _dio.patch('/admin/users/$id', data: data);
    return AdminUser.fromJson(response.data['data']);
  }

  Future<void> deleteUser(String id) async {
    await _dio.delete('/admin/users/$id');
  }

  Future<AdminStats> getStats() async {
    final response = await _dio.get('/admin/stats');
    return AdminStats.fromJson(response.data['data']);
  }

  Future<List<Map<String, dynamic>>> getPartners() async {
    final response = await _dio.get('/admin/partners');
    return List<Map<String, dynamic>>.from(response.data['data']);
  }

  Future<List<Payment>> getPayments({
    int page = 1,
    int limit = 20,
    String? status,
    String? provider,
  }) async {
    final response = await _dio.get('/admin/payments', queryParameters: {
      'page': page,
      'limit': limit,
      if (status != null) 'status': status,
      if (provider != null) 'provider': provider,
    });
    final list = response.data['data'] as List;
    return list.map((e) => Payment.fromJson(e)).toList();
  }

  Future<List<Map<String, dynamic>>> getPayouts({String? status}) async {
    final response = await _dio.get('/admin/payouts', queryParameters: {
      if (status != null) 'status': status,
    });
    return List<Map<String, dynamic>>.from(response.data['data']);
  }

  Future<void> approvePayout(String id) async {
    await _dio.post('/admin/payouts/$id/approve');
  }

  Future<void> rejectPayout(String id, {String? reason}) async {
    await _dio.post('/admin/payouts/$id/reject', data: {
      if (reason != null) 'reason': reason,
    });
  }

  Future<void> createReport(Map<String, dynamic> data) async {
    await _dio.post('/admin/reports', data: data);
  }

  Future<void> distributeIncome(String reportId) async {
    await _dio.post('/admin/reports/$reportId/distribute');
  }

  Future<AuditLogsResponse> getAuditLogs({
    int page = 1,
    int limit = 20,
    String? action,
    String? userId,
    String? dateFrom,
    String? dateTo,
    String? search,
  }) async {
    final response = await _dio.get('/admin/audit-logs', queryParameters: {
      'page': page,
      'limit': limit,
      if (action != null) 'action': action,
      if (userId != null) 'userId': userId,
      if (dateFrom != null) 'dateFrom': dateFrom,
      if (dateTo != null) 'dateTo': dateTo,
      if (search != null && search.isNotEmpty) 'search': search,
    });
    final list = response.data['data'] as List;
    final logs = list.map((e) => AuditLog.fromJson(e)).toList();
    final pagination = response.data['pagination'] as Map<String, dynamic>?;
    return AuditLogsResponse(
      logs: logs,
      total: pagination?['total'] ?? logs.length,
      totalPages: pagination?['totalPages'] ?? 1,
    );
  }

  // Admin support ticket management
  Future<List<Map<String, dynamic>>> getAllTickets({String? status}) async {
    final response = await _dio.get('/support/admin/all', queryParameters: {
      if (status != null) 'status': status,
    });
    return List<Map<String, dynamic>>.from(response.data['data']);
  }

  Future<void> updateTicketStatus(String id, String status) async {
    await _dio.put('/support/admin/$id/status', data: {
      'status': status,
    });
  }
}
