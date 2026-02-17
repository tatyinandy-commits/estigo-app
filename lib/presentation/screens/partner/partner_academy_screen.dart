import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../core/theme/app_theme.dart';

class PartnerAcademyScreen extends StatelessWidget {
  const PartnerAcademyScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final modules = [
      {'title': l?.academyTitle1 ?? 'Product in Plain Language', 'desc': l?.academyDesc1 ?? 'Understanding the product, investment structure, legal basis.', 'lessons': 4},
      {'title': l?.academyTitle2 ?? 'Working in the Cabinet', 'desc': l?.academyDesc2 ?? 'Cabinet navigation, portfolio and referral management.', 'lessons': 3},
      {'title': l?.academyTitle3 ?? 'Partner Program', 'desc': l?.academyDesc3 ?? 'Levels, commissions, attraction strategies.', 'lessons': 5},
      {'title': l?.academyTitle4 ?? 'Objections & Limitations', 'desc': l?.academyDesc4 ?? 'Answering questions, legal limitations.', 'lessons': 4},
      {'title': l?.academyTitle5 ?? 'Brand Guide', 'desc': l?.academyDesc5 ?? 'Brand rules, templates, tone of voice.', 'lessons': 3},
    ];

    return Scaffold(
      appBar: AppBar(title: Text(l?.partnerAcademy ?? 'Partner Academy')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: modules.length,
        itemBuilder: (_, i) {
          final m = modules[i];
          final count = m['lessons'] as int;
          return Card(
            margin: const EdgeInsets.only(bottom: 12),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(children: [
                    Container(
                      width: 32, height: 32,
                      decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.2), borderRadius: BorderRadius.circular(8)),
                      child: Center(child: Text('${i + 1}', style: const TextStyle(fontWeight: FontWeight.bold, color: AppColors.gold))),
                    ),
                    const SizedBox(width: 12),
                    Expanded(child: Text(m['title'] as String, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))),
                  ]),
                  const SizedBox(height: 8),
                  Text(m['desc'] as String, style: const TextStyle(color: AppColors.textMuted)),
                  const SizedBox(height: 8),
                  Text(l?.lessonsCount(count) ?? '$count lessons', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(l?.comingSoon ?? 'Module content coming soon')),
                        );
                      },
                      child: Text(l?.start ?? 'Start'),
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
