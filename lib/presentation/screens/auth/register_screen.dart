import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/auth_provider.dart';

class RegisterScreen extends ConsumerStatefulWidget {
  const RegisterScreen({super.key});

  @override
  ConsumerState<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends ConsumerState<RegisterScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _referralController = TextEditingController();
  bool _obscurePassword = true;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _referralController.dispose();
    super.dispose();
  }

  Future<void> _register() async {
    if (!_formKey.currentState!.validate()) return;

    await ref.read(authProvider.notifier).register(
          _nameController.text.trim(),
          _emailController.text.trim(),
          _passwordController.text,
          referralCode: _referralController.text.trim().isNotEmpty
              ? _referralController.text.trim()
              : null,
        );

    if (!mounted) return;

    final auth = ref.read(authProvider);
    if (auth.isAuthenticated) {
      context.go('/cabinet');
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final l = S.of(context);

    return Scaffold(
      backgroundColor: AppColors.dark,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => context.pop(),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  l?.createAccount ?? 'Create Account',
                  style: const TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  l?.startInvesting ?? 'Start investing in hotel rooms',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.white.withOpacity(0.6),
                  ),
                ),
                const SizedBox(height: 32),

                if (authState.error != null) ...[
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: AppColors.error.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(authState.error!,
                        style: const TextStyle(color: AppColors.error)),
                  ),
                  const SizedBox(height: 16),
                ],

                TextFormField(
                  controller: _nameController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: l?.fullName ?? 'Full Name',
                    labelStyle: const TextStyle(color: Colors.white54),
                    prefixIcon:
                        const Icon(Icons.person_outline, color: Colors.white38),
                  ),
                  validator: (v) =>
                      v == null || v.isEmpty ? (l?.enterName ?? 'Enter your name') : null,
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _emailController,
                  keyboardType: TextInputType.emailAddress,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: l?.email ?? 'Email',
                    labelStyle: const TextStyle(color: Colors.white54),
                    prefixIcon:
                        const Icon(Icons.email_outlined, color: Colors.white38),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return l?.enterEmail ?? 'Enter email';
                    if (!v.contains('@')) return l?.invalidEmail ?? 'Invalid email';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _passwordController,
                  obscureText: _obscurePassword,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: l?.password ?? 'Password',
                    labelStyle: const TextStyle(color: Colors.white54),
                    prefixIcon:
                        const Icon(Icons.lock_outline, color: Colors.white38),
                    suffixIcon: IconButton(
                      icon: Icon(
                        _obscurePassword
                            ? Icons.visibility_off
                            : Icons.visibility,
                        color: Colors.white38,
                      ),
                      onPressed: () =>
                          setState(() => _obscurePassword = !_obscurePassword),
                    ),
                  ),
                  validator: (v) {
                    if (v == null || v.isEmpty) return l?.enterPassword ?? 'Enter password';
                    if (v.length < 8) return l?.minChars ?? 'Minimum 8 characters';
                    return null;
                  },
                ),
                const SizedBox(height: 16),

                TextFormField(
                  controller: _referralController,
                  style: const TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    labelText: l?.referralCodeOptional ?? 'Referral Code (optional)',
                    labelStyle: const TextStyle(color: Colors.white54),
                    prefixIcon: const Icon(Icons.card_giftcard, color: Colors.white38),
                  ),
                ),
                const SizedBox(height: 32),

                ElevatedButton(
                  onPressed: authState.isLoading ? null : _register,
                  child: authState.isLoading
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                              strokeWidth: 2, color: Colors.white),
                        )
                      : Text(l?.createAccount ?? 'Create Account'),
                ),
                const SizedBox(height: 16),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(l?.alreadyHaveAccount ?? 'Already have an account?',
                        style: const TextStyle(color: Colors.white54)),
                    TextButton(
                      onPressed: () => context.go('/login'),
                      child: Text(l?.signIn ?? 'Sign In',
                          style: const TextStyle(color: AppColors.gold)),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
