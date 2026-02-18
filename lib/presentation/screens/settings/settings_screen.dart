import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:local_auth/local_auth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:url_launcher/url_launcher.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/l10n/l10n.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../data/models/user.dart';
import '../../../domain/providers/auth_provider.dart';
import '../../../domain/providers/api_providers.dart';
import '../../../domain/providers/data_providers.dart';
import '../../widgets/sheets/two_fa_setup_sheet.dart';
import '../../widgets/sheets/two_fa_disable_sheet.dart';

class SettingsScreen extends ConsumerStatefulWidget {
  const SettingsScreen({super.key});

  @override
  ConsumerState<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends ConsumerState<SettingsScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 4, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l?.settings ?? 'Settings'),
        bottom: TabBar(
          controller: _tab,
          isScrollable: true,
          tabs: [
            Tab(text: l?.profile ?? 'Profile'),
            Tab(text: l?.security ?? 'Security'),
            Tab(text: l?.notifications ?? 'Notifications'),
            Tab(text: l?.verification ?? 'Verification'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _ProfileTab().animate().fadeIn(duration: 400.ms).slideY(begin: 0.03, end: 0, duration: 400.ms),
          _SecurityTab().animate().fadeIn(duration: 400.ms).slideY(begin: 0.03, end: 0, duration: 400.ms),
          _NotificationsTab().animate().fadeIn(duration: 400.ms).slideY(begin: 0.03, end: 0, duration: 400.ms),
          _VerificationTab().animate().fadeIn(duration: 400.ms).slideY(begin: 0.03, end: 0, duration: 400.ms),
        ],
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Profile Tab
// ─────────────────────────────────────────────

class _ProfileTab extends ConsumerStatefulWidget {
  @override
  ConsumerState<_ProfileTab> createState() => _ProfileTabState();
}

class _ProfileTabState extends ConsumerState<_ProfileTab> {
  late TextEditingController _nameC;
  late TextEditingController _phoneC;
  bool _loading = false;

  @override
  void initState() {
    super.initState();
    final user = ref.read(authProvider).user;
    _nameC = TextEditingController(text: user?.name ?? '');
    _phoneC = TextEditingController(text: user?.phone ?? '');
  }

  Future<void> _save() async {
    setState(() => _loading = true);
    try {
      final updated = await ref.read(userApiProvider).updateProfile(name: _nameC.text, phone: _phoneC.text);
      ref.read(authProvider.notifier).updateUser(updated);
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Saved'), backgroundColor: AppColors.success));
    } catch (e) {
      if (mounted) {
        final l = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l?.operationFailed ?? 'Operation failed')));
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final user = ref.watch(authProvider).user;
    return RefreshIndicator(
      onRefresh: () async {
        final user = await ref.read(authApiProvider).getMe();
        ref.read(authProvider.notifier).updateUser(user);
      },
      child: ListView(padding: const EdgeInsets.all(24), children: [
      TextFormField(controller: _nameC, decoration: const InputDecoration(labelText: 'Full Name')),
      const SizedBox(height: 16),
      TextFormField(enabled: false, initialValue: user?.email ?? '', decoration: const InputDecoration(labelText: 'Email')),
      const SizedBox(height: 16),
      TextFormField(controller: _phoneC, decoration: const InputDecoration(labelText: 'Phone')),
      const SizedBox(height: 16),
      // Language
      ListTile(
        title: const Text('Language'),
        trailing: DropdownButton<String>(
          value: ref.watch(localeProvider).languageCode,
          items: const [
            DropdownMenuItem(value: 'ru', child: Text('Русский')),
            DropdownMenuItem(value: 'en', child: Text('English')),
          ],
          onChanged: (v) {
            if (v != null) ref.read(localeProvider.notifier).setLocale(v);
          },
        ),
      ),
      // Theme
      ListTile(
        title: const Text('Dark Mode'),
        trailing: Switch(
          value: ref.watch(themeModeProvider) == ThemeMode.dark,
          onChanged: (_) => ref.read(themeModeProvider.notifier).toggle(),
        ),
      ),
      const SizedBox(height: 24),
      ElevatedButton(
        onPressed: _loading ? null : _save,
        child: _loading
            ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
            : Text(l?.save ?? 'Save Changes'),
      ),
    ]),
    );
  }
}

// ─────────────────────────────────────────────
// Security Tab — Password, 2FA, Biometrics, Sessions
// ─────────────────────────────────────────────

class _SecurityTab extends ConsumerStatefulWidget {
  @override
  ConsumerState<_SecurityTab> createState() => _SecurityTabState();
}

class _SecurityTabState extends ConsumerState<_SecurityTab> {
  final _currentC = TextEditingController();
  final _newC = TextEditingController();
  final _confirmC = TextEditingController();
  bool _loading = false;
  bool _twoFaLoading = false;
  bool _biometricAvailable = false;
  bool _biometricEnabled = false;

  @override
  void initState() {
    super.initState();
    _checkBiometric();
  }

  Future<void> _checkBiometric() async {
    final auth = LocalAuthentication();
    try {
      final canCheck = await auth.canCheckBiometrics || await auth.isDeviceSupported();
      final enabled = await SecureStorage.isBiometricEnabled();
      if (mounted) {
        setState(() {
          _biometricAvailable = canCheck;
          _biometricEnabled = enabled;
        });
      }
    } catch (_) {}
  }

  Future<void> _toggleBiometric(bool value) async {
    if (value) {
      // Verify biometric first
      final auth = LocalAuthentication();
      try {
        final didAuth = await auth.authenticate(
          localizedReason: 'Authenticate to enable biometric login',
          options: const AuthenticationOptions(biometricOnly: true),
        );
        if (!didAuth) return;
      } catch (_) {
        return;
      }
    }
    await SecureStorage.setBiometricEnabled(value);
    if (mounted) setState(() => _biometricEnabled = value);
  }

  Future<void> _changePassword() async {
    if (_newC.text.length < 8) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password must be at least 8 characters')));
      return;
    }
    if (_newC.text != _confirmC.text) {
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Passwords do not match')));
      return;
    }
    setState(() => _loading = true);
    try {
      await ref.read(userApiProvider).changePassword(_currentC.text, _newC.text, _confirmC.text);
      _currentC.clear();
      _newC.clear();
      _confirmC.clear();
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Password changed'), backgroundColor: AppColors.success),
        );
      }
    } catch (e) {
      if (mounted) {
        final l = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l?.operationFailed ?? 'Operation failed')));
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  Future<void> _handle2FAToggle() async {
    final user = ref.read(authProvider).user;
    if (user == null) return;

    if (user.twoFactorEnabled) {
      // Disable: show disable sheet
      await showModalBottomSheet(
        context: context,
        isScrollControlled: true,
        builder: (_) => const TwoFaDisableSheet(),
      );
    } else {
      // Enable: call setup, get QR data, show setup sheet
      setState(() => _twoFaLoading = true);
      try {
        final data = await ref.read(authApiProvider).setup2FA();
        final secret = data['secret'] as String;
        final uri = data['uri'] as String? ?? data['qrCode'] as String? ?? '';

        if (mounted) {
          await showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (_) => TwoFaSetupSheet(secret: secret, qrCodeUri: uri),
          );
        }
      } catch (e) {
        if (mounted) {
          final l = S.of(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l?.operationFailed ?? 'Operation failed')),
          );
        }
      } finally {
        if (mounted) setState(() => _twoFaLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final user = ref.watch(authProvider).user;
    final sessionsAsync = ref.watch(sessionsProvider);

    return RefreshIndicator(
      onRefresh: () async {
        ref.invalidate(sessionsProvider);
        final user = await ref.read(authApiProvider).getMe();
        ref.read(authProvider.notifier).updateUser(user);
      },
      child: ListView(padding: const EdgeInsets.all(24), children: [
      // ── Change Password ──
      Text(l?.changePassword ?? 'Change Password', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      TextFormField(controller: _currentC, obscureText: true, decoration: const InputDecoration(labelText: 'Current Password')),
      const SizedBox(height: 12),
      TextFormField(controller: _newC, obscureText: true, decoration: const InputDecoration(labelText: 'New Password')),
      const SizedBox(height: 12),
      TextFormField(controller: _confirmC, obscureText: true, decoration: const InputDecoration(labelText: 'Confirm Password')),
      const SizedBox(height: 16),
      ElevatedButton(onPressed: _loading ? null : _changePassword, child: Text(l?.changePassword ?? 'Change Password')),
      const SizedBox(height: 32),

      // ── Two-Factor Authentication ──
      Text(l?.twoFactorAuth ?? 'Two-Factor Authentication', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      Card(
        child: ListTile(
          leading: Icon(
            Icons.security,
            color: user?.twoFactorEnabled == true ? AppColors.success : AppColors.textMuted,
          ),
          title: Text(user?.twoFactorEnabled == true ? '2FA Enabled' : '2FA Disabled'),
          subtitle: Text(
            user?.twoFactorEnabled == true ? 'Account is protected with TOTP' : 'Recommended for security',
          ),
          trailing: _twoFaLoading
              ? const SizedBox(width: 24, height: 24, child: CircularProgressIndicator(strokeWidth: 2))
              : Switch(
                  value: user?.twoFactorEnabled ?? false,
                  onChanged: (_) => _handle2FAToggle(),
                  activeColor: AppColors.success,
                ),
        ),
      ),
      const SizedBox(height: 32),

      // ── Biometric Login ──
      if (_biometricAvailable) ...[
        Text('Biometric Login', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 12),
        Card(
          child: ListTile(
            leading: const Icon(Icons.fingerprint, color: AppColors.gold),
            title: const Text('Face ID / Touch ID'),
            subtitle: const Text('Quick login with biometrics'),
            trailing: Switch(
              value: _biometricEnabled,
              onChanged: _toggleBiometric,
              activeColor: AppColors.gold,
            ),
          ),
        ),
        const SizedBox(height: 32),
      ],

      // ── Active Sessions ──
      Text(l?.activeSessions ?? 'Active Sessions', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      sessionsAsync.when(
        data: (sessions) => Column(
          children: sessions.map((s) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: Icon(
                _sessionIcon(s['device'] ?? ''),
                color: AppColors.textMuted,
              ),
              title: Text(s['device'] ?? 'Unknown device'),
              subtitle: Text('${s['ip'] ?? ''} • ${s['lastActive'] ?? ''}'),
              trailing: s['current'] == true
                  ? Container(
                      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: AppColors.success.withAlpha(30),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: const Text('Current', style: TextStyle(fontSize: 10, color: AppColors.success)),
                    )
                  : TextButton(
                      onPressed: () async {
                        await ref.read(userApiProvider).revokeSession(s['id']);
                        ref.invalidate(sessionsProvider);
                      },
                      child: const Text('Revoke', style: TextStyle(color: AppColors.error)),
                    ),
            ),
          )).toList(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Text('Failed to load sessions'),
      ),
    ]),
    );
  }

  IconData _sessionIcon(String device) {
    final d = device.toLowerCase();
    if (d.contains('iphone') || d.contains('ios') || d.contains('mobile')) return Icons.phone_iphone;
    if (d.contains('android')) return Icons.phone_android;
    if (d.contains('mac') || d.contains('windows') || d.contains('linux')) return Icons.computer;
    return Icons.devices;
  }
}

// ─────────────────────────────────────────────
// Notifications Tab
// ─────────────────────────────────────────────

class _NotificationsTab extends StatefulWidget {
  @override
  State<_NotificationsTab> createState() => _NotificationsTabState();
}

class _NotificationsTabState extends State<_NotificationsTab> {
  static const _keys = [
    'notif_income',
    'notif_payout',
    'notif_p2p',
    'notif_news',
    'notif_security',
    'notif_reports',
  ];

  final Map<String, bool> _prefs = {};
  bool _loaded = false;

  @override
  void initState() {
    super.initState();
    _loadPrefs();
  }

  Future<void> _loadPrefs() async {
    final sp = await SharedPreferences.getInstance();
    final map = <String, bool>{};
    for (final key in _keys) {
      map[key] = sp.getBool(key) ?? true;
    }
    if (mounted) {
      setState(() {
        _prefs.addAll(map);
        _loaded = true;
      });
    }
  }

  Future<void> _toggle(String key, bool value) async {
    setState(() => _prefs[key] = value);
    final sp = await SharedPreferences.getInstance();
    await sp.setBool(key, value);
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    if (!_loaded) {
      return const Center(child: CircularProgressIndicator());
    }
    return ListView(padding: const EdgeInsets.all(24), children: [
      Text(l?.notifications ?? 'Notification Settings', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      _notifRow('notif_income', 'Income Accrual', 'Monthly accruals on your shares'),
      _notifRow('notif_payout', 'Payout', 'Withdrawal status updates'),
      _notifRow('notif_p2p', 'P2P Trades', 'New orders and completed trades'),
      _notifRow('notif_news', 'Platform News', 'Updates, promotions'),
      _notifRow('notif_security', l?.security ?? 'Security', 'Account logins, password changes'),
      _notifRow('notif_reports', 'Reports', 'Monthly object reports'),
    ]);
  }

  Widget _notifRow(String key, String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        value: _prefs[key] ?? true,
        onChanged: (v) => _toggle(key, v),
        activeColor: AppColors.gold,
      ),
    );
  }
}

// ─────────────────────────────────────────────
// Verification / KYC Tab — Stripe Identity
// ─────────────────────────────────────────────

class _VerificationTab extends ConsumerStatefulWidget {
  @override
  ConsumerState<_VerificationTab> createState() => _VerificationTabState();
}

class _VerificationTabState extends ConsumerState<_VerificationTab> {
  bool _loading = false;

  Future<void> _startVerification() async {
    setState(() => _loading = true);
    try {
      final api = ref.read(kycApiProvider);
      final clientSecret = await api.createSession();

      // On mobile, we open Stripe Identity hosted URL.
      // The API returns a clientSecret — Stripe Identity is launched via
      // the Stripe SDK or a hosted verification link.
      // For iOS, we use the Stripe Identity SDK via flutter_stripe,
      // but since flutter_stripe doesn't include Identity,
      // we launch the hosted verification URL in a browser.
      final verificationUrl = Uri.parse(
        'https://verify.stripe.com/start/$clientSecret',
      );
      if (await canLaunchUrl(verificationUrl)) {
        await launchUrl(verificationUrl, mode: LaunchMode.externalApplication);
      }

      // Refresh user data after returning from verification
      if (mounted) {
        // Give Stripe a moment to process
        await Future.delayed(const Duration(seconds: 2));
        try {
          final user = await ref.read(authApiProvider).getMe();
          ref.read(authProvider.notifier).updateUser(user);
        } catch (_) {}
      }
    } catch (e) {
      if (mounted) {
        final l = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l?.operationFailed ?? 'Operation failed')),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final user = ref.watch(authProvider).user;
    final status = user?.kycStatus;

    return ListView(padding: const EdgeInsets.all(24), children: [
      const SizedBox(height: 24),
      Center(
        child: Container(
          width: 96,
          height: 96,
          decoration: BoxDecoration(
            color: _color(status).withAlpha(25),
            shape: BoxShape.circle,
          ),
          child: Icon(_icon(status), size: 48, color: _color(status)),
        ),
      ),
      const SizedBox(height: 20),
      Text(
        _title(status),
        style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 8),
      Text(
        _desc(status),
        style: const TextStyle(color: AppColors.textMuted, fontSize: 14),
        textAlign: TextAlign.center,
      ),
      const SizedBox(height: 32),

      // Verified — show confirmed documents
      if (status == KycStatus.verified) ...[
        _docRow(Icons.badge, 'Identity Document', 'Verified'),
        _docRow(Icons.home, 'Proof of Address', 'Verified'),
        _docRow(Icons.camera_alt, 'Selfie', 'Verified'),
      ],

      // Start / Retry verification
      if (status == null || status == KycStatus.none || status == KycStatus.rejected)
        SizedBox(
          width: double.infinity,
          child: ElevatedButton.icon(
            onPressed: _loading ? null : _startVerification,
            icon: _loading
                ? const SizedBox(width: 18, height: 18, child: CircularProgressIndicator(strokeWidth: 2))
                : const Icon(Icons.verified_user),
            label: Text(status == KycStatus.rejected ? 'Retry Verification' : (l?.startVerification ?? 'Start Verification')),
          ),
        ),

      // Pending — show info
      if (status == KycStatus.pending) ...[
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                const Icon(Icons.access_time, color: AppColors.warning),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: const [
                      Text('Review in progress', style: TextStyle(fontWeight: FontWeight.bold)),
                      SizedBox(height: 4),
                      Text(
                        'Usually takes up to 24 hours. We will notify you when done.',
                        style: TextStyle(fontSize: 12, color: AppColors.textMuted),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    ]);
  }

  Widget _docRow(IconData icon, String title, String status) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Card(
        child: ListTile(
          leading: Icon(icon, color: AppColors.success),
          title: Text(title),
          trailing: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.check_circle, size: 16, color: AppColors.success),
              const SizedBox(width: 4),
              Text(status, style: const TextStyle(color: AppColors.success, fontSize: 12)),
            ],
          ),
        ),
      ),
    );
  }

  IconData _icon(KycStatus? s) {
    switch (s) {
      case KycStatus.verified:
        return Icons.verified;
      case KycStatus.pending:
        return Icons.hourglass_top;
      case KycStatus.rejected:
        return Icons.cancel;
      default:
        return Icons.shield;
    }
  }

  Color _color(KycStatus? s) {
    switch (s) {
      case KycStatus.verified:
        return AppColors.success;
      case KycStatus.pending:
        return AppColors.warning;
      case KycStatus.rejected:
        return AppColors.error;
      default:
        return AppColors.textMuted;
    }
  }

  String _title(KycStatus? s) {
    switch (s) {
      case KycStatus.verified:
        return 'Verification Complete';
      case KycStatus.pending:
        return 'Under Review';
      case KycStatus.rejected:
        return 'Verification Rejected';
      default:
        return 'Not Verified';
    }
  }

  String _desc(KycStatus? s) {
    switch (s) {
      case KycStatus.verified:
        return 'Your identity is confirmed. All features are available.';
      case KycStatus.pending:
        return 'Your documents are being reviewed.';
      case KycStatus.rejected:
        return 'Verification failed. Please try again with valid documents.';
      default:
        return 'Complete identity verification (KYC) to access all platform features including withdrawals.';
    }
  }
}
