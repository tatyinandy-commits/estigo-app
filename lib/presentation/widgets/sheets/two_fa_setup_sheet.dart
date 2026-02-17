import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:qr_flutter/qr_flutter.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/api_providers.dart';
import '../../../domain/providers/auth_provider.dart';

/// Bottom sheet for enabling 2FA: shows QR code, secret key, and TOTP input.
class TwoFaSetupSheet extends ConsumerStatefulWidget {
  final String secret;
  final String qrCodeUri;

  const TwoFaSetupSheet({
    super.key,
    required this.secret,
    required this.qrCodeUri,
  });

  @override
  ConsumerState<TwoFaSetupSheet> createState() => _TwoFaSetupSheetState();
}

class _TwoFaSetupSheetState extends ConsumerState<TwoFaSetupSheet> {
  final _codeController = TextEditingController();
  bool _loading = false;
  String? _error;

  Future<void> _verify() async {
    final l = S.of(context);
    final code = _codeController.text.trim();
    if (code.length != 6) {
      setState(() => _error = l?.enter6DigitCode ?? 'Enter 6-digit code');
      return;
    }

    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      await ref.read(authApiProvider).verify2FA(code);
      // Update user state
      final user = ref.read(authProvider).user;
      if (user != null) {
        ref.read(authProvider.notifier).updateUser(
          user.copyWith(twoFactorEnabled: true),
        );
      }
      if (mounted) {
        Navigator.of(context).pop(true);
        final l = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(l?.twoFAEnabledSuccess ?? '2FA enabled successfully'),
            backgroundColor: AppColors.success,
          ),
        );
      }
    } catch (e) {
      setState(() => _error = l?.invalidCodeTryAgain ?? 'Invalid code. Please try again.');
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
    final l = S.of(context);
    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Handle
            Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textMuted.withAlpha(80),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
            const SizedBox(height: 20),

            Text(
              l?.enable2FA ?? 'Enable Two-Factor Auth',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              l?.scanQrCode ?? 'Scan QR code with your authenticator app (Google Authenticator, Authy, etc.)',
              textAlign: TextAlign.center,
              style: const TextStyle(color: AppColors.textMuted, fontSize: 13),
            ),
            const SizedBox(height: 24),

            // QR Code
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
              ),
              child: QrImageView(
                data: widget.qrCodeUri,
                version: QrVersions.auto,
                size: 200,
                backgroundColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),

            // Secret key with copy
            Text(
              l?.enterKeyManually ?? 'Or enter this key manually:',
              style: const TextStyle(color: AppColors.textMuted, fontSize: 12),
            ),
            const SizedBox(height: 8),
            GestureDetector(
              onTap: () {
                Clipboard.setData(ClipboardData(text: widget.secret));
                final l = S.of(context);
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(l?.secretCopied ?? 'Secret copied to clipboard')),
                );
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                decoration: BoxDecoration(
                  color: AppColors.darkCard,
                  borderRadius: BorderRadius.circular(8),
                  border: Border.all(color: AppColors.gold.withAlpha(60)),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        widget.secret,
                        style: const TextStyle(
                          fontFamily: 'monospace',
                          fontSize: 14,
                          fontWeight: FontWeight.w600,
                          letterSpacing: 2,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    const Icon(Icons.copy, size: 18, color: AppColors.gold),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 24),

            // TOTP Code input
            TextField(
              controller: _codeController,
              keyboardType: TextInputType.number,
              maxLength: 6,
              textAlign: TextAlign.center,
              style: const TextStyle(fontSize: 24, letterSpacing: 8, fontWeight: FontWeight.bold),
              inputFormatters: [FilteringTextInputFormatter.digitsOnly],
              decoration: InputDecoration(
                labelText: l?.enter6DigitCode ?? 'Enter 6-digit code',
                counterText: '',
                errorText: _error,
              ),
            ),
            const SizedBox(height: 20),

            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _loading ? null : _verify,
                child: _loading
                    ? const SizedBox(
                        width: 20,
                        height: 20,
                        child: CircularProgressIndicator(strokeWidth: 2),
                      )
                    : Text(l?.verifyAndEnable ?? 'Verify & Enable'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
