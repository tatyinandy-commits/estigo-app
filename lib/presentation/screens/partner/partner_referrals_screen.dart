import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/data_providers.dart';

class PartnerReferralsScreen extends ConsumerWidget {
  const PartnerReferralsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final partnerAsync = ref.watch(partnerDataProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Referrals')),
      body: partnerAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
        data: (partner) {
          if (partner.referrals.isEmpty) {
            return const Center(child: Text('No referrals yet', style: TextStyle(color: AppColors.textMuted)));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: partner.referrals.length,
            itemBuilder: (_, i) {
              final r = partner.referrals[i];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  leading: CircleAvatar(child: Text(r.name[0].toUpperCase())),
                  title: Text(r.name),
                  subtitle: Text('Registered: ${r.registeredAt.substring(0, 10)}'),
                  trailing: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text('${r.invested.toStringAsFixed(0)} EUR', style: const TextStyle(fontWeight: FontWeight.bold)),
                      Text('+${r.commission.toStringAsFixed(0)} EUR', style: const TextStyle(color: AppColors.success, fontSize: 12)),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
