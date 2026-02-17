import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/api_providers.dart';
import '../../../domain/providers/auth_provider.dart';

/// Bottom sheet for disabling 2FA: asks for current TOTP code.
class TwoFaDisableSheet extends ConsumerStatefulWidget {
  const TwoFaDisableSheet({super.key});

  @override
  ConsumerState<TwoFaDisableSheet> createState() => _TwoFaDisableSheetState();
}

class _TwoFaDisableSheetState extends ConsumerState<TwoFaDisableSheet> {
  final _codeController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _disable() async {
    final code = _codeController.text.trim();
    if (code.length != 6) {
      setState(() => _error = 'Enter 6-digit code');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await ref.read(authApiProvider).disable2FA(code);
      final user = ref.read(authProvider).user;
      if (user != null) {
        ref.read(authProvider.notifier).updateUser(
          user.copyWith(twoFactorEnabled: false),
        );
      }
      if (mounted) {
        Navigator.of(context).pop(true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('2FA disabled'),
            backgroundColor: AppColors.warning,
          ),
        );
      }
    } catch (e) {
      setState(() => _error = 'Invalid code');
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  void dispose() {
    _codeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 40,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.textMuted.withAlpha(80),
              borderRadius: BorderRadius.circular(2),
            ),
          ),
          const SizedBox(height: 20),

          const Icon(Icons.warning_amber_rounded, size: 48, color: AppColors.warning),
          const SizedBox(height: 12),

          Text(
            'Disable Two-Factor Auth',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          const Text(
            'Enter the current code from your authenticator app to disable 2FA.',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textMuted, fontSize: 13),
          ),
          const SizedBox(height: 24),

          TextField(
            controller: _codeController,
            keyboardType: TextInputType.number,
            maxLength: 6,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24, letterSpacing: 8, fontWeight: FontWeight.bold),
            inputFormatters: [FilteringTextInputFormatter.digitsOnly],
            decoration: InputDecoration(
              labelText: 'Enter 6-digit code',
              counterText: '',
              errorText: _error,
            ),
          ),
          const SizedBox(height: 20),

          Row(
            children: [
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.of(context).pop(false),
                  child: const Text('Cancel'),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: ElevatedButton(
                  onPressed: _loading ? null : _disable,
                  style: ElevatedButton.styleFrom(backgroundColor: AppColors.error),
                  child: _loading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(strokeWidth: 2, color: Colors.white),
                        )
                      : const Text('Disable'),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
