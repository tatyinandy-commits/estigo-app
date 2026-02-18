import 'package:dio/dio.dart';
import '../models/models.dart';

class UserApi {
  final Dio _dio;

  UserApi(this._dio);

  Future<User> updateProfile({String? name, String? phone}) async {
    final response = await _dio.put('/auth/profile', data: {
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
    });
    return User.fromJson(response.data['data']);
  }

  Future<void> changePassword(
    String current,
    String newPassword,
    String confirmPassword,
  ) async {
    await _dio.put('/auth/password', data: {
      'currentPassword': current,
      'newPassword': newPassword,
      'confirmPassword': confirmPassword,
    });
  }

  Future<List<Map<String, dynamic>>> getSessions() async {
    final response = await _dio.get('/auth/sessions');
    return List<Map<String, dynamic>>.from(response.data['data']);
  }

  Future<void> revokeSession(String sessionId) async {
    await _dio.delete('/auth/sessions/$sessionId');
  }

  Future<PartnerData> getPartnerData() async {
    final response = await _dio.get('/partner/dashboard');
    return PartnerData.fromJson(response.data['data']);
  }

  Future<List<AppNotification>> getNotifications() async {
    final response = await _dio.get('/notifications');
    final list = response.data['data']['notifications'] as List;
    return list.map((e) => AppNotification.fromJson(e)).toList();
  }

  Future<void> markNotificationRead(String id) async {
    await _dio.post('/notifications/$id/read');
  }

  Future<void> markAllNotificationsRead() async {
    await _dio.post('/notifications/read-all');
  }

  Future<void> deleteNotification(String id) async {
    await _dio.delete('/notifications/$id');
  }

  Future<void> registerDevice(String token, String platform) async {
    await _dio.post('/notifications/register-device', data: {
      'token': token,
      'platform': platform,
    });
  }

  Future<void> unregisterDevice(String token) async {
    await _dio.post('/notifications/unregister-device', data: {
      'token': token,
    });
  }
}
