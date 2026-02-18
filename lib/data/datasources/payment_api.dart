import 'package:dio/dio.dart';
import '../models/models.dart';

class PaymentApi {
  final Dio _dio;

  PaymentApi(this._dio);

  Future<CheckoutSession> createStripeCheckout({
    required String purpose,
    required double amount,
    String? roomId,
    int? shares,
  }) async {
    final response = await _dio.post('/payments/stripe/checkout', data: {
      'purpose': purpose,
      'amount': amount,
      if (roomId != null) 'roomId': roomId,
      if (shares != null) 'shares': shares,
    });
    return CheckoutSession.fromJson(response.data['data']);
  }

  Future<Map<String, dynamic>> createCryptoPayment({
    required String purpose,
    required double amount,
    String? roomId,
    int? shares,
  }) async {
    final response = await _dio.post('/payments/nowpayments/invoice', data: {
      'purpose': purpose,
      'amount': amount,
      if (roomId != null) 'roomId': roomId,
      if (shares != null) 'shares': shares,
    });
    return response.data['data'];
  }

  Future<void> payFromBalance({
    required String roomId,
    required int amount,
  }) async {
    await _dio.post('/payments/buy-from-balance', data: {
      'roomId': roomId,
      'amount': amount,
    });
  }

  Future<List<Payment>> getPayments({int page = 1, int limit = 20}) async {
    final response = await _dio.get('/payments', queryParameters: {
      'page': page,
      'limit': limit,
    });
    final list = response.data['data'] as List;
    return list.map((e) => Payment.fromJson(e)).toList();
  }

  Future<Payment> getPayment(String id) async {
    final response = await _dio.get('/payments/$id');
    return Payment.fromJson(response.data['data']);
  }
}
