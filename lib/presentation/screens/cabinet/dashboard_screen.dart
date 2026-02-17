import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/auth_provider.dart';
import '../../../domain/providers/data_providers.dart';
import '../../widgets/common/stat_card.dart';
import '../../widgets/common/section_header.dart';
import '../../widgets/sheets/deposit_sheet.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authProvider);
    final user = auth.user;
    final portfolio = ref.watch(portfolioProvider);
    final transactions = ref.watch(recentTransactionsProvider);
    final monthlyIncome = ref.watch(monthlyIncomeProvider);
    final notifications = ref.watch(notificationsProvider);
    final unreadCount = notifications.whenOrNull(
          data: (list) => list.where((n) => !n.read).length,
        ) ??
        0;

    return Scaffold(
      appBar: AppBar(
        title: Text('Welcome, ${user?.name ?? "Investor"}'),
        actions: [
          Badge(
            isLabelVisible: unreadCount > 0,
            label: Text('$unreadCount'),
            child: IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () => context.go('/cabinet/notifications'),
            ),
          ),
          Builder(
            builder: (ctx) => IconButton(
              icon: const Icon(Icons.menu),
              onPressed: () => Scaffold.of(ctx).openDrawer(),
            ),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(portfolioProvider);
          ref.invalidate(recentTransactionsProvider);
          ref.invalidate(monthlyIncomeProvider);
        },
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            // Stat cards
            Row(
              children: [
                Expanded(
                  child: StatCard(
                    title: 'Balance',
                    value: '${user?.balance.toStringAsFixed(0) ?? "0"} EUR',
                    icon: Icons.account_balance_wallet,
                    color: AppColors.info,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: portfolio.when(
                    data: (shares) {
                      final total = shares.fold<double>(
                          0, (s, e) => s + e.currentValue);
                      return StatCard(
                        title: 'Portfolio',
                        value: '${total.toStringAsFixed(0)} EUR',
                        icon: Icons.pie_chart,
                        color: AppColors.success,
                      );
                    },
                    loading: () =>
                        const StatCard(title: 'Portfolio', value: '...', icon: Icons.pie_chart, color: AppColors.success),
                    error: (_, __) =>
                        const StatCard(title: 'Portfolio', value: '-', icon: Icons.pie_chart, color: AppColors.success),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                Expanded(
                  child: portfolio.when(
                    data: (shares) {
                      final income = shares.fold<double>(
                          0, (s, e) => s + e.totalIncome);
                      return StatCard(
                        title: 'Income',
                        value: '${income.toStringAsFixed(0)} EUR',
                        icon: Icons.trending_up,
                        color: AppColors.gold,
                      );
                    },
                    loading: () =>
                        const StatCard(title: 'Income', value: '...', icon: Icons.trending_up, color: AppColors.gold),
                    error: (_, __) =>
                        const StatCard(title: 'Income', value: '-', icon: Icons.trending_up, color: AppColors.gold),
                  ),
                ),
                const SizedBox(width: 12),
                const Expanded(
                  child: StatCard(
                    title: 'Active P2P',
                    value: '0',
                    icon: Icons.swap_horiz,
                    color: AppColors.warning,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Quick Actions
            const SectionHeader(title: 'Quick Actions'),
            const SizedBox(height: 12),
            Row(
              children: [
                _QuickAction(
                  icon: Icons.shopping_cart,
                  label: 'Buy Shares',
                  onTap: () => context.go('/cabinet/object'),
                ),
                const SizedBox(width: 12),
                _QuickAction(
                  icon: Icons.add_card,
                  label: 'Top Up',
                  onTap: () => showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (_) => const DepositSheet(),
                  ),
                ),
                const SizedBox(width: 12),
                _QuickAction(
                  icon: Icons.swap_horiz,
                  label: 'P2P Market',
                  onTap: () => context.go('/cabinet/p2p'),
                ),
              ],
            ),
            const SizedBox(height: 24),

            // Income chart
            const SectionHeader(title: 'Income (6 months)'),
            const SizedBox(height: 12),
            SizedBox(
              height: 200,
              child: monthlyIncome.when(
                data: (data) => _IncomeChart(data: data),
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (_, __) => const Center(child: Text('Failed to load')),
              ),
            ),
            const SizedBox(height: 24),

            // Recent transactions
            SectionHeader(
              title: 'Recent Transactions',
              action: TextButton(
                onPressed: () => context.go('/cabinet/history'),
                child: const Text('View All'),
              ),
            ),
            const SizedBox(height: 8),
            transactions.when(
              data: (list) {
                if (list.isEmpty) {
                  return const Padding(
                    padding: EdgeInsets.all(24),
                    child: Center(
                        child: Text('No transactions yet',
                            style: TextStyle(color: AppColors.textMuted))),
                  );
                }
                return Column(
                  children: list.map((tx) {
                    final isPositive = tx.type.name.contains('deposit') ||
                        tx.type.name.contains('income') ||
                        tx.type.name.contains('sale');
                    return ListTile(
                      leading: CircleAvatar(
                        radius: 18,
                        backgroundColor: (isPositive
                                ? AppColors.success
                                : AppColors.error)
                            .withOpacity(0.1),
                        child: Icon(
                          isPositive
                              ? Icons.arrow_downward
                              : Icons.arrow_upward,
                          size: 18,
                          color:
                              isPositive ? AppColors.success : AppColors.error,
                        ),
                      ),
                      title: Text(tx.description, maxLines: 1, overflow: TextOverflow.ellipsis),
                      subtitle: Text(tx.date.substring(0, 10)),
                      trailing: Text(
                        '${isPositive ? "+" : "-"}${tx.amount.toStringAsFixed(0)} EUR',
                        style: TextStyle(
                          fontWeight: FontWeight.w600,
                          color:
                              isPositive ? AppColors.success : AppColors.error,
                        ),
                      ),
                    );
                  }).toList(),
                );
              },
              loading: () =>
                  const Center(child: CircularProgressIndicator()),
              error: (_, __) =>
                  const Center(child: Text('Failed to load transactions')),
            ),
          ],
        ),
      ),
    );
  }
}

class _QuickAction extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback onTap;

  const _QuickAction({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12),
            border: Border.all(
                color: Theme.of(context).dividerColor.withOpacity(0.2)),
          ),
          child: Column(
            children: [
              Icon(icon, color: AppColors.gold),
              const SizedBox(height: 8),
              Text(label,
                  style: const TextStyle(fontSize: 12),
                  textAlign: TextAlign.center),
            ],
          ),
        ),
      ),
    );
  }
}

class _IncomeChart extends StatelessWidget {
  final List data;

  const _IncomeChart({required this.data});

  @override
  Widget build(BuildContext context) {
    if (data.isEmpty) {
      return const Center(child: Text('No data'));
    }

    return BarChart(
      BarChartData(
        barGroups: List.generate(data.length, (i) {
          final item = data[i];
          return BarChartGroupData(x: i, barRods: [
            BarChartRodData(
              toY: (item.netProfit as double?) ?? 0,
              color: AppColors.gold,
              width: 16,
              borderRadius: BorderRadius.circular(4),
            ),
          ]);
        }),
        titlesData: FlTitlesData(
          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                if (value.toInt() < data.length) {
                  final m = data[value.toInt()];
                  return Padding(
                    padding: const EdgeInsets.only(top: 8),
                    child: Text(
                      (m.month as String).substring(0, 3),
                      style: const TextStyle(fontSize: 10),
                    ),
                  );
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        ),
        borderData: FlBorderData(show: false),
        gridData: const FlGridData(show: false),
      ),
    );
  }
}
