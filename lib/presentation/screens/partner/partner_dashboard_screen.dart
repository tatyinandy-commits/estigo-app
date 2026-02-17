import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/data_providers.dart';
import '../../widgets/common/stat_card.dart';

class PartnerDashboardScreen extends ConsumerWidget {
  const PartnerDashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partnerAsync = ref.watch(partnerDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Partner Dashboard')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(partnerDataProvider),
        child: partnerAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (partner) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              Row(children: [
                Expanded(child: StatCard(title: 'Referrals', value: '${partner.totalReferrals}', icon: Icons.people, color: AppColors.info)),
                const SizedBox(width: 12),
                Expanded(child: StatCard(title: 'Commission', value: '${partner.totalCommission.toStringAsFixed(0)} EUR', icon: Icons.monetization_on, color: AppColors.gold)),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: StatCard(title: 'Tier', value: partner.tier.name.toUpperCase(), icon: Icons.star, color: AppColors.warning)),
                const SizedBox(width: 12),
                Expanded(child: StatCard(title: 'Rate', value: '${(partner.commissionRate * 100).toStringAsFixed(0)}%', icon: Icons.percent, color: AppColors.success)),
              ]),
              const SizedBox(height: 24),
              ListTile(
                leading: const Icon(Icons.people),
                title: const Text('My Referrals'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go('/partner/referrals'),
              ),
              ListTile(
                leading: const Icon(Icons.school),
                title: const Text('Partner Academy'),
                trailing: const Icon(Icons.chevron_right),
                onTap: () => context.go('/partner/academy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
