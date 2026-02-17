import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:estigo/presentation/screens/auth/login_screen.dart';
import 'package:estigo/domain/providers/auth_provider.dart';
import 'package:estigo/core/theme/app_theme.dart';

void main() {
  group('LoginScreen widget tests', () {
    Widget createLoginScreen({AuthState? initialAuthState}) {
      return ProviderScope(
        overrides: [
          authProvider.overrideWith((ref) {
            final notifier = AuthNotifier(ref);
            return notifier;
          }),
        ],
        child: MaterialApp(
          theme: AppTheme.dark,
          home: const LoginScreen(),
        ),
      );
    }

    testWidgets('renders ESTIGO branding text', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      expect(find.text('ESTIGO'), findsOneWidget);
    });

    testWidgets('renders email text field', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // The label is either localized or defaults to 'Email'
      expect(find.text('Email'), findsOneWidget);
    });

    testWidgets('renders password text field', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      expect(find.text('Password'), findsOneWidget);
    });

    testWidgets('renders Sign In button', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // The login screen shows 'Sign In' as button text and as subtitle
      expect(find.text('Sign In'), findsWidgets);
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('renders forgot password link', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      expect(find.text('Forgot password?'), findsOneWidget);
    });

    testWidgets('renders Sign Up link', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      expect(find.text('Sign Up'), findsOneWidget);
      expect(find.text("Don't have an account?"), findsOneWidget);
    });

    testWidgets('contains two TextFormField widgets', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      expect(find.byType(TextFormField), findsNWidgets(2));
    });

    testWidgets('email field accepts text input', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      final emailField = find.byType(TextFormField).first;
      await tester.enterText(emailField, 'test@example.com');

      expect(find.text('test@example.com'), findsOneWidget);
    });

    testWidgets('password field accepts text input', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      final passwordField = find.byType(TextFormField).last;
      await tester.enterText(passwordField, 'password123');

      // Text is obscured, but the widget still holds it
      expect(find.text('password123'), findsOneWidget);
    });

    testWidgets('password visibility toggle icon exists', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Initially password is obscured, so visibility_off icon is shown
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
    });

    testWidgets('tapping visibility toggle changes icon', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      // Initially visibility_off
      expect(find.byIcon(Icons.visibility_off), findsOneWidget);
      expect(find.byIcon(Icons.visibility), findsNothing);

      // Tap the toggle
      await tester.tap(find.byIcon(Icons.visibility_off));
      await tester.pumpAndSettle();

      // Now visibility icon is shown
      expect(find.byIcon(Icons.visibility), findsOneWidget);
      expect(find.byIcon(Icons.visibility_off), findsNothing);
    });

    testWidgets('email icon is present', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.email_outlined), findsOneWidget);
    });

    testWidgets('lock icon is present', (tester) async {
      await tester.pumpWidget(createLoginScreen());
      await tester.pumpAndSettle();

      expect(find.byIcon(Icons.lock_outline), findsOneWidget);
    });
  });
}
