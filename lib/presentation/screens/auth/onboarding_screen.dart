import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:go_router/go_router.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import '../../../core/storage/secure_storage.dart';
import '../../../core/theme/app_theme.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final _controller = PageController();
  int _currentPage = 0;

  List<_OnboardingPage> _buildPages(S? l) => [
    _OnboardingPage(
      icon: Icons.apartment,
      title: l?.onboardingTitle1 ?? 'Invest in Hotels',
      subtitle: l?.onboardingSubtitle1 ??
          'Own shares in premium hotel rooms and earn passive income from tourism.',
    ),
    _OnboardingPage(
      icon: Icons.trending_up,
      title: l?.onboardingTitle2 ?? 'Monthly Income',
      subtitle: l?.onboardingSubtitle2 ??
          'Receive monthly accruals from hotel operations proportional to your shares.',
    ),
    _OnboardingPage(
      icon: Icons.swap_horiz,
      title: l?.onboardingTitle3 ?? 'P2P Marketplace',
      subtitle: l?.onboardingSubtitle3 ??
          'Buy and sell shares on the secondary market. Full liquidity for your investment.',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final pages = _buildPages(l);

    return Scaffold(
      backgroundColor: AppColors.dark,
      body: SafeArea(
        child: Column(
          children: [
            // Skip button
            Align(
              alignment: Alignment.topRight,
              child: TextButton(
                onPressed: _finish,
                child: Text(l?.skip ?? 'Skip',
                    style: const TextStyle(color: AppColors.gold)),
              ),
            ),
            // Pages
            Expanded(
              child: PageView(
                controller: _controller,
                onPageChanged: (i) => setState(() => _currentPage = i),
                children: pages,
              ),
            ),
            // Indicator
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 24),
              child: SmoothPageIndicator(
                controller: _controller,
                count: pages.length,
                effect: const WormEffect(
                  dotColor: Colors.white24,
                  activeDotColor: AppColors.gold,
                  dotHeight: 8,
                  dotWidth: 8,
                ),
              ),
            ),
            // Button
            Padding(
              padding: const EdgeInsets.fromLTRB(24, 0, 24, 32),
              child: ElevatedButton(
                onPressed: _currentPage == pages.length - 1
                    ? _finish
                    : () => _controller.nextPage(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.easeInOut,
                        ),
                child: Text(
                    _currentPage == pages.length - 1
                        ? (l?.getStarted ?? 'Get Started')
                        : (l?.next ?? 'Next')),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> _finish() async {
    await SecureStorage.setOnboardingSeen();
    if (mounted) context.go('/login');
  }
}

class _OnboardingPage extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;

  const _OnboardingPage({
    required this.icon,
    required this.title,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 40),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            width: 120,
            height: 120,
            decoration: BoxDecoration(
              color: AppColors.gold.withOpacity(0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 56, color: AppColors.gold),
          ).animate().fadeIn(duration: 500.ms).scale(begin: const Offset(0.9, 0.9), end: const Offset(1, 1), duration: 500.ms, curve: Curves.easeOut),
          const SizedBox(height: 40),
          Text(
            title,
            style: const TextStyle(
              fontSize: 26,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 400.ms, delay: 150.ms).slideY(begin: 0.05, end: 0, duration: 400.ms, delay: 150.ms),
          const SizedBox(height: 16),
          Text(
            subtitle,
            style: const TextStyle(
              fontSize: 16,
              color: Colors.white60,
              height: 1.5,
            ),
            textAlign: TextAlign.center,
          ).animate().fadeIn(duration: 400.ms, delay: 250.ms).slideY(begin: 0.05, end: 0, duration: 400.ms, delay: 250.ms),
        ],
      ),
    );
  }
}
