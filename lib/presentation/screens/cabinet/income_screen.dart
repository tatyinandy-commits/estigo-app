import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';
import '../../../domain/providers/data_providers.dart';
import '../../../domain/providers/api_providers.dart';
import '../../widgets/common/error_view.dart';

class IncomeScreen extends ConsumerStatefulWidget {
  const IncomeScreen({super.key});

  @override
  ConsumerState<IncomeScreen> createState() => _IncomeScreenState();
}

class _IncomeScreenState extends ConsumerState<IncomeScreen> with SingleTickerProviderStateMixin {
  late TabController _tab;

  @override
  void initState() {
    super.initState();
    _tab = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tab.dispose();
    super.dispose();
  }

  void _showWithdraw() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _WithdrawSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final accrualsAsync = ref.watch(incomeAccrualsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l?.income ?? 'Income & Payouts'),
        actions: [
          TextButton.icon(onPressed: _showWithdraw, icon: const Icon(Icons.output), label: Text(l?.withdrawFunds ?? 'Withdraw')),
        ],
        bottom: TabBar(controller: _tab, tabs: const [Tab(text: 'Accruals'), Tab(text: 'Payouts')]),
      ),
      body: TabBarView(
        controller: _tab,
        children: [
          // Accruals
          RefreshIndicator(
            onRefresh: () async => ref.invalidate(incomeAccrualsProvider),
            child: accrualsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (e, _) => ErrorView(
                message: e.toString(),
                onRetry: () => ref.invalidate(incomeAccrualsProvider),
              ),
              data: (accruals) {
                if (accruals.isEmpty) return Center(child: Text(l?.noData ?? 'No accruals yet'));
                final total = accruals.fold<double>(0, (s, e) => s + e.distributedPerShare);
                return ListView(
                  padding: const EdgeInsets.all(16),
                  children: [
                    SizedBox(
                      height: 200,
                      child: BarChart(BarChartData(
                        barGroups: accruals.asMap().entries.map((e) => BarChartGroupData(x: e.key, barRods: [
                          BarChartRodData(toY: e.value.netProfit, color: AppColors.gold, width: 16, borderRadius: BorderRadius.circular(4)),
                        ])).toList(),
                        titlesData: FlTitlesData(
                          leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          bottomTitles: AxisTitles(sideTitles: SideTitles(showTitles: true, getTitlesWidget: (v, _) {
                            if (v.toInt() < accruals.length) return Text(accruals[v.toInt()].month.substring(0, 3), style: const TextStyle(fontSize: 10));
                            return const SizedBox.shrink();
                          })),
                        ),
                        borderData: FlBorderData(show: false),
                        gridData: const FlGridData(show: false),
                      )),
                    ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.04, end: 0, duration: 400.ms),
                    const SizedBox(height: 16),
                    ...accruals.asMap().entries.map((entry) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(entry.value.month),
                        subtitle: Text('Revenue: ${entry.value.revenue.toStringAsFixed(0)} | Expenses: ${entry.value.expenses.toStringAsFixed(0)}'),
                        trailing: Text('+${entry.value.distributedPerShare.toStringAsFixed(2)} EUR/share', style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold)),
                      ),
                    ).animate().fadeIn(duration: 300.ms, delay: (100 + entry.key * 60).ms).slideY(begin: 0.03, end: 0, duration: 300.ms, delay: (100 + entry.key * 60).ms)),
                    const SizedBox(height: 12),
                    Text('Total: ${total.toStringAsFixed(2)} EUR/share', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                  ],
                );
              },
            ),
          ),
          // Payouts
          _PayoutsTab(),
        ],
      ),
    );
  }
}

class _PayoutsTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = S.of(context);
    final payoutsAsync = ref.watch(payoutsProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(payoutsProvider),
      child: payoutsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(payoutsProvider),
        ),
        data: (payouts) {
          if (payouts.isEmpty) {
            return ListView(
              children: [
                const SizedBox(height: 200),
                Center(child: Text(l?.noData ?? 'No payouts yet')),
              ],
            );
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: payouts.length,
            itemBuilder: (context, index) {
              final p = payouts[index];
              return Card(
                margin: const EdgeInsets.only(bottom: 8),
                child: ListTile(
                  title: Text(
                    '\u20AC${p.amount.toStringAsFixed(2)}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    '${_maskIban(p.iban)} \u2022 ${_formatDate(p.createdAt)}',
                  ),
                  trailing: _StatusBadge(status: p.status),
                ),
              );
            },
          );
        },
      ),
    );
  }

  static String _maskIban(String iban) {
    if (iban.length <= 4) return iban;
    return '****${iban.substring(iban.length - 4)}';
  }

  static String _formatDate(String iso) {
    try {
      final dt = DateTime.parse(iso);
      return '${dt.day.toString().padLeft(2, '0')}.${dt.month.toString().padLeft(2, '0')}.${dt.year}';
    } catch (_) {
      return iso;
    }
  }
}

class _StatusBadge extends StatelessWidget {
  final String status;
  const _StatusBadge({required this.status});

  @override
  Widget build(BuildContext context) {
    final (Color bg, Color fg) = switch (status) {
      'pending' => (AppColors.warning, Colors.black87),
      'approved' => (AppColors.info, Colors.white),
      'completed' => (AppColors.success, Colors.white),
      'rejected' => (AppColors.error, Colors.white),
      _ => (AppColors.textMuted, Colors.white),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Text(
        status[0].toUpperCase() + status.substring(1),
        style: TextStyle(color: fg, fontSize: 12, fontWeight: FontWeight.w600),
      ),
    );
  }
}

class _WithdrawSheet extends ConsumerStatefulWidget {
  const _WithdrawSheet();
  @override
  ConsumerState<_WithdrawSheet> createState() => _WithdrawSheetState();
}

class _WithdrawSheetState extends ConsumerState<_WithdrawSheet> {
  final _amountC = TextEditingController();
  final _ibanC = TextEditingController();
  final _nameC = TextEditingController();
  bool _loading = false;

  Future<void> _submit() async {
    final amount = double.tryParse(_amountC.text) ?? 0;
    if (amount < 100 || _ibanC.text.isEmpty || _nameC.text.isEmpty) return;
    setState(() => _loading = true);
    try {
      await ref.read(transactionApiProvider).requestPayout(amount: amount, iban: _ibanC.text, recipientName: _nameC.text);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        final l = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l?.operationFailed ?? 'Operation failed')));
      }
    } finally { setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text(l?.withdrawFunds ?? 'Withdraw Funds', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        TextFormField(controller: _amountC, keyboardType: TextInputType.number, decoration: InputDecoration(labelText: '${l?.amount ?? 'Amount'} (EUR)', helperText: 'Min: 100 EUR')),
        const SizedBox(height: 12),
        TextFormField(controller: _ibanC, decoration: const InputDecoration(labelText: 'IBAN')),
        const SizedBox(height: 12),
        TextFormField(controller: _nameC, decoration: const InputDecoration(labelText: 'Recipient Name')),
        const SizedBox(height: 8),
        const Text('Fee: 0% | Processing: 1-3 business days', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : Text(l?.submit ?? 'Submit Request')),
      ]),
    );
  }
}
