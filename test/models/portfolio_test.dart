import 'package:flutter_test/flutter_test.dart';
import 'package:estigo/data/models/portfolio.dart';

void main() {
  group('UserShare.fromJson', () {
    test('parses valid JSON with all fields', () {
      final json = {
        'roomId': 'room_101',
        'roomNumber': '101',
        'roomType': 'Deluxe Suite',
        'shares': 10,
        'purchasePrice': 5000.0,
        'currentValue': 5500.0,
        'totalIncome': 750.50,
        'purchaseDate': '2026-01-15T10:00:00Z',
      };

      final share = UserShare.fromJson(json);

      expect(share.roomId, 'room_101');
      expect(share.roomNumber, '101');
      expect(share.roomType, 'Deluxe Suite');
      expect(share.shares, 10);
      expect(share.purchasePrice, 5000.0);
      expect(share.currentValue, 5500.0);
      expect(share.totalIncome, 750.50);
      expect(share.purchaseDate, '2026-01-15T10:00:00Z');
    });

    test('parses numeric fields as int via toDouble()', () {
      final json = {
        'roomId': 'room_202',
        'roomNumber': '202',
        'roomType': 'Standard',
        'shares': 5,
        'purchasePrice': 2500, // int
        'currentValue': 2700, // int
        'totalIncome': 300, // int
        'purchaseDate': '2026-02-01T00:00:00Z',
      };

      final share = UserShare.fromJson(json);

      expect(share.purchasePrice, isA<double>());
      expect(share.purchasePrice, 2500.0);
      expect(share.currentValue, isA<double>());
      expect(share.currentValue, 2700.0);
      expect(share.totalIncome, isA<double>());
      expect(share.totalIncome, 300.0);
    });

    test('currentValue can be higher than purchasePrice (profit)', () {
      final json = {
        'roomId': 'room_303',
        'roomNumber': '303',
        'roomType': 'Premium',
        'shares': 20,
        'purchasePrice': 10000.0,
        'currentValue': 12000.0,
        'totalIncome': 1500.0,
        'purchaseDate': '2025-12-01T00:00:00Z',
      };

      final share = UserShare.fromJson(json);

      expect(share.currentValue, greaterThan(share.purchasePrice));
    });

    test('currentValue can be lower than purchasePrice (loss)', () {
      final json = {
        'roomId': 'room_404',
        'roomNumber': '404',
        'roomType': 'Economy',
        'shares': 3,
        'purchasePrice': 1500.0,
        'currentValue': 1200.0,
        'totalIncome': 50.0,
        'purchaseDate': '2026-02-10T00:00:00Z',
      };

      final share = UserShare.fromJson(json);

      expect(share.currentValue, lessThan(share.purchasePrice));
    });

    test('totalIncome can be zero', () {
      final json = {
        'roomId': 'room_505',
        'roomNumber': '505',
        'roomType': 'Basic',
        'shares': 1,
        'purchasePrice': 500.0,
        'currentValue': 500.0,
        'totalIncome': 0.0,
        'purchaseDate': '2026-02-17T00:00:00Z',
      };

      final share = UserShare.fromJson(json);

      expect(share.totalIncome, 0.0);
    });

    test('all fields are correctly typed', () {
      final json = {
        'roomId': 'room_606',
        'roomNumber': '606',
        'roomType': 'Suite',
        'shares': 15,
        'purchasePrice': 7500.0,
        'currentValue': 8000.0,
        'totalIncome': 900.0,
        'purchaseDate': '2026-01-20T00:00:00Z',
      };

      final share = UserShare.fromJson(json);

      expect(share.roomId, isA<String>());
      expect(share.roomNumber, isA<String>());
      expect(share.roomType, isA<String>());
      expect(share.shares, isA<int>());
      expect(share.purchasePrice, isA<double>());
      expect(share.currentValue, isA<double>());
      expect(share.totalIncome, isA<double>());
      expect(share.purchaseDate, isA<String>());
    });

    test('handles large share counts', () {
      final json = {
        'roomId': 'room_707',
        'roomNumber': '707',
        'roomType': 'Penthouse',
        'shares': 1000,
        'purchasePrice': 500000.0,
        'currentValue': 550000.0,
        'totalIncome': 75000.0,
        'purchaseDate': '2025-06-01T00:00:00Z',
      };

      final share = UserShare.fromJson(json);

      expect(share.shares, 1000);
      expect(share.purchasePrice, 500000.0);
      expect(share.currentValue, 550000.0);
      expect(share.totalIncome, 75000.0);
    });
  });
}
