import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:local_auth/local_auth.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/auth_provider.dart';

class SplashScreen extends ConsumerStatefulWidget {
  const SplashScreen({super.key});

  @override
  ConsumerState<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends ConsumerState<SplashScreen> {
  bool _navigated = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _initialize());
  }

  void _navigate(String route) {
    debugPrint('Splash: _navigate($route), _navigated=$_navigated, mounted=$mounted');
    if (_navigated || !mounted) return;
    _navigated = true;
    debugPrint('Splash: calling context.go($route)');
    context.go(route);
    debugPrint('Splash: context.go done');
  }

  Future<void> _initialize() async {
    // Safety timeout — navigate to onboarding if init takes too long
    final timer = Timer(const Duration(seconds: 5), () {
      debugPrint('Splash: timeout, navigating to /onboarding');
      _navigate('/onboarding');
    });

    try {
      await ref.read(authProvider.notifier).initialize();
    } catch (e) {
      debugPrint('Splash: auth init error: $e');
    }

    timer.cancel();
    if (_navigated || !mounted) return;

    final auth = ref.read(authProvider);
    debugPrint('Splash: auth status = ${auth.status}');

    if (auth.isAuthenticated) {
      // Check biometric lock (skip on web)
      if (!kIsWeb) {
        try {
          final biometricEnabled = await SecureStorage.isBiometricEnabled();
          if (biometricEnabled) {
            final didAuth = await _authenticateBiometric();
            if (!didAuth) {
              _navigate('/login');
              return;
            }
          }
        } catch (_) {}
      }
      _navigate('/cabinet');
    } else {
      bool seen = false;
      try {
        seen = await SecureStorage.isOnboardingSeen();
      } catch (_) {}
      _navigate(seen ? '/login' : '/onboarding');
    }
  }

  Future<bool> _authenticateBiometric() async {
    final auth = LocalAuthentication();
    try {
      final canCheck = await auth.canCheckBiometrics || await auth.isDeviceSupported();
      if (!canCheck) return true;

      return await auth.authenticate(
        localizedReason: 'Authenticate to access Estigo',
        options: const AuthenticationOptions(
          biometricOnly: true,
          stickyAuth: true,
        ),
      );
    } catch (_) {
      return true;
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                color: AppColors.gold,
                borderRadius: BorderRadius.circular(20),
              ),
              child: const Center(
                child: Text(
                  'E',
                  style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            const Text(
              'ESTIGO',
              style: TextStyle(
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.gold,
                letterSpacing: 4,
              ),
            ),
            const SizedBox(height: 32),
            const SizedBox(
              width: 24,
              height: 24,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                valueColor: AlwaysStoppedAnimation<Color>(AppColors.gold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
