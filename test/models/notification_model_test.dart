import 'package:flutter_test/flutter_test.dart';
import 'package:estigo/data/models/notification.dart';

void main() {
  group('AppNotification.fromJson', () {
    test('parses valid JSON with all fields', () {
      final json = {
        'id': 'notif_001',
        'title': 'Share Purchase',
        'message': 'You purchased 10 shares of room 101',
        'type': 'purchase',
        'read': true,
        'createdAt': '2026-02-17T10:00:00Z',
      };

      final notif = AppNotification.fromJson(json);

      expect(notif.id, 'notif_001');
      expect(notif.title, 'Share Purchase');
      expect(notif.message, 'You purchased 10 shares of room 101');
      expect(notif.type, 'purchase');
      expect(notif.read, true);
      expect(notif.createdAt, '2026-02-17T10:00:00Z');
    });

    test('defaults read to false when absent', () {
      final json = {
        'id': 'notif_002',
        'title': 'Income Accrual',
        'message': 'Monthly income has been accrued',
        'type': 'income',
        'createdAt': '2026-02-15T08:00:00Z',
      };

      final notif = AppNotification.fromJson(json);

      expect(notif.read, false);
    });

    test('parses read notification correctly', () {
      final json = {
        'id': 'notif_003',
        'title': 'Welcome',
        'message': 'Welcome to Estigo!',
        'type': 'system',
        'read': true,
        'createdAt': '2026-01-01T00:00:00Z',
      };

      final notif = AppNotification.fromJson(json);

      expect(notif.read, true);
    });

    test('parses unread notification correctly', () {
      final json = {
        'id': 'notif_004',
        'title': 'Price Change',
        'message': 'Share price updated for room 205',
        'type': 'price',
        'read': false,
        'createdAt': '2026-02-17T12:00:00Z',
      };

      final notif = AppNotification.fromJson(json);

      expect(notif.read, false);
    });

    test('handles different notification types', () {
      final types = ['purchase', 'income', 'system', 'payout', 'p2p', 'kyc'];

      for (final type in types) {
        final json = {
          'id': 'notif_type_$type',
          'title': 'Test $type',
          'message': 'Message for $type',
          'type': type,
          'createdAt': '2026-02-17T00:00:00Z',
        };

        final notif = AppNotification.fromJson(json);
        expect(notif.type, type, reason: 'Failed for type: $type');
      }
    });

    test('all fields are correctly typed', () {
      final json = {
        'id': 'notif_005',
        'title': 'Type Check',
        'message': 'Checking types',
        'type': 'test',
        'read': false,
        'createdAt': '2026-02-17T00:00:00Z',
      };

      final notif = AppNotification.fromJson(json);

      expect(notif.id, isA<String>());
      expect(notif.title, isA<String>());
      expect(notif.message, isA<String>());
      expect(notif.type, isA<String>());
      expect(notif.read, isA<bool>());
      expect(notif.createdAt, isA<String>());
    });
  });
}
