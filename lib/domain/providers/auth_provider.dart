import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/storage/secure_storage.dart';
import '../../data/models/models.dart';
import 'api_providers.dart';

enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final User? user;
  final AuthStatus status;
  final String? error;
  final bool requires2FA;

  const AuthState({
    this.user,
    this.status = AuthStatus.initial,
    this.error,
    this.requires2FA = false,
  });

  AuthState copyWith({
    User? user,
    AuthStatus? status,
    String? error,
    bool? requires2FA,
  }) =>
      AuthState(
        user: user ?? this.user,
        status: status ?? this.status,
        error: error,
        requires2FA: requires2FA ?? this.requires2FA,
      );

  bool get isAuthenticated => status == AuthStatus.authenticated;
  bool get isLoading => status == AuthStatus.loading;
}

class AuthNotifier extends StateNotifier<AuthState> {
  final Ref _ref;

  AuthNotifier(this._ref) : super(const AuthState());

  Future<void> initialize() async {
    final token = await SecureStorage.getAccessToken();
    if (token == null) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
      return;
    }

    try {
      final api = _ref.read(authApiProvider);
      final user = await api.getMe();
      state = state.copyWith(
        user: user,
        status: AuthStatus.authenticated,
      );
    } catch (_) {
      // Try refresh
      try {
        final api = _ref.read(authApiProvider);
        final refreshToken = await SecureStorage.getRefreshToken();
        final result = await api.refresh(refreshToken: refreshToken);
        await SecureStorage.setAccessToken(result.tokens.accessToken);
        if (result.tokens.refreshToken != null) {
          await SecureStorage.setRefreshToken(result.tokens.refreshToken!);
        }
        state = state.copyWith(
          user: result.user,
          status: AuthStatus.authenticated,
        );
      } catch (_) {
        await SecureStorage.clearAll();
        state = state.copyWith(status: AuthStatus.unauthenticated);
      }
    }
  }

  Future<void> login(String email, String password) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);

    try {
      final api = _ref.read(authApiProvider);
      final result = await api.login(email, password);
      await SecureStorage.setAccessToken(result.tokens.accessToken);
      if (result.tokens.refreshToken != null) {
        await SecureStorage.setRefreshToken(result.tokens.refreshToken!);
      }
      state = state.copyWith(
        user: result.user,
        status: AuthStatus.authenticated,
      );
    } catch (e) {
      final message = _extractError(e);
      // Check if 2FA required
      if (message.contains('2FA') || message.contains('two-factor')) {
        state = state.copyWith(
          status: AuthStatus.unauthenticated,
          requires2FA: true,
          error: null,
        );
      } else {
        state = state.copyWith(
          status: AuthStatus.error,
          error: message,
        );
      }
    }
  }

  Future<void> login2FA(String email, String password, String code) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);

    try {
      final api = _ref.read(authApiProvider);
      final result = await api.login2FA(email, password, code);
      await SecureStorage.setAccessToken(result.tokens.accessToken);
      if (result.tokens.refreshToken != null) {
        await SecureStorage.setRefreshToken(result.tokens.refreshToken!);
      }
      state = state.copyWith(
        user: result.user,
        status: AuthStatus.authenticated,
        requires2FA: false,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: _extractError(e),
      );
    }
  }

  Future<void> register(
    String name,
    String email,
    String password, {
    String? referralCode,
  }) async {
    state = state.copyWith(status: AuthStatus.loading, error: null);

    try {
      final api = _ref.read(authApiProvider);
      final result = await api.register(
        name,
        email,
        password,
        referralCode: referralCode,
      );
      await SecureStorage.setAccessToken(result.tokens.accessToken);
      if (result.tokens.refreshToken != null) {
        await SecureStorage.setRefreshToken(result.tokens.refreshToken!);
      }
      state = state.copyWith(
        user: result.user,
        status: AuthStatus.authenticated,
      );
    } catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        error: _extractError(e),
      );
    }
  }

  Future<void> logout() async {
    try {
      final api = _ref.read(authApiProvider);
      await api.logout();
    } catch (_) {}
    await SecureStorage.clearAll();
    state = const AuthState(status: AuthStatus.unauthenticated);
  }

  void clearError() {
    state = state.copyWith(error: null, status: AuthStatus.unauthenticated);
  }

  void updateUser(User user) {
    state = state.copyWith(user: user);
  }

  String _extractError(Object e) {
    if (e is Exception) {
      try {
        final dynamic dioError = e;
        return (dioError as dynamic).response?.data?['message']?.toString() ??
            e.toString();
      } catch (_) {}
    }
    return e.toString();
  }
}

final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref);
});
