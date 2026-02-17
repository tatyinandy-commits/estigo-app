import 'package:flutter_test/flutter_test.dart';
import 'package:estigo/data/models/user.dart';

void main() {
  group('User.fromJson', () {
    test('parses valid JSON with all fields', () {
      final json = {
        'id': 'usr_001',
        'name': 'Andrei',
        'email': 'andrei@estigo.org',
        'phone': '+49123456789',
        'kycStatus': 'verified',
        'role': 'admin',
        'roles': ['admin', 'investor'],
        'balance': 15000.50,
        'avatar': 'https://example.com/avatar.jpg',
        'registeredAt': '2026-01-15T10:00:00Z',
        'emailVerified': true,
        'twoFactorEnabled': true,
        'referralCode': 'REF123',
        'referredBy': 'usr_000',
      };

      final user = User.fromJson(json);

      expect(user.id, 'usr_001');
      expect(user.name, 'Andrei');
      expect(user.email, 'andrei@estigo.org');
      expect(user.phone, '+49123456789');
      expect(user.kycStatus, KycStatus.verified);
      expect(user.role, UserRole.admin);
      expect(user.roles, [UserRole.admin, UserRole.investor]);
      expect(user.balance, 15000.50);
      expect(user.avatar, 'https://example.com/avatar.jpg');
      expect(user.registeredAt, '2026-01-15T10:00:00Z');
      expect(user.emailVerified, true);
      expect(user.twoFactorEnabled, true);
      expect(user.referralCode, 'REF123');
      expect(user.referredBy, 'usr_000');
    });

    test('parses minimal JSON with defaults', () {
      final json = {
        'id': 'usr_002',
        'name': 'Minimal User',
        'email': 'min@test.com',
        'registeredAt': '2026-02-01T00:00:00Z',
      };

      final user = User.fromJson(json);

      expect(user.id, 'usr_002');
      expect(user.name, 'Minimal User');
      expect(user.email, 'min@test.com');
      expect(user.phone, '');
      expect(user.kycStatus, KycStatus.none);
      expect(user.role, UserRole.investor);
      expect(user.roles, isEmpty);
      expect(user.balance, 0);
      expect(user.avatar, '');
      expect(user.registeredAt, '2026-02-01T00:00:00Z');
      expect(user.emailVerified, false);
      expect(user.twoFactorEnabled, false);
      expect(user.referralCode, '');
      expect(user.referredBy, isNull);
    });

    test('parses JSON with null referredBy', () {
      final json = {
        'id': 'usr_003',
        'name': 'No Referrer',
        'email': 'noreferrer@test.com',
        'registeredAt': '2026-02-10T00:00:00Z',
        'referredBy': null,
      };

      final user = User.fromJson(json);

      expect(user.referredBy, isNull);
    });

    test('parses balance as int via toDouble()', () {
      final json = {
        'id': 'usr_004',
        'name': 'Int Balance',
        'email': 'intbal@test.com',
        'registeredAt': '2026-02-10T00:00:00Z',
        'balance': 5000, // int, not double
      };

      final user = User.fromJson(json);

      expect(user.balance, isA<double>());
      expect(user.balance, 5000.0);
    });
  });

  group('UserRole enum', () {
    test('has exactly 3 values', () {
      expect(UserRole.values.length, 3);
    });

    test('contains investor, partner, admin', () {
      expect(UserRole.values, contains(UserRole.investor));
      expect(UserRole.values, contains(UserRole.partner));
      expect(UserRole.values, contains(UserRole.admin));
    });

    test('fromJson maps string values correctly', () {
      // Verify via User.fromJson that the string mapping works
      final investorJson = {
        'id': 'r1',
        'name': 'R',
        'email': 'r@t.com',
        'registeredAt': '2026-01-01T00:00:00Z',
        'role': 'investor',
      };
      final partnerJson = {
        'id': 'r2',
        'name': 'R',
        'email': 'r@t.com',
        'registeredAt': '2026-01-01T00:00:00Z',
        'role': 'partner',
      };
      final adminJson = {
        'id': 'r3',
        'name': 'R',
        'email': 'r@t.com',
        'registeredAt': '2026-01-01T00:00:00Z',
        'role': 'admin',
      };

      expect(User.fromJson(investorJson).role, UserRole.investor);
      expect(User.fromJson(partnerJson).role, UserRole.partner);
      expect(User.fromJson(adminJson).role, UserRole.admin);
    });
  });

  group('KycStatus enum', () {
    test('has exactly 4 values', () {
      expect(KycStatus.values.length, 4);
    });

    test('contains none, pending, verified, rejected', () {
      expect(KycStatus.values, contains(KycStatus.none));
      expect(KycStatus.values, contains(KycStatus.pending));
      expect(KycStatus.values, contains(KycStatus.verified));
      expect(KycStatus.values, contains(KycStatus.rejected));
    });

    test('fromJson maps string values correctly', () {
      final baseJson = {
        'id': 'k1',
        'name': 'K',
        'email': 'k@t.com',
        'registeredAt': '2026-01-01T00:00:00Z',
      };

      expect(
        User.fromJson({...baseJson, 'kycStatus': 'none'}).kycStatus,
        KycStatus.none,
      );
      expect(
        User.fromJson({...baseJson, 'kycStatus': 'pending'}).kycStatus,
        KycStatus.pending,
      );
      expect(
        User.fromJson({...baseJson, 'kycStatus': 'verified'}).kycStatus,
        KycStatus.verified,
      );
      expect(
        User.fromJson({...baseJson, 'kycStatus': 'rejected'}).kycStatus,
        KycStatus.rejected,
      );
    });
  });
}
