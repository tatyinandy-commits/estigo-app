import 'package:dio/dio.dart';
import '../models/models.dart';

class P2PApi {
  final Dio _dio;

  P2PApi(this._dio);

  Future<List<P2POrder>> getOrders() async {
    final response = await _dio.get('/p2p/orders');
    final list = response.data['data'] as List;
    return list.map((e) => P2POrder.fromJson(e)).toList();
  }

  Future<List<P2POrder>> getMyOrders() async {
    final response = await _dio.get('/p2p/my-orders');
    final list = response.data['data'] as List;
    return list.map((e) => P2POrder.fromJson(e)).toList();
  }

  Future<P2POrder> createOrder({
    required String type,
    required String roomId,
    required int shares,
    required double pricePerShare,
  }) async {
    final response = await _dio.post('/p2p/orders', data: {
      'type': type,
      'roomId': roomId,
      'shares': shares,
      'pricePerShare': pricePerShare,
    });
    return P2POrder.fromJson(response.data['data']);
  }

  Future<void> cancelOrder(String orderId) async {
    await _dio.post('/p2p/orders/$orderId/cancel');
  }

  Future<void> executeOrder(String orderId) async {
    await _dio.post('/p2p/orders/$orderId/execute');
  }

  Future<List<P2POrder>> getRecentTrades() async {
    final response = await _dio.get('/p2p/trades');
    final list = response.data['data'] as List;
    return list.map((e) => P2POrder.fromJson(e)).toList();
  }
}
