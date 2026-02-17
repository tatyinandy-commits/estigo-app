import 'package:dio/dio.dart';
import '../models/models.dart';

class ObjectApi {
  final Dio _dio;

  ObjectApi(this._dio);

  Future<PropertyObject> getObject() async {
    final response = await _dio.get('/object');
    return PropertyObject.fromJson(response.data['data']);
  }

  Future<List<Room>> getRooms() async {
    final response = await _dio.get('/object/rooms');
    final list = response.data['data'] as List;
    return list.map((e) => Room.fromJson(e)).toList();
  }

  Future<List<RoomType>> getRoomTypes() async {
    final response = await _dio.get('/object/room-types');
    final list = response.data['data'] as List;
    return list.map((e) => RoomType.fromJson(e)).toList();
  }

  Future<List<RevenueBreakdown>> getRevenueBreakdown() async {
    final response = await _dio.get('/object/revenue-breakdown');
    final list = response.data['data'] as List;
    return list.map((e) => RevenueBreakdown.fromJson(e)).toList();
  }

  Future<List<MonthlyIncome>> getMonthlyIncome() async {
    final response = await _dio.get('/object/monthly-income');
    final list = response.data['data'] as List;
    return list.map((e) => MonthlyIncome.fromJson(e)).toList();
  }
}
