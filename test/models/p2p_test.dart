import 'package:flutter_test/flutter_test.dart';
import 'package:estigo/data/models/p2p.dart';

void main() {
  group('P2POrder.fromJson', () {
    test('parses valid sell order with all fields', () {
      final json = {
        'id': 'order_001',
        'type': 'sell',
        'roomId': 'room_101',
        'roomNumber': '101',
        'roomType': 'Deluxe Suite',
        'shares': 5,
        'pricePerShare': 520.0,
        'totalPrice': 2600.0,
        'sellerName': 'Andrei',
        'buyerName': null,
        'createdAt': '2026-02-17T10:00:00Z',
        'status': 'active',
        'userId': 'usr_001',
      };

      final order = P2POrder.fromJson(json);

      expect(order.id, 'order_001');
      expect(order.type, OrderType.sell);
      expect(order.roomId, 'room_101');
      expect(order.roomNumber, '101');
      expect(order.roomType, 'Deluxe Suite');
      expect(order.shares, 5);
      expect(order.pricePerShare, 520.0);
      expect(order.totalPrice, 2600.0);
      expect(order.sellerName, 'Andrei');
      expect(order.buyerName, isNull);
      expect(order.createdAt, '2026-02-17T10:00:00Z');
      expect(order.status, OrderStatus.active);
      expect(order.userId, 'usr_001');
    });

    test('parses valid buy order', () {
      final json = {
        'id': 'order_002',
        'type': 'buy',
        'roomId': 'room_202',
        'roomNumber': '202',
        'roomType': 'Standard',
        'shares': 10,
        'pricePerShare': 300.0,
        'totalPrice': 3000.0,
        'sellerName': null,
        'buyerName': 'Buyer User',
        'createdAt': '2026-02-17T11:00:00Z',
        'status': 'active',
      };

      final order = P2POrder.fromJson(json);

      expect(order.type, OrderType.buy);
      expect(order.sellerName, isNull);
      expect(order.buyerName, 'Buyer User');
    });

    test('parses all OrderType values correctly', () {
      final types = {
        'sell': OrderType.sell,
        'buy': OrderType.buy,
      };

      for (final entry in types.entries) {
        final json = {
          'id': 'order_type_${entry.key}',
          'type': entry.key,
          'roomId': 'room_test',
          'roomNumber': '100',
          'roomType': 'Test',
          'shares': 1,
          'pricePerShare': 100.0,
          'totalPrice': 100.0,
          'createdAt': '2026-02-17T00:00:00Z',
        };

        final order = P2POrder.fromJson(json);
        expect(order.type, entry.value,
            reason: 'Failed for type: ${entry.key}');
      }
    });

    test('parses all OrderStatus values correctly', () {
      final statuses = {
        'active': OrderStatus.active,
        'completed': OrderStatus.completed,
        'cancelled': OrderStatus.cancelled,
      };

      for (final entry in statuses.entries) {
        final json = {
          'id': 'order_status_${entry.key}',
          'type': 'sell',
          'roomId': 'room_test',
          'roomNumber': '100',
          'roomType': 'Test',
          'shares': 1,
          'pricePerShare': 100.0,
          'totalPrice': 100.0,
          'createdAt': '2026-02-17T00:00:00Z',
          'status': entry.key,
        };

        final order = P2POrder.fromJson(json);
        expect(order.status, entry.value,
            reason: 'Failed for status: ${entry.key}');
      }
    });

    test('defaults status to active when absent', () {
      final json = {
        'id': 'order_003',
        'type': 'buy',
        'roomId': 'room_303',
        'roomNumber': '303',
        'roomType': 'Economy',
        'shares': 2,
        'pricePerShare': 200.0,
        'totalPrice': 400.0,
        'createdAt': '2026-02-17T00:00:00Z',
      };

      final order = P2POrder.fromJson(json);

      expect(order.status, OrderStatus.active);
    });

    test('defaults userId to empty string when absent', () {
      final json = {
        'id': 'order_004',
        'type': 'sell',
        'roomId': 'room_404',
        'roomNumber': '404',
        'roomType': 'Suite',
        'shares': 3,
        'pricePerShare': 500.0,
        'totalPrice': 1500.0,
        'createdAt': '2026-02-17T00:00:00Z',
      };

      final order = P2POrder.fromJson(json);

      expect(order.userId, '');
    });

    test('parses pricePerShare and totalPrice as int via toDouble()', () {
      final json = {
        'id': 'order_005',
        'type': 'buy',
        'roomId': 'room_505',
        'roomNumber': '505',
        'roomType': 'Premium',
        'shares': 4,
        'pricePerShare': 1000, // int
        'totalPrice': 4000, // int
        'createdAt': '2026-02-17T00:00:00Z',
      };

      final order = P2POrder.fromJson(json);

      expect(order.pricePerShare, isA<double>());
      expect(order.pricePerShare, 1000.0);
      expect(order.totalPrice, isA<double>());
      expect(order.totalPrice, 4000.0);
    });

    test('sellerName and buyerName are nullable', () {
      final json = {
        'id': 'order_006',
        'type': 'sell',
        'roomId': 'room_606',
        'roomNumber': '606',
        'roomType': 'Basic',
        'shares': 1,
        'pricePerShare': 100.0,
        'totalPrice': 100.0,
        'createdAt': '2026-02-17T00:00:00Z',
      };

      final order = P2POrder.fromJson(json);

      expect(order.sellerName, isNull);
      expect(order.buyerName, isNull);
    });
  });

  group('OrderType enum', () {
    test('has exactly 2 values', () {
      expect(OrderType.values.length, 2);
    });

    test('contains sell and buy', () {
      expect(OrderType.values, contains(OrderType.sell));
      expect(OrderType.values, contains(OrderType.buy));
    });
  });

  group('OrderStatus enum', () {
    test('has exactly 3 values', () {
      expect(OrderStatus.values.length, 3);
    });

    test('contains active, completed, cancelled', () {
      expect(OrderStatus.values, contains(OrderStatus.active));
      expect(OrderStatus.values, contains(OrderStatus.completed));
      expect(OrderStatus.values, contains(OrderStatus.cancelled));
    });
  });
}
