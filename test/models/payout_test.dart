import 'package:flutter_test/flutter_test.dart';
import 'package:estigo/data/models/payout.dart';

void main() {
  group('Payout.fromJson', () {
    test('parses valid JSON with all fields', () {
      final json = {
        'id': 'pay_001',
        'amount': 1500.50,
        'fee': 15.00,
        'iban': 'DE89370400440532013000',
        'recipientName': 'Andrei Test',
        'status': 'completed',
        'processedAt': '2026-02-17T12:00:00Z',
        'createdAt': '2026-02-16T10:00:00Z',
      };

      final payout = Payout.fromJson(json);

      expect(payout.id, 'pay_001');
      expect(payout.amount, 1500.50);
      expect(payout.fee, 15.00);
      expect(payout.iban, 'DE89370400440532013000');
      expect(payout.recipientName, 'Andrei Test');
      expect(payout.status, 'completed');
      expect(payout.processedAt, '2026-02-17T12:00:00Z');
      expect(payout.createdAt, '2026-02-16T10:00:00Z');
    });

    test('parses JSON with null processedAt', () {
      final json = {
        'id': 'pay_002',
        'amount': 250.00,
        'fee': 2.50,
        'iban': 'FR7630006000011234567890189',
        'recipientName': 'User Pending',
        'status': 'pending',
        'processedAt': null,
        'createdAt': '2026-02-17T08:00:00Z',
      };

      final payout = Payout.fromJson(json);

      expect(payout.id, 'pay_002');
      expect(payout.processedAt, isNull);
      expect(payout.status, 'pending');
    });

    test('parses amount as int via toDouble()', () {
      final json = {
        'id': 'pay_003',
        'amount': 1000, // int, not double
        'fee': 10, // int, not double
        'iban': 'DE89370400440532013000',
        'recipientName': 'Int Amount User',
        'status': 'completed',
        'processedAt': '2026-02-17T14:00:00Z',
        'createdAt': '2026-02-17T12:00:00Z',
      };

      final payout = Payout.fromJson(json);

      expect(payout.amount, isA<double>());
      expect(payout.amount, 1000.0);
      expect(payout.fee, isA<double>());
      expect(payout.fee, 10.0);
    });

    test('all fields are correctly typed', () {
      final json = {
        'id': 'pay_004',
        'amount': 99.99,
        'fee': 0.99,
        'iban': 'GB29NWBK60161331926819',
        'recipientName': 'Type Check',
        'status': 'failed',
        'processedAt': null,
        'createdAt': '2026-01-01T00:00:00Z',
      };

      final payout = Payout.fromJson(json);

      expect(payout.id, isA<String>());
      expect(payout.amount, isA<double>());
      expect(payout.fee, isA<double>());
      expect(payout.iban, isA<String>());
      expect(payout.recipientName, isA<String>());
      expect(payout.status, isA<String>());
      expect(payout.createdAt, isA<String>());
    });
  });
}
