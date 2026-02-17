import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/api_providers.dart';

class ResetPasswordScreen extends ConsumerStatefulWidget {
  final String token;
  const ResetPasswordScreen({super.key, required this.token});

  @override
  ConsumerState<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends ConsumerState<ResetPasswordScreen> {
  final _passwordController = TextEditingController();
  final _confirmController = TextEditingController();
  bool _loading = false;
  bool _done = false;
  String? _error;

  Future<void> _submit() async {
    final l = S.of(context);
    if (_passwordController.text.length < 8) {
      setState(() => _error = l?.minChars ?? 'Minimum 8 characters');
      return;
    }
    if (_passwordController.text != _confirmController.text) {
      setState(() => _error = l?.passwordsDoNotMatch ?? 'Passwords do not match');
      return;
    }

    setState(() { _loading = true; _error = null; });

    try {
      await ref.read(authApiProvider).resetPassword(
        widget.token, _passwordController.text);
      setState(() { _done = true; _loading = false; });
    } catch (e) {
      setState(() { _error = l?.failedToResetPassword ?? 'Failed to reset password'; _loading = false; });
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(backgroundColor: Colors.transparent, title: Text(l?.resetPassword ?? 'Reset Password')),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: _done
            ? Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.check_circle, size: 64, color: AppColors.success),
                  const SizedBox(height: 24),
                  Text(l?.passwordResetSuccess ?? 'Password Reset!', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Colors.white)),
                  const SizedBox(height: 32),
                  ElevatedButton(onPressed: () => context.go('/login'), child: Text(l?.signIn ?? 'Sign In')),
                ],
              )
            : Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  if (_error != null) ...[
                    Container(padding: const EdgeInsets.all(12), decoration: BoxDecoration(color: AppColors.error.withOpacity(0.1), borderRadius: BorderRadius.circular(8)), child: Text(_error!, style: const TextStyle(color: AppColors.error))),
                    const SizedBox(height: 16),
                  ],
                  TextFormField(controller: _passwordController, obscureText: true, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: l?.newPassword ?? 'New Password', labelStyle: const TextStyle(color: Colors.white54))),
                  const SizedBox(height: 16),
                  TextFormField(controller: _confirmController, obscureText: true, style: const TextStyle(color: Colors.white), decoration: InputDecoration(labelText: l?.confirmPassword ?? 'Confirm Password', labelStyle: const TextStyle(color: Colors.white54))),
                  const SizedBox(height: 24),
                  ElevatedButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : Text(l?.resetPassword ?? 'Reset Password')),
                ],
              ),
      ),
    );
  }
}
