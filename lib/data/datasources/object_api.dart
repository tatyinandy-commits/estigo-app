import 'package:dio/dio.dart';
import '../models/models.dart';

class ObjectApi {
  final Dio _dio;

  ObjectApi(this._dio);

  Future<PropertyObject> getObject() async {
    final response = await _dio.get('/objects');
    // API returns array of objects, take first one
    final data = response.data['data'];
    if (data is List && data.isNotEmpty) {
      return PropertyObject.fromJson(data[0]);
    }
    return PropertyObject.fromJson(data);
  }

  Future<PropertyObject> getObjectById(String id) async {
    final response = await _dio.get('/objects/$id');
    return PropertyObject.fromJson(response.data['data']);
  }

  Future<List<Room>> getRooms() async {
    final response = await _dio.get('/objects');
    final data = response.data['data'];
    final object = data is List ? data[0] : data;
    final rooms = object['rooms'] as List? ?? [];
    return rooms.map((e) => Room.fromJson(e)).toList();
  }

  Future<List<RoomType>> getRoomTypes() async {
    final response = await _dio.get('/objects');
    final data = response.data['data'];
    final object = data is List ? data[0] : data;
    final types = object['roomTypes'] as List? ?? [];
    return types.map((e) => RoomType.fromJson(e)).toList();
  }

  Future<List<RevenueBreakdown>> getRevenueBreakdown() async {
    final response = await _dio.get('/objects');
    final data = response.data['data'];
    final object = data is List ? data[0] : data;
    final revenue = object['revenueBreakdown'] as List? ?? [];
    return revenue.map((e) => RevenueBreakdown.fromJson(e)).toList();
  }

  Future<List<MonthlyIncome>> getMonthlyIncome() async {
    // Get monthly reports from the object itself
    try {
      final response = await _dio.get('/objects');
      final data = response.data['data'];
      final object = data is List ? data[0] : data;
      final objectId = object['id']?.toString() ?? '';
      if (objectId.isEmpty) return [];

      final incomeResponse = await _dio.get('/income/reports/$objectId');
      final list = incomeResponse.data['data'] as List? ?? [];
      return list.map((e) => MonthlyIncome.fromJson(e)).toList();
    } catch (_) {
      return [];
    }
  }
}
