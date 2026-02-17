import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:share_plus/share_plus.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/data_providers.dart';
import '../../widgets/common/stat_card.dart';

class ReferralScreen extends ConsumerWidget {
  const ReferralScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partnerAsync = ref.watch(partnerDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Referral Program')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(partnerDataProvider),
        child: partnerAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (partner) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Referral link
              Card(
                child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text('Your Referral Link', style: TextStyle(fontWeight: FontWeight.bold)),
                      const SizedBox(height: 8),
                      Container(
                        padding: const EdgeInsets.all(12),
                        decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.1), borderRadius: BorderRadius.circular(8)),
                        child: Row(children: [
                          Expanded(child: Text(partner.referralLink, style: const TextStyle(fontSize: 13), overflow: TextOverflow.ellipsis)),
                          IconButton(icon: const Icon(Icons.copy, size: 20), onPressed: () {
                            Clipboard.setData(ClipboardData(text: partner.referralLink));
                            ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Copied!')));
                          }),
                          IconButton(icon: const Icon(Icons.share, size: 20), onPressed: () => Share.share(partner.referralLink)),
                        ]),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),

              // Stats
              Row(children: [
                Expanded(child: StatCard(title: 'Referrals', value: '${partner.totalReferrals}', icon: Icons.people, color: AppColors.info)),
                const SizedBox(width: 12),
                Expanded(child: StatCard(title: 'Commission', value: '${partner.totalCommission.toStringAsFixed(0)} EUR', icon: Icons.monetization_on, color: AppColors.gold)),
              ]),
              const SizedBox(height: 12),
              Row(children: [
                Expanded(child: StatCard(title: 'Active', value: '${partner.activeReferrals}', icon: Icons.check_circle, color: AppColors.success)),
                const SizedBox(width: 12),
                Expanded(child: StatCard(title: 'Tier', value: partner.tier.name.toUpperCase(), icon: Icons.star, color: AppColors.warning)),
              ]),
              const SizedBox(height: 24),

              // Referral list
              Text('Referrals', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              if (partner.referrals.isEmpty)
                const Center(child: Padding(padding: EdgeInsets.all(24), child: Text('No referrals yet', style: TextStyle(color: AppColors.textMuted))))
              else
                ...partner.referrals.map((r) => Card(
                  margin: const EdgeInsets.only(bottom: 8),
                  child: ListTile(
                    leading: CircleAvatar(child: Text(r.name[0].toUpperCase())),
                    title: Text(r.name),
                    subtitle: Text('Invested: ${r.invested.toStringAsFixed(0)} EUR'),
                    trailing: Text('+${r.commission.toStringAsFixed(0)} EUR', style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold)),
                  ),
                )),
            ],
          ),
        ),
      ),
    );
  }
}
