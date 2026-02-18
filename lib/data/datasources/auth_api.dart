import 'package:dio/dio.dart';
import '../models/models.dart';

class AuthApi {
  final Dio _dio;

  AuthApi(this._dio);

  Future<LoginResponse> login(String email, String password) async {
    final response = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
    });
    return LoginResponse.fromJson(response.data['data']);
  }

  Future<LoginResponse> register(
    String name,
    String email,
    String password, {
    String? referralCode,
  }) async {
    final response = await _dio.post('/auth/register', data: {
      'name': name,
      'email': email,
      'password': password,
      if (referralCode != null) 'referralCode': referralCode,
    });
    return LoginResponse.fromJson(response.data['data']);
  }

  Future<LoginResponse> googleAuth(String idToken) async {
    final response = await _dio.post('/auth/google', data: {
      'idToken': idToken,
    });
    return LoginResponse.fromJson(response.data['data']);
  }

  Future<LoginResponse> appleAuth(
    String idToken, {
    String? firstName,
    String? lastName,
    String? email,
  }) async {
    final response = await _dio.post('/auth/apple', data: {
      'idToken': idToken,
      if (firstName != null || lastName != null || email != null)
        'user': {
          if (email != null) 'email': email,
          if (firstName != null || lastName != null)
            'name': {
              if (firstName != null) 'firstName': firstName,
              if (lastName != null) 'lastName': lastName,
            },
        },
    });
    return LoginResponse.fromJson(response.data['data']);
  }

  Future<User> getMe() async {
    final response = await _dio.get('/auth/me');
    return User.fromJson(response.data['data']);
  }

  Future<LoginResponse> refresh({String? refreshToken}) async {
    final response = await _dio.post('/auth/refresh', data: {
      if (refreshToken != null) 'refreshToken': refreshToken,
    });
    return LoginResponse.fromJson(response.data['data']);
  }

  Future<void> logout() async {
    await _dio.post('/auth/logout');
  }

  Future<void> forgotPassword(String email) async {
    await _dio.post('/auth/forgot-password', data: {'email': email});
  }

  Future<void> resetPassword(String token, String password) async {
    await _dio.post('/auth/reset-password', data: {
      'token': token,
      'password': password,
    });
  }

  Future<void> verifyEmail(String token) async {
    await _dio.post('/auth/verify-email', data: {'token': token});
  }

  Future<void> resendVerification() async {
    await _dio.post('/auth/resend-verification');
  }

  Future<List<Map<String, dynamic>>> getLoginHistory() async {
    final response = await _dio.get('/auth/login-history');
    return List<Map<String, dynamic>>.from(response.data['data']);
  }

  Future<Map<String, dynamic>> setup2FA() async {
    final response = await _dio.post('/auth/2fa/setup');
    return response.data['data'];
  }

  Future<void> verify2FA(String code) async {
    await _dio.post('/auth/2fa/verify', data: {'code': code});
  }

  Future<void> disable2FA(String code) async {
    await _dio.post('/auth/2fa/disable', data: {'code': code});
  }

  Future<LoginResponse> login2FA(
      String email, String password, String code) async {
    final response = await _dio.post('/auth/login', data: {
      'email': email,
      'password': password,
      'twoFactorCode': code,
    });
    return LoginResponse.fromJson(response.data['data']);
  }
}
