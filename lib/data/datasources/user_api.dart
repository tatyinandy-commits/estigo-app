import 'package:dio/dio.dart';
import '../models/models.dart';

class UserApi {
  final Dio _dio;

  UserApi(this._dio);

  Future<User> updateProfile({String? name, String? phone}) async {
    final response = await _dio.put('/user/profile', data: {
      if (name != null) 'name': name,
      if (phone != null) 'phone': phone,
    });
    return User.fromJson(response.data['data']);
  }

  Future<void> changePassword(String current, String newPassword) async {
    await _dio.put('/user/password', data: {
      'currentPassword': current,
      'newPassword': newPassword,
    });
  }

  Future<List<Map<String, dynamic>>> getSessions() async {
    final response = await _dio.get('/user/sessions');
    return List<Map<String, dynamic>>.from(response.data['data']);
  }

  Future<void> revokeSession(String sessionId) async {
    await _dio.delete('/user/sessions/$sessionId');
  }

  Future<PartnerData> getPartnerData() async {
    final response = await _dio.get('/partner');
    return PartnerData.fromJson(response.data['data']);
  }

  Future<List<AppNotification>> getNotifications() async {
    final response = await _dio.get('/notifications');
    final list = response.data['data'] as List;
    return list.map((e) => AppNotification.fromJson(e)).toList();
  }

  Future<void> markNotificationRead(String id) async {
    await _dio.put('/notifications/$id/read');
  }

  Future<void> markAllNotificationsRead() async {
    await _dio.put('/notifications/read-all');
  }
}
