import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/api_providers.dart';

class VerifyEmailScreen extends ConsumerStatefulWidget {
  final String token;
  const VerifyEmailScreen({super.key, required this.token});

  @override
  ConsumerState<VerifyEmailScreen> createState() => _VerifyEmailScreenState();
}

class _VerifyEmailScreenState extends ConsumerState<VerifyEmailScreen> {
  bool _loading = true;
  bool _success = false;
  String? _error;

  @override
  void initState() {
    super.initState();
    _verify();
  }

  Future<void> _verify() async {
    try {
      await ref.read(authApiProvider).verifyEmail(widget.token);
      setState(() { _success = true; _loading = false; });
    } catch (e) {
      setState(() {
        _error = S.of(context)?.verificationFailed ?? 'Verification failed';
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.dark,
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: _loading
              ? const CircularProgressIndicator(color: AppColors.gold)
              : Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      _success ? Icons.verified : Icons.error_outline,
                      size: 64,
                      color: _success ? AppColors.success : AppColors.error,
                    ),
                    const SizedBox(height: 24),
                    Text(
                      _success
                          ? (l?.emailVerified ?? 'Email Verified!')
                          : (l?.verificationFailed ?? 'Verification Failed'),
                      style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white),
                    ),
                    if (_error != null) ...[
                      const SizedBox(height: 12),
                      Text(_error!, style: const TextStyle(color: AppColors.error)),
                    ],
                    const SizedBox(height: 32),
                    ElevatedButton(
                      onPressed: () => context.go(_success ? '/cabinet' : '/login'),
                      child: Text(_success
                          ? (l?.continueBtn ?? 'Continue')
                          : (l?.backToLogin ?? 'Back to Login')),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
