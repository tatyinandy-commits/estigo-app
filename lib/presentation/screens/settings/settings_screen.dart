import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../core/l10n/l10n.dart';
import '../../../domain/providers/auth_provider.dart';
import '../../../domain/providers/api_providers.dart';
import '../../../domain/providers/data_providers.dart';

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
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        bottom: TabBar(
          controller: _tab,
          isScrollable: true,
          tabs: const [
            Tab(text: 'Profile'),
            Tab(text: 'Security'),
            Tab(text: 'Notifications'),
            Tab(text: 'Verification'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          _ProfileTab(),
          _SecurityTab(),
          _NotificationsTab(),
          _VerificationTab(),
        ],
      ),
    );
  }
}

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
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally { setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;
    return ListView(padding: const EdgeInsets.all(24), children: [
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
          onChanged: (v) { if (v != null) ref.read(localeProvider.notifier).setLocale(v); },
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
      ElevatedButton(onPressed: _loading ? null : _save, child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Save Changes')),
    ]);
  }
}

class _SecurityTab extends ConsumerStatefulWidget {
  @override
  ConsumerState<_SecurityTab> createState() => _SecurityTabState();
}

class _SecurityTabState extends ConsumerState<_SecurityTab> {
  final _currentC = TextEditingController();
  final _newC = TextEditingController();
  final _confirmC = TextEditingController();
  bool _loading = false;

  Future<void> _changePassword() async {
    if (_newC.text.length < 8) return;
    if (_newC.text != _confirmC.text) return;
    setState(() => _loading = true);
    try {
      await ref.read(userApiProvider).changePassword(_currentC.text, _newC.text);
      _currentC.clear(); _newC.clear(); _confirmC.clear();
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Password changed'), backgroundColor: AppColors.success));
    } catch (e) {
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally { setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;
    final sessionsAsync = ref.watch(sessionsProvider);

    return ListView(padding: const EdgeInsets.all(24), children: [
      Text('Change Password', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      TextFormField(controller: _currentC, obscureText: true, decoration: const InputDecoration(labelText: 'Current Password')),
      const SizedBox(height: 12),
      TextFormField(controller: _newC, obscureText: true, decoration: const InputDecoration(labelText: 'New Password')),
      const SizedBox(height: 12),
      TextFormField(controller: _confirmC, obscureText: true, decoration: const InputDecoration(labelText: 'Confirm Password')),
      const SizedBox(height: 16),
      ElevatedButton(onPressed: _loading ? null : _changePassword, child: const Text('Change Password')),
      const SizedBox(height: 32),

      // 2FA
      Text('Two-Factor Authentication', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      Card(child: ListTile(
        leading: Icon(Icons.security, color: user?.twoFactorEnabled == true ? AppColors.success : AppColors.textMuted),
        title: Text(user?.twoFactorEnabled == true ? '2FA Enabled' : '2FA Disabled'),
        subtitle: Text(user?.twoFactorEnabled == true ? 'Account is protected' : 'Recommended for security'),
        trailing: Switch(
          value: user?.twoFactorEnabled ?? false,
          onChanged: (_) {/* TODO: 2FA setup flow */},
          activeColor: AppColors.success,
        ),
      )),
      const SizedBox(height: 32),

      // Sessions
      Text('Active Sessions', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 12),
      sessionsAsync.when(
        data: (sessions) => Column(
          children: sessions.map((s) => Card(
            margin: const EdgeInsets.only(bottom: 8),
            child: ListTile(
              leading: const Icon(Icons.devices),
              title: Text(s['device'] ?? 'Unknown device'),
              subtitle: Text(s['ip'] ?? ''),
              trailing: s['current'] == true
                  ? const Chip(label: Text('Current', style: TextStyle(fontSize: 10)))
                  : TextButton(
                      onPressed: () async {
                        await ref.read(userApiProvider).revokeSession(s['id']);
                        ref.invalidate(sessionsProvider);
                      },
                      child: const Text('Revoke'),
                    ),
            ),
          )).toList(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (_, __) => const Text('Failed to load sessions'),
      ),
    ]);
  }
}

class _NotificationsTab extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ListView(padding: const EdgeInsets.all(24), children: [
      Text('Notification Settings', style: Theme.of(context).textTheme.titleLarge),
      const SizedBox(height: 16),
      _NotifRow('Income Accrual', 'Monthly accruals on your shares'),
      _NotifRow('Payout', 'Withdrawal status updates'),
      _NotifRow('P2P Trades', 'New orders and completed trades'),
      _NotifRow('Platform News', 'Updates, promotions'),
      _NotifRow('Security', 'Account logins, password changes'),
      _NotifRow('Reports', 'Monthly object reports'),
    ]);
  }

  Widget _NotifRow(String title, String subtitle) {
    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: SwitchListTile(
        title: Text(title),
        subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
        value: true,
        onChanged: (_) {/* TODO */},
        activeColor: AppColors.gold,
      ),
    );
  }
}

class _VerificationTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authProvider).user;
    final status = user?.kycStatus;

    return ListView(padding: const EdgeInsets.all(24), children: [
      Center(
        child: Icon(
          _icon(status),
          size: 64,
          color: _color(status),
        ),
      ),
      const SizedBox(height: 16),
      Text(_title(status), style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold), textAlign: TextAlign.center),
      const SizedBox(height: 8),
      Text(_desc(status), style: const TextStyle(color: AppColors.textMuted), textAlign: TextAlign.center),
      const SizedBox(height: 32),
      if (status != null && (status.name == 'none' || status.name == 'rejected'))
        ElevatedButton(onPressed: () {/* TODO: Stripe Identity */}, child: const Text('Start Verification')),
    ]);
  }

  IconData _icon(dynamic s) {
    final name = s?.name ?? 'none';
    switch (name) {
      case 'verified': return Icons.verified;
      case 'pending': return Icons.hourglass_top;
      case 'rejected': return Icons.cancel;
      default: return Icons.shield;
    }
  }

  Color _color(dynamic s) {
    final name = s?.name ?? 'none';
    switch (name) {
      case 'verified': return AppColors.success;
      case 'pending': return AppColors.warning;
      case 'rejected': return AppColors.error;
      default: return AppColors.textMuted;
    }
  }

  String _title(dynamic s) {
    final name = s?.name ?? 'none';
    switch (name) {
      case 'verified': return 'Verification Complete';
      case 'pending': return 'Under Review';
      case 'rejected': return 'Verification Rejected';
      default: return 'Not Verified';
    }
  }

  String _desc(dynamic s) {
    final name = s?.name ?? 'none';
    switch (name) {
      case 'verified': return 'Your identity is confirmed. All features available.';
      case 'pending': return 'Documents are being reviewed (up to 24 hours).';
      case 'rejected': return 'Verification failed. Please try again.';
      default: return 'Complete KYC for full platform access.';
    }
  }
}
