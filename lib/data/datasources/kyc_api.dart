import 'package:dio/dio.dart';

class KycApi {
  final Dio _dio;

  KycApi(this._dio);

  /// Creates a Stripe Identity verification session.
  /// Returns { clientSecret: String } for launching Stripe Identity.
  Future<String> createSession() async {
    final response = await _dio.post('/kyc/session');
    return response.data['data']['clientSecret'] as String;
  }

  /// Returns the current KYC status for the authenticated user.
  Future<Map<String, dynamic>> getStatus() async {
    final response = await _dio.get('/kyc/status');
    return response.data['data'] as Map<String, dynamic>;
  }
}
