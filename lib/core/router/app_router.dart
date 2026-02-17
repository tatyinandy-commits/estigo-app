import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../domain/providers/auth_provider.dart';
import '../../presentation/screens/auth/splash_screen.dart';
import '../../presentation/screens/auth/onboarding_screen.dart';
import '../../presentation/screens/auth/login_screen.dart';
import '../../presentation/screens/auth/register_screen.dart';
import '../../presentation/screens/auth/forgot_password_screen.dart';
import '../../presentation/screens/auth/reset_password_screen.dart';
import '../../presentation/screens/auth/verify_email_screen.dart';
import '../../presentation/screens/auth/two_factor_screen.dart';
import '../../presentation/screens/cabinet/dashboard_screen.dart';
import '../../presentation/screens/cabinet/object_screen.dart';
import '../../presentation/screens/cabinet/portfolio_screen.dart';
import '../../presentation/screens/cabinet/p2p_screen.dart';
import '../../presentation/screens/cabinet/income_screen.dart';
import '../../presentation/screens/cabinet/history_screen.dart';
import '../../presentation/screens/cabinet/referral_screen.dart';
import '../../presentation/screens/cabinet/support_screen.dart';
import '../../presentation/screens/cabinet/notifications_screen.dart';
import '../../presentation/screens/cabinet/payment_result_screen.dart';
import '../../presentation/screens/settings/settings_screen.dart';
import '../../presentation/screens/partner/partner_dashboard_screen.dart';
import '../../presentation/screens/partner/partner_referrals_screen.dart';
import '../../presentation/screens/partner/partner_academy_screen.dart';
import '../../presentation/shell/cabinet_shell.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

/// Listenable that notifies GoRouter when auth state changes.
class _AuthNotifierListenable extends ChangeNotifier {
  _AuthNotifierListenable(Ref ref) {
    ref.listen(authProvider, (_, __) => notifyListeners());
  }
}

final routerProvider = Provider<GoRouter>((ref) {
  final refreshListenable = _AuthNotifierListenable(ref);

  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/',
    refreshListenable: refreshListenable,
    redirect: (context, state) {
      final authState = ref.read(authProvider);
      final isAuth = authState.isAuthenticated;
      final isInitial = authState.status == AuthStatus.initial;
      final path = state.matchedLocation;

      // While auth is initializing, stay on splash
      if (isInitial && path == '/') return null;

      // Public routes that don't require auth
      const publicRoutes = [
        '/',
        '/onboarding',
        '/login',
        '/register',
        '/forgot-password',
        '/reset-password',
        '/verify-email',
        '/2fa',
      ];

      // Splash handles its own navigation
      if (path == '/') return null;

      // Not authenticated → can only visit public routes
      if (!isAuth && !publicRoutes.contains(path)) {
        return '/login';
      }

      // Authenticated → redirect away from auth pages (but not splash)
      if (isAuth && publicRoutes.contains(path) && path != '/') {
        return '/cabinet';
      }

      return null;
    },
    routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),
      GoRoute(
        path: '/onboarding',
        builder: (context, state) => const OnboardingScreen(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterScreen(),
      ),
      GoRoute(
        path: '/forgot-password',
        builder: (context, state) => const ForgotPasswordScreen(),
      ),
      GoRoute(
        path: '/reset-password',
        builder: (context, state) => ResetPasswordScreen(
          token: state.uri.queryParameters['token'] ?? '',
        ),
      ),
      GoRoute(
        path: '/verify-email',
        builder: (context, state) => VerifyEmailScreen(
          token: state.uri.queryParameters['token'] ?? '',
        ),
      ),
      GoRoute(
        path: '/2fa',
        builder: (context, state) => const TwoFactorScreen(),
      ),

      // Cabinet Shell with BottomNavBar
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (context, state, child) => CabinetShell(child: child),
        routes: [
          GoRoute(
            path: '/cabinet',
            builder: (context, state) => const DashboardScreen(),
          ),
          GoRoute(
            path: '/cabinet/object',
            builder: (context, state) => const ObjectScreen(),
          ),
          GoRoute(
            path: '/cabinet/portfolio',
            builder: (context, state) => const PortfolioScreen(),
          ),
          GoRoute(
            path: '/cabinet/p2p',
            builder: (context, state) => const P2PScreen(),
          ),
          GoRoute(
            path: '/cabinet/income',
            builder: (context, state) => const IncomeScreen(),
          ),
          GoRoute(
            path: '/cabinet/history',
            builder: (context, state) => const HistoryScreen(),
          ),
          GoRoute(
            path: '/cabinet/referral',
            builder: (context, state) => const ReferralScreen(),
          ),
          GoRoute(
            path: '/cabinet/settings',
            builder: (context, state) => const SettingsScreen(),
          ),
          GoRoute(
            path: '/cabinet/support',
            builder: (context, state) => const SupportScreen(),
          ),
          GoRoute(
            path: '/cabinet/notifications',
            builder: (context, state) => const NotificationsScreen(),
          ),
          GoRoute(
            path: '/cabinet/payment/success',
            builder: (context, state) =>
                const PaymentResultScreen(success: true),
          ),
          GoRoute(
            path: '/cabinet/payment/cancel',
            builder: (context, state) =>
                const PaymentResultScreen(success: false),
          ),
        ],
      ),

      // Partner routes
      GoRoute(
        path: '/partner',
        builder: (context, state) => const PartnerDashboardScreen(),
      ),
      GoRoute(
        path: '/partner/referrals',
        builder: (context, state) => const PartnerReferralsScreen(),
      ),
      GoRoute(
        path: '/partner/academy',
        builder: (context, state) => const PartnerAcademyScreen(),
      ),
    ],
  );
});
