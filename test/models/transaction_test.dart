import 'package:flutter_test/flutter_test.dart';
import 'package:estigo/data/models/transaction.dart';

void main() {
  group('Transaction.fromJson', () {
    test('parses valid deposit transaction', () {
      final json = {
        'id': 'tx_001',
        'type': 'deposit',
        'amount': 5000.00,
        'description': 'Initial deposit',
        'date': '2026-02-17T10:00:00Z',
        'status': 'completed',
        'roomNumber': null,
        'shares': null,
      };

      final tx = Transaction.fromJson(json);

      expect(tx.id, 'tx_001');
      expect(tx.type, TransactionType.deposit);
      expect(tx.amount, 5000.00);
      expect(tx.description, 'Initial deposit');
      expect(tx.date, '2026-02-17T10:00:00Z');
      expect(tx.status, TransactionStatus.completed);
      expect(tx.roomNumber, isNull);
      expect(tx.shares, isNull);
    });

    test('parses share_purchase with room and shares', () {
      final json = {
        'id': 'tx_002',
        'type': 'share_purchase',
        'amount': 2500.00,
        'description': 'Purchased 5 shares of room 101',
        'date': '2026-02-17T11:00:00Z',
        'status': 'completed',
        'roomNumber': '101',
        'shares': 5,
      };

      final tx = Transaction.fromJson(json);

      expect(tx.type, TransactionType.sharePurchase);
      expect(tx.roomNumber, '101');
      expect(tx.shares, 5);
    });

    test('parses all transaction types correctly', () {
      final types = {
        'deposit': TransactionType.deposit,
        'withdrawal': TransactionType.withdrawal,
        'share_purchase': TransactionType.sharePurchase,
        'share_sale': TransactionType.shareSale,
        'income_accrual': TransactionType.incomeAccrual,
        'p2p_buy': TransactionType.p2pBuy,
        'p2p_sell': TransactionType.p2pSell,
      };

      for (final entry in types.entries) {
        final json = {
          'id': 'tx_type_${entry.key}',
          'type': entry.key,
          'amount': 100.0,
          'description': 'Test ${entry.key}',
          'date': '2026-02-17T00:00:00Z',
        };

        final tx = Transaction.fromJson(json);
        expect(tx.type, entry.value, reason: 'Failed for type: ${entry.key}');
      }
    });

    test('parses all status values correctly', () {
      final statuses = {
        'completed': TransactionStatus.completed,
        'pending': TransactionStatus.pending,
        'failed': TransactionStatus.failed,
      };

      for (final entry in statuses.entries) {
        final json = {
          'id': 'tx_status_${entry.key}',
          'type': 'deposit',
          'amount': 100.0,
          'description': 'Test',
          'date': '2026-02-17T00:00:00Z',
          'status': entry.key,
        };

        final tx = Transaction.fromJson(json);
        expect(tx.status, entry.value,
            reason: 'Failed for status: ${entry.key}');
      }
    });

    test('defaults to completed status when status is absent', () {
      final json = {
        'id': 'tx_003',
        'type': 'deposit',
        'amount': 100.0,
        'description': 'No status field',
        'date': '2026-02-17T00:00:00Z',
      };

      final tx = Transaction.fromJson(json);

      expect(tx.status, TransactionStatus.completed);
    });

    test('parses amount as int via toDouble()', () {
      final json = {
        'id': 'tx_004',
        'type': 'withdrawal',
        'amount': 3000, // int, not double
        'description': 'Int amount',
        'date': '2026-02-17T00:00:00Z',
        'status': 'pending',
      };

      final tx = Transaction.fromJson(json);

      expect(tx.amount, isA<double>());
      expect(tx.amount, 3000.0);
    });

    test('parses shares as int correctly', () {
      final json = {
        'id': 'tx_005',
        'type': 'share_purchase',
        'amount': 500.0,
        'description': 'Buy shares',
        'date': '2026-02-17T00:00:00Z',
        'shares': 10,
      };

      final tx = Transaction.fromJson(json);

      expect(tx.shares, 10);
      expect(tx.shares, isA<int>());
    });
  });

  group('TransactionType enum', () {
    test('has exactly 7 values', () {
      expect(TransactionType.values.length, 7);
    });
  });

  group('TransactionStatus enum', () {
    test('has exactly 3 values', () {
      expect(TransactionStatus.values.length, 3);
    });
  });
}
