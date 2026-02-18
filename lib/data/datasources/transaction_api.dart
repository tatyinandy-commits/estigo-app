import 'package:dio/dio.dart';
import '../models/models.dart';

class TransactionApi {
  final Dio _dio;

  TransactionApi(this._dio);

  Future<List<Transaction>> getTransactions({
    int page = 1,
    int limit = 20,
    String? type,
  }) async {
    final response = await _dio.get('/portfolio/transactions', queryParameters: {
      'page': page,
      'limit': limit,
      if (type != null) 'type': type,
    });
    final list = response.data['data'] as List;
    return list.map((e) => Transaction.fromJson(e)).toList();
  }

  Future<List<MonthlyIncome>> getIncomeAccruals() async {
    final response = await _dio.get('/income/accruals');
    final list = response.data['data'] as List;
    return list.map((e) => MonthlyIncome.fromJson(e)).toList();
  }

  Future<List<Payout>> getPayouts() async {
    final response = await _dio.get('/income/payouts');
    final list = response.data['data'] as List;
    return list.map((e) => Payout.fromJson(e)).toList();
  }

  Future<void> requestPayout({
    required double amount,
    required String iban,
    required String recipientName,
    String? twoFactorCode,
  }) async {
    await _dio.post('/income/payouts', data: {
      'amount': amount,
      'iban': iban,
      'recipientName': recipientName,
      if (twoFactorCode != null) 'twoFactorCode': twoFactorCode,
    });
  }

  Future<void> deposit(double amount) async {
    await _dio.post('/income/deposit', data: {
      'amount': amount,
    });
  }
}
