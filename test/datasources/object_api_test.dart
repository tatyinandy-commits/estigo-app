import 'dart:async';

import 'package:dio/dio.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estigo/data/datasources/object_api.dart';

/// A fake interceptor that captures GET requests and returns mock responses.
/// This avoids needing mockito as a dependency.
class _MockInterceptor extends Interceptor {
  final Map<String, dynamic> Function(String path) responseBuilder;
  int callCount = 0;

  _MockInterceptor(this.responseBuilder);

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    callCount++;
    final data = responseBuilder(options.path);
    handler.resolve(
      Response(
        requestOptions: options,
        data: data,
        statusCode: 200,
      ),
    );
  }
}

Dio _createMockDio(_MockInterceptor interceptor) {
  final dio = Dio(BaseOptions(baseUrl: 'https://fake.api'));
  dio.interceptors.add(interceptor);
  return dio;
}

Map<String, dynamic> _fakeObjectResponse() {
  return {
    'data': [
      {
        'id': 'obj_001',
        'name': 'Hotel Riviera',
        'nameRu': 'Отель Ривьера',
        'location': 'Barcelona, Spain',
        'locationRu': 'Барселона, Испания',
        'country': 'Spain',
        'totalRooms': 50,
        'totalShares': 5000,
        'sharePrice': 100.0,
        'currency': 'EUR',
        'occupancyRate': 85.5,
        'annualRevenue': 2000000.0,
        'operatingExpenses': 800000.0,
        'netProfit': 1200000.0,
        'profitMargin': 60.0,
        'description': 'A beautiful hotel',
        'descriptionRu': 'Красивый отель',
        'imageUrl': 'https://example.com/hotel.jpg',
        'status': 'active',
        'yearBuilt': 2010,
        'lastRenovation': 2023,
        'amenities': ['pool', 'spa'],
        'rooms': [
          {
            'id': 'room_001',
            'number': '101',
            'typeId': 'type_standard',
            'floor': 1,
            'totalShares': 100,
            'availableShares': 30,
            'soldShares': 70,
            'sharePrice': 100.0,
            'occupancyRate': 90.0,
            'monthlyRevenue': 5000.0,
            'status': 'active',
            'objectId': 'obj_001',
          }
        ],
        'roomTypes': [
          {
            'id': 'type_standard',
            'name': 'Standard',
            'nameRu': 'Стандарт',
            'pricePerNight': 120.0,
            'description': 'A standard room',
          }
        ],
        'revenueBreakdown': [
          {
            'category': 'Room bookings',
            'categoryRu': 'Бронирование номеров',
            'amount': 1500000.0,
            'percent': 75.0,
          }
        ],
      }
    ],
  };
}

void main() {
  group('ObjectApi.clearCache', () {
    test('clears cached data so next call fetches again', () async {
      final interceptor = _MockInterceptor((_) => _fakeObjectResponse());
      final dio = _createMockDio(interceptor);
      final api = ObjectApi(dio);

      // First call — hits the "network"
      await api.getObject();
      expect(interceptor.callCount, 1);

      // Second call — should use cache
      await api.getObject();
      expect(interceptor.callCount, 1);

      // Clear cache
      api.clearCache();

      // Third call — should hit the network again
      await api.getObject();
      expect(interceptor.callCount, 2);
    });
  });

  group('ObjectApi caching', () {
    test('second call within 30s uses cache (no extra network call)', () async {
      final interceptor = _MockInterceptor((_) => _fakeObjectResponse());
      final dio = _createMockDio(interceptor);
      final api = ObjectApi(dio);

      // First call
      final obj1 = await api.getObject();
      expect(interceptor.callCount, 1);

      // Second call — should be cached
      final obj2 = await api.getObject();
      expect(interceptor.callCount, 1);

      // Both should return the same data
      expect(obj1.id, obj2.id);
      expect(obj1.name, obj2.name);
    });

    test('getObject returns correctly parsed PropertyObject', () async {
      final interceptor = _MockInterceptor((_) => _fakeObjectResponse());
      final dio = _createMockDio(interceptor);
      final api = ObjectApi(dio);

      final obj = await api.getObject();

      expect(obj.id, 'obj_001');
      expect(obj.name, 'Hotel Riviera');
      expect(obj.nameRu, 'Отель Ривьера');
      expect(obj.totalRooms, 50);
      expect(obj.sharePrice, 100.0);
      expect(obj.occupancyRate, 85.5);
    });

    test('getRooms returns parsed rooms from cached object', () async {
      final interceptor = _MockInterceptor((_) => _fakeObjectResponse());
      final dio = _createMockDio(interceptor);
      final api = ObjectApi(dio);

      final rooms = await api.getRooms();

      expect(rooms.length, 1);
      expect(rooms[0].number, '101');
      expect(rooms[0].totalShares, 100);
      expect(rooms[0].soldShares, 70);

      // Should have used only 1 network call (cached for rooms)
      expect(interceptor.callCount, 1);
    });

    test('getRoomTypes returns parsed room types from cached object', () async {
      final interceptor = _MockInterceptor((_) => _fakeObjectResponse());
      final dio = _createMockDio(interceptor);
      final api = ObjectApi(dio);

      final types = await api.getRoomTypes();

      expect(types.length, 1);
      expect(types[0].name, 'Standard');
      expect(types[0].pricePerNight, 120.0);
    });

    test('getRevenueBreakdown returns parsed revenue data', () async {
      final interceptor = _MockInterceptor((_) => _fakeObjectResponse());
      final dio = _createMockDio(interceptor);
      final api = ObjectApi(dio);

      final revenue = await api.getRevenueBreakdown();

      expect(revenue.length, 1);
      expect(revenue[0].category, 'Room bookings');
      expect(revenue[0].amount, 1500000.0);
      expect(revenue[0].percent, 75.0);
    });

    test('multiple method calls share the same cache', () async {
      final interceptor = _MockInterceptor((_) => _fakeObjectResponse());
      final dio = _createMockDio(interceptor);
      final api = ObjectApi(dio);

      // Call multiple methods — all should share 1 network call
      await api.getObject();
      await api.getRooms();
      await api.getRoomTypes();
      await api.getRevenueBreakdown();

      expect(interceptor.callCount, 1);
    });
  });

  group('ObjectApi.getObjectById', () {
    test('fetches object by id (bypasses cache)', () async {
      final interceptor = _MockInterceptor((path) {
        if (path == '/objects/obj_001') {
          return {
            'data': {
              'id': 'obj_001',
              'name': 'Hotel Riviera',
              'nameRu': 'Отель Ривьера',
              'location': 'Barcelona, Spain',
              'locationRu': 'Барселона, Испания',
              'country': 'Spain',
              'totalRooms': 50,
              'totalShares': 5000,
              'sharePrice': 100.0,
              'currency': 'EUR',
              'occupancyRate': 85.5,
              'annualRevenue': 2000000.0,
              'operatingExpenses': 800000.0,
              'netProfit': 1200000.0,
              'profitMargin': 60.0,
              'description': 'A beautiful hotel',
              'descriptionRu': 'Красивый отель',
              'imageUrl': 'https://example.com/hotel.jpg',
            }
          };
        }
        return _fakeObjectResponse();
      });
      final dio = _createMockDio(interceptor);
      final api = ObjectApi(dio);

      final obj = await api.getObjectById('obj_001');

      expect(obj.id, 'obj_001');
      expect(obj.name, 'Hotel Riviera');
      expect(interceptor.callCount, 1);
    });
  });
}
