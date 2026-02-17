import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class SecureStorage {
  SecureStorage._();

  static const _storage = FlutterSecureStorage(
    aOptions: AndroidOptions(encryptedSharedPreferences: true),
    iOptions: IOSOptions(accessibility: KeychainAccessibility.first_unlock),
  );

  static const _keyAccessToken = 'access_token';
  static const _keyRefreshToken = 'refresh_token';
  static const _keyBiometricEnabled = 'biometric_enabled';
  static const _keyOnboardingSeen = 'onboarding_seen';

  // Access Token
  static Future<String?> getAccessToken() =>
      _storage.read(key: _keyAccessToken);

  static Future<void> setAccessToken(String token) =>
      _storage.write(key: _keyAccessToken, value: token);

  static Future<void> deleteAccessToken() =>
      _storage.delete(key: _keyAccessToken);

  // Refresh Token
  static Future<String?> getRefreshToken() =>
      _storage.read(key: _keyRefreshToken);

  static Future<void> setRefreshToken(String token) =>
      _storage.write(key: _keyRefreshToken, value: token);

  static Future<void> deleteRefreshToken() =>
      _storage.delete(key: _keyRefreshToken);

  // Biometric
  static Future<bool> isBiometricEnabled() async {
    final val = await _storage.read(key: _keyBiometricEnabled);
    return val == 'true';
  }

  static Future<void> setBiometricEnabled(bool enabled) =>
      _storage.write(key: _keyBiometricEnabled, value: enabled.toString());

  // Onboarding
  static Future<bool> isOnboardingSeen() async {
    final val = await _storage.read(key: _keyOnboardingSeen);
    return val == 'true';
  }

  static Future<void> setOnboardingSeen() =>
      _storage.write(key: _keyOnboardingSeen, value: 'true');

  // Clear all
  static Future<void> clearAll() => _storage.deleteAll();
}
