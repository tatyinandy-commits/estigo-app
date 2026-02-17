import 'package:dio/dio.dart';
import '../models/models.dart';

class PortfolioApi {
  final Dio _dio;

  PortfolioApi(this._dio);

  Future<List<UserShare>> getPortfolio() async {
    final response = await _dio.get('/portfolio');
    final list = response.data['data'] as List;
    return list.map((e) => UserShare.fromJson(e)).toList();
  }

  Future<void> buyShares(String roomId, int shares, String paymentMethod) async {
    await _dio.post('/portfolio/buy', data: {
      'roomId': roomId,
      'shares': shares,
      'paymentMethod': paymentMethod,
    });
  }
}
