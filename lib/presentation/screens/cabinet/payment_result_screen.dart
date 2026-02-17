import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';

class PaymentResultScreen extends StatelessWidget {
  final bool success;
  const PaymentResultScreen({super.key, required this.success});

  @override
  Widget build(BuildContext context) {
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
              ),
              const SizedBox(height: 24),
              Text(
                success ? 'Payment Successful!' : 'Payment Cancelled',
                style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 12),
              Text(
                success
                    ? 'Your payment has been confirmed. Shares will be credited shortly.'
                    : 'Payment was cancelled. No funds were charged.',
                textAlign: TextAlign.center,
                style: const TextStyle(color: AppColors.textMuted),
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: () => context.go(success ? '/cabinet/portfolio' : '/cabinet/object'),
                child: Text(success ? 'My Portfolio' : 'Back to Object'),
              ),
              const SizedBox(height: 12),
              TextButton(
                onPressed: () => context.go('/cabinet'),
                child: const Text('Home'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
