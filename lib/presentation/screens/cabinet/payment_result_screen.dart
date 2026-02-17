import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class PaymentResultScreen extends StatelessWidget {
  final bool success;
  const PaymentResultScreen({super.key, required this.success});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);

    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                success ? Icons.check_circle : Icons.cancel,
                size: 80,
                color: success ? AppColors.success : AppColors.error,
              ).animate().fadeIn(duration: 400.ms).scale(begin: const Offset(0.8, 0.8), end: const Offset(1, 1), duration: 400.ms),
              const SizedBox(height: 24),
              Text(
                success ? (l?.paymentSuccess ?? 'Payment Successful!') : (l?.paymentCancelled ?? 'Payment Cancelled'),
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ).animate().fadeIn(duration: 400.ms, delay: 150.ms).slideY(begin: 0.04, end: 0, duration: 400.ms, delay: 150.ms),
              const SizedBox(height: 12),
              Text(
                success
                    ? (l?.paymentConfirmedDesc ?? 'Your payment has been confirmed. Shares will be credited shortly.')
                    : (l?.paymentCancelledDesc ?? 'Payment was cancelled. No funds were charged.'),
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textMuted),
              ).animate().fadeIn(duration: 400.ms, delay: 250.ms).slideY(begin: 0.04, end: 0, duration: 400.ms, delay: 250.ms),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go(success ? '/cabinet/portfolio' : '/cabinet/object'),
                child: Text(success ? (l?.myPortfolio ?? 'My Portfolio') : (l?.backToObject ?? 'Back to Object')),
              ).animate().fadeIn(duration: 400.ms, delay: 350.ms).slideY(begin: 0.04, end: 0, duration: 400.ms, delay: 350.ms),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/cabinet'),
                child: Text(l?.home ?? 'Home'),
              ).animate().fadeIn(duration: 300.ms, delay: 450.ms),
            ],
          ),
        ),
      ),
    );
  }
}
