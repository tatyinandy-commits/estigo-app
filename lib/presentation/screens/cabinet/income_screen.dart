import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/data_providers.dart';
import '../../../domain/providers/api_providers.dart';

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
    final accrualsAsync = ref.watch(incomeAccrualsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Income & Payouts'),
        actions: [
          TextButton.icon(onPressed: _showWithdraw, icon: const Icon(Icons.output), label: const Text('Withdraw')),
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
              error: (e, _) => Center(child: Text('Error: $e')),
              data: (accruals) {
                if (accruals.isEmpty) return const Center(child: Text('No accruals yet'));
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
                    ),
                    const SizedBox(height: 16),
                    ...accruals.map((a) => Card(
                      margin: const EdgeInsets.only(bottom: 8),
                      child: ListTile(
                        title: Text(a.month),
                        subtitle: Text('Revenue: ${a.revenue.toStringAsFixed(0)} | Expenses: ${a.expenses.toStringAsFixed(0)}'),
                        trailing: Text('+${a.distributedPerShare.toStringAsFixed(2)} EUR/share', style: const TextStyle(color: AppColors.success, fontWeight: FontWeight.bold)),
                      ),
                    )),
                    const SizedBox(height: 12),
                    Text('Total: ${total.toStringAsFixed(2)} EUR/share', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16), textAlign: TextAlign.center),
                  ],
                );
              },
            ),
          ),
          // Payouts placeholder
          const Center(child: Text('Payout history will appear here')),
        ],
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
      if (mounted) ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error: $e')));
    } finally { setState(() => _loading = false); }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Text('Withdraw Funds', style: Theme.of(context).textTheme.titleLarge),
        const SizedBox(height: 16),
        TextFormField(controller: _amountC, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Amount (EUR)', helperText: 'Min: 100 EUR')),
        const SizedBox(height: 12),
        TextFormField(controller: _ibanC, decoration: const InputDecoration(labelText: 'IBAN')),
        const SizedBox(height: 12),
        TextFormField(controller: _nameC, decoration: const InputDecoration(labelText: 'Recipient Name')),
        const SizedBox(height: 8),
        const Text('Fee: 0% | Processing: 1-3 business days', style: TextStyle(fontSize: 12, color: AppColors.textMuted)),
        const SizedBox(height: 24),
        ElevatedButton(onPressed: _loading ? null : _submit, child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Submit Request')),
      ]),
    );
  }
}
