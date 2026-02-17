import 'package:flutter_test/flutter_test.dart';
import 'package:estigo/data/models/room.dart';

void main() {
  group('Room.fromJson', () {
    test('parses valid JSON with all fields', () {
      final json = {
        'id': 'room_001',
        'number': '101',
        'typeId': 'type_deluxe',
        'floor': 3,
        'totalShares': 100,
        'availableShares': 25,
        'soldShares': 75,
        'sharePrice': 500.0,
        'occupancyRate': 0.85,
        'monthlyRevenue': 12500.00,
        'status': 'active',
        'objectId': 'obj_001',
      };

      final room = Room.fromJson(json);

      expect(room.id, 'room_001');
      expect(room.number, '101');
      expect(room.typeId, 'type_deluxe');
      expect(room.floor, 3);
      expect(room.totalShares, 100);
      expect(room.availableShares, 25);
      expect(room.soldShares, 75);
      expect(room.sharePrice, 500.0);
      expect(room.occupancyRate, 0.85);
      expect(room.monthlyRevenue, 12500.00);
      expect(room.status, RoomStatus.active);
      expect(room.objectId, 'obj_001');
    });

    test('defaults status to active when absent', () {
      final json = {
        'id': 'room_002',
        'number': '202',
        'typeId': 'type_standard',
        'floor': 2,
        'totalShares': 50,
        'availableShares': 50,
        'soldShares': 0,
        'sharePrice': 300.0,
        'occupancyRate': 0.0,
        'monthlyRevenue': 0.0,
        'objectId': 'obj_002',
      };

      final room = Room.fromJson(json);

      expect(room.status, RoomStatus.active);
    });

    test('parses all RoomStatus values correctly', () {
      final statuses = {
        'active': RoomStatus.active,
        'renovation': RoomStatus.renovation,
        'upcoming': RoomStatus.upcoming,
      };

      for (final entry in statuses.entries) {
        final json = {
          'id': 'room_status_${entry.key}',
          'number': '100',
          'typeId': 'type_test',
          'floor': 1,
          'totalShares': 10,
          'availableShares': 5,
          'soldShares': 5,
          'sharePrice': 100.0,
          'occupancyRate': 0.5,
          'monthlyRevenue': 1000.0,
          'status': entry.key,
          'objectId': 'obj_test',
        };

        final room = Room.fromJson(json);
        expect(room.status, entry.value,
            reason: 'Failed for status: ${entry.key}');
      }
    });

    test('parses sharePrice as int via toDouble()', () {
      final json = {
        'id': 'room_003',
        'number': '303',
        'typeId': 'type_suite',
        'floor': 5,
        'totalShares': 200,
        'availableShares': 100,
        'soldShares': 100,
        'sharePrice': 750, // int, not double
        'occupancyRate': 0.9,
        'monthlyRevenue': 25000,
        'objectId': 'obj_003',
      };

      final room = Room.fromJson(json);

      expect(room.sharePrice, isA<double>());
      expect(room.sharePrice, 750.0);
      expect(room.monthlyRevenue, isA<double>());
      expect(room.monthlyRevenue, 25000.0);
    });

    test('all numeric fields are correctly typed', () {
      final json = {
        'id': 'room_004',
        'number': '404',
        'typeId': 'type_basic',
        'floor': 1,
        'totalShares': 10,
        'availableShares': 3,
        'soldShares': 7,
        'sharePrice': 99.99,
        'occupancyRate': 0.72,
        'monthlyRevenue': 4500.50,
        'objectId': 'obj_004',
      };

      final room = Room.fromJson(json);

      expect(room.floor, isA<int>());
      expect(room.totalShares, isA<int>());
      expect(room.availableShares, isA<int>());
      expect(room.soldShares, isA<int>());
      expect(room.sharePrice, isA<double>());
      expect(room.occupancyRate, isA<double>());
      expect(room.monthlyRevenue, isA<double>());
    });
  });

  group('RoomType.fromJson', () {
    test('parses valid JSON with all fields', () {
      final json = {
        'id': 'rtype_001',
        'name': 'Deluxe Suite',
        'nameRu': 'Люкс',
        'pricePerNight': 250.0,
        'description': 'A luxurious suite',
      };

      final roomType = RoomType.fromJson(json);

      expect(roomType.id, 'rtype_001');
      expect(roomType.name, 'Deluxe Suite');
      expect(roomType.nameRu, 'Люкс');
      expect(roomType.pricePerNight, 250.0);
      expect(roomType.description, 'A luxurious suite');
    });

    test('defaults description to empty string', () {
      final json = {
        'id': 'rtype_002',
        'name': 'Standard',
        'nameRu': 'Стандарт',
        'pricePerNight': 120.0,
      };

      final roomType = RoomType.fromJson(json);

      expect(roomType.description, '');
    });

    test('parses pricePerNight as int via toDouble()', () {
      final json = {
        'id': 'rtype_003',
        'name': 'Economy',
        'nameRu': 'Эконом',
        'pricePerNight': 80, // int, not double
      };

      final roomType = RoomType.fromJson(json);

      expect(roomType.pricePerNight, isA<double>());
      expect(roomType.pricePerNight, 80.0);
    });
  });

  group('RoomStatus enum', () {
    test('has exactly 3 values', () {
      expect(RoomStatus.values.length, 3);
    });

    test('contains active, renovation, upcoming', () {
      expect(RoomStatus.values, contains(RoomStatus.active));
      expect(RoomStatus.values, contains(RoomStatus.renovation));
      expect(RoomStatus.values, contains(RoomStatus.upcoming));
    });
  });
}
