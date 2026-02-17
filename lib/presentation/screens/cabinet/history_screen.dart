import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/data_providers.dart';
import '../../../data/models/models.dart';

class HistoryScreen extends ConsumerStatefulWidget {
  const HistoryScreen({super.key});

  @override
  ConsumerState<HistoryScreen> createState() => _HistoryScreenState();
}

class _HistoryScreenState extends ConsumerState<HistoryScreen> {
  String? _filter;
  int _page = 1;

  @override
  Widget build(BuildContext context) {
    final txAsync = ref.watch(transactionsProvider({'page': _page, 'limit': 20, 'type': _filter}));

    return Scaffold(
      appBar: AppBar(title: const Text('Transaction History')),
      body: Column(
        children: [
          // Filters
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(children: [
              _FilterChip('All', null),
              _FilterChip('Deposits', 'deposit'),
              _FilterChip('Purchases', 'share_purchase'),
              _FilterChip('Sales', 'share_sale'),
              _FilterChip('Accruals', 'income_accrual'),
              _FilterChip('Withdrawals', 'withdrawal'),
            ]),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async => ref.invalidate(transactionsProvider({'page': _page, 'limit': 20, 'type': _filter})),
              child: txAsync.when(
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Center(child: Text('Error: $e')),
                data: (transactions) {
                  if (transactions.isEmpty) {
                    return const Center(child: Text('No transactions', style: TextStyle(color: AppColors.textMuted)));
                  }
                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    itemCount: transactions.length,
                    itemBuilder: (_, i) {
                      final tx = transactions[i];
                      final isPositive = tx.type == TransactionType.deposit || tx.type == TransactionType.incomeAccrual || tx.type == TransactionType.shareSale || tx.type == TransactionType.p2pSell;
                      return ListTile(
                        leading: CircleAvatar(
                          radius: 18,
                          backgroundColor: (isPositive ? AppColors.success : AppColors.error).withOpacity(0.1),
                          child: Icon(isPositive ? Icons.arrow_downward : Icons.arrow_upward, size: 18, color: isPositive ? AppColors.success : AppColors.error),
                        ),
                        title: Text(tx.description, maxLines: 1, overflow: TextOverflow.ellipsis),
                        subtitle: Text(tx.date.substring(0, 10)),
                        trailing: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text('${isPositive ? "+" : "-"}${tx.amount.toStringAsFixed(0)} EUR', style: TextStyle(fontWeight: FontWeight.w600, color: isPositive ? AppColors.success : AppColors.error)),
                            Text(_statusLabel(tx.status), style: TextStyle(fontSize: 10, color: _statusColor(tx.status))),
                          ],
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _FilterChip(String label, String? type) {
    final selected = _filter == type;
    return Padding(
      padding: const EdgeInsets.only(right: 8),
      child: ChoiceChip(
        label: Text(label),
        selected: selected,
        onSelected: (_) => setState(() { _filter = type; _page = 1; }),
        selectedColor: AppColors.gold,
        labelStyle: TextStyle(color: selected ? Colors.white : null),
      ),
    );
  }

  String _statusLabel(TransactionStatus s) {
    switch (s) {
      case TransactionStatus.completed: return 'Completed';
      case TransactionStatus.pending: return 'Pending';
      case TransactionStatus.failed: return 'Failed';
    }
  }

  Color _statusColor(TransactionStatus s) {
    switch (s) {
      case TransactionStatus.completed: return AppColors.success;
      case TransactionStatus.pending: return AppColors.warning;
      case TransactionStatus.failed: return AppColors.error;
    }
  }
}
