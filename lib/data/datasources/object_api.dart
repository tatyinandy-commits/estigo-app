import 'package:dio/dio.dart';
import '../models/models.dart';

class ObjectApi {
  final Dio _dio;

  ObjectApi(this._dio);

  Map<String, dynamic>? _cachedObject;
  DateTime? _cacheTime;

  static const _cacheDuration = Duration(seconds: 30);

  Future<Map<String, dynamic>> _fetchObject() async {
    final now = DateTime.now();
    if (_cachedObject != null &&
        _cacheTime != null &&
        now.difference(_cacheTime!) < _cacheDuration) {
      return _cachedObject!;
    }

    final response = await _dio.get('/objects');
    final data = response.data['data'];
    final object = (data is List && data.isNotEmpty) ? data[0] : data;

    _cachedObject = Map<String, dynamic>.from(object as Map);
    _cacheTime = now;

    return _cachedObject!;
  }

  void clearCache() {
    _cachedObject = null;
    _cacheTime = null;
  }

  Future<PropertyObject> getObject() async {
    final object = await _fetchObject();
    return PropertyObject.fromJson(object);
  }

  Future<PropertyObject> getObjectById(String id) async {
    final response = await _dio.get('/objects/$id');
    return PropertyObject.fromJson(response.data['data']);
  }

  Future<List<Room>> getRooms() async {
    final object = await _fetchObject();
    final rooms = object['rooms'] as List? ?? [];
    return rooms.map((e) => Room.fromJson(e)).toList();
  }

  Future<List<RoomType>> getRoomTypes() async {
    final object = await _fetchObject();
    final types = object['roomTypes'] as List? ?? [];
    return types.map((e) => RoomType.fromJson(e)).toList();
  }

  Future<List<RevenueBreakdown>> getRevenueBreakdown() async {
    final object = await _fetchObject();
    final revenue = object['revenueBreakdown'] as List? ?? [];
    return revenue.map((e) => RevenueBreakdown.fromJson(e)).toList();
  }

  Future<List<MonthlyIncome>> getMonthlyIncome() async {
    // Get monthly reports from the object itself
    try {
      final object = await _fetchObject();
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
