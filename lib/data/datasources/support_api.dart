import 'package:dio/dio.dart';

class SupportApi {
  final Dio _dio;

  SupportApi(this._dio);

  Future<List<Map<String, dynamic>>> getTickets() async {
    final response = await _dio.get('/support/tickets');
    return List<Map<String, dynamic>>.from(response.data['data']);
  }

  Future<Map<String, dynamic>> createTicket({
    required String subject,
    required String message,
  }) async {
    final response = await _dio.post('/support/tickets', data: {
      'subject': subject,
      'message': message,
    });
    return response.data['data'];
  }
}
