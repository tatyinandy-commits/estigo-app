import 'package:flutter/material.dart';
import '../../../core/theme/app_theme.dart';

class PartnerAcademyScreen extends StatelessWidget {
  const PartnerAcademyScreen({super.key});

  static const _modules = [
    {'title': 'Product in Plain Language', 'desc': 'Understanding the product, investment structure, legal basis.', 'lessons': 4},
    {'title': 'Working in the Cabinet', 'desc': 'Cabinet navigation, portfolio and referral management.', 'lessons': 3},
    {'title': 'Partner Program', 'desc': 'Levels, commissions, attraction strategies.', 'lessons': 5},
    {'title': 'Objections & Limitations', 'desc': 'Answering questions, legal limitations.', 'lessons': 4},
    {'title': 'Brand Guide', 'desc': 'Brand rules, templates, tone of voice.', 'lessons': 3},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Partner Academy')),
      body: ListView.builder(
        padding: const EdgeInsets.all(16),
        itemCount: _modules.length,
        itemBuilder: (_, i) {
          final m = _modules[i];
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
                  Text('${m['lessons']} lessons', style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: OutlinedButton(
                      onPressed: () {
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(content: Text('Module content coming soon')),
                        );
                      },
                      child: const Text('Start'),
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
