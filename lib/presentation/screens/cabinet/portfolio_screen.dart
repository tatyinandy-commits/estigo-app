import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/data_providers.dart';
import '../../widgets/common/stat_card.dart';

class PortfolioScreen extends ConsumerWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final portfolioAsync = ref.watch(portfolioProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('My Portfolio')),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(portfolioProvider),
        child: portfolioAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (shares) {
            if (shares.isEmpty) {
              return const Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.pie_chart_outline, size: 64, color: AppColors.textMuted),
                    SizedBox(height: 16),
                    Text('Portfolio is empty', style: TextStyle(fontSize: 18, color: AppColors.textMuted)),
                    SizedBox(height: 8),
                    Text('Buy your first shares to start investing'),
                  ],
                ),
              );
            }

            final totalInvested = shares.fold<double>(0, (s, e) => s + e.purchasePrice);
            final totalValue = shares.fold<double>(0, (s, e) => s + e.currentValue);
            final totalIncome = shares.fold<double>(0, (s, e) => s + e.totalIncome);
            final gain = totalValue - totalInvested;

            return ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Row(children: [
                  Expanded(child: StatCard(title: 'Invested', value: '${totalInvested.toStringAsFixed(0)} EUR', icon: Icons.arrow_upward, color: AppColors.info)),
                  const SizedBox(width: 12),
                  Expanded(child: StatCard(title: 'Value', value: '${totalValue.toStringAsFixed(0)} EUR', icon: Icons.trending_up, color: AppColors.success)),
                ]),
                const SizedBox(height: 12),
                Row(children: [
                  Expanded(child: StatCard(title: 'Income', value: '${totalIncome.toStringAsFixed(0)} EUR', icon: Icons.monetization_on, color: AppColors.gold)),
                  const SizedBox(width: 12),
                  Expanded(child: StatCard(title: 'Gain', value: '${gain >= 0 ? "+" : ""}${gain.toStringAsFixed(0)} EUR', icon: Icons.show_chart, color: gain >= 0 ? AppColors.success : AppColors.error)),
                ]),
                const SizedBox(height: 24),

                // Pie chart
                Text('Allocation', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                SizedBox(
                  height: 200,
                  child: PieChart(
                    PieChartData(
                      sections: shares.asMap().entries.map((e) {
                        final colors = [AppColors.gold, AppColors.info, AppColors.success, AppColors.warning, AppColors.error];
                        return PieChartSectionData(
                          value: e.value.currentValue,
                          title: 'R${e.value.roomNumber}',
                          color: colors[e.key % colors.length],
                          radius: 60,
                          titleStyle: const TextStyle(fontSize: 11, color: Colors.white, fontWeight: FontWeight.bold),
                        );
                      }).toList(),
                      centerSpaceRadius: 40,
                    ),
                  ),
                ),
                const SizedBox(height: 24),

                // Positions
                Text('Positions', style: Theme.of(context).textTheme.titleLarge),
                const SizedBox(height: 12),
                ...shares.map((s) {
                  final profit = s.currentValue - s.purchasePrice;
                  return Card(
                    margin: const EdgeInsets.only(bottom: 12),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(children: [
                            Text('Room ${s.roomNumber}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                            const Spacer(),
                            Text(s.roomType, style: const TextStyle(color: AppColors.textMuted)),
                          ]),
                          const SizedBox(height: 12),
                          Row(children: [
                            _Info('Shares', '${s.shares}'),
                            _Info('Cost', '${s.purchasePrice.toStringAsFixed(0)}'),
                            _Info('Value', '${s.currentValue.toStringAsFixed(0)}'),
                            _Info('Income', '+${s.totalIncome.toStringAsFixed(0)}'),
                          ]),
                          const SizedBox(height: 8),
                          Row(children: [
                            Text(
                              '${profit >= 0 ? "+" : ""}${profit.toStringAsFixed(0)} EUR',
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: profit >= 0 ? AppColors.success : AppColors.error,
                              ),
                            ),
                            const Spacer(),
                            Text('Bought: ${s.purchaseDate.substring(0, 10)}', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                          ]),
                        ],
                      ),
                    ),
                  );
                }),
              ],
            );
          },
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final String label;
  final String value;
  const _Info(this.label, this.value);
  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500, fontSize: 13)),
      ],
    ),
  );
}
