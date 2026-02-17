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
    final response = await _dio.post('/payments/crypto/create', data: {
      'purpose': purpose,
      'amount': amount,
      if (roomId != null) 'roomId': roomId,
      if (shares != null) 'shares': shares,
    });
    return response.data['data'];
  }

  Future<void> payFromBalance({
    required String roomId,
    required int shares,
  }) async {
    await _dio.post('/payments/balance', data: {
      'roomId': roomId,
      'shares': shares,
    });
  }
}
