import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';
import '../../../domain/providers/api_providers.dart';
import '../../../domain/providers/auth_provider.dart';

class BuySharesSheet extends ConsumerStatefulWidget {
  final Room room;
  const BuySharesSheet({super.key, required this.room});

  @override
  ConsumerState<BuySharesSheet> createState() => _BuySharesSheetState();
}

class _BuySharesSheetState extends ConsumerState<BuySharesSheet> {
  int _shares = 1;
  String _method = 'balance';
  bool _loading = false;
  int _step = 1;

  double get _total => _shares * widget.room.sharePrice;

  Future<void> _buy() async {
    setState(() => _loading = true);
    try {
      if (_method == 'balance') {
        await ref.read(paymentApiProvider).payFromBalance(
          roomId: widget.room.id,
          shares: _shares,
        );
      } else if (_method == 'stripe') {
        await ref.read(paymentApiProvider).createStripeCheckout(
          purpose: 'share_purchase',
          amount: _total,
          roomId: widget.room.id,
          shares: _shares,
        );
      } else {
        await ref.read(paymentApiProvider).createCryptoPayment(
          purpose: 'share_purchase',
          amount: _total,
          roomId: widget.room.id,
          shares: _shares,
        );
      }
      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Purchase successful!'), backgroundColor: AppColors.success),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Error: $e'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final user = ref.watch(authProvider).user;
    final balance = user?.balance ?? 0;

    return Padding(
      padding: EdgeInsets.only(
        left: 24, right: 24, top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(child: Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade400, borderRadius: BorderRadius.circular(2)))),
          const SizedBox(height: 16),
          Text(_step == 1 ? 'Buy Shares' : 'Payment Method', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          Text('Room ${widget.room.number} | Floor ${widget.room.floor}', style: const TextStyle(color: AppColors.textMuted)),
          Text('Price: ${widget.room.sharePrice.toStringAsFixed(0)} EUR/share'),
          const SizedBox(height: 16),

          if (_step == 1) ...[
            Row(
              children: [
                IconButton(onPressed: _shares > 1 ? () => setState(() => _shares--) : null, icon: const Icon(Icons.remove_circle_outline)),
                Text('$_shares', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                IconButton(onPressed: _shares < widget.room.availableShares ? () => setState(() => _shares++) : null, icon: const Icon(Icons.add_circle_outline)),
              ],
              mainAxisAlignment: MainAxisAlignment.center,
            ),
            const SizedBox(height: 8),
            Text('Available: ${widget.room.availableShares}', style: const TextStyle(color: AppColors.textMuted), textAlign: TextAlign.center),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(color: AppColors.gold.withOpacity(0.1), borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Total:', style: TextStyle(fontWeight: FontWeight.w600)),
                  Text('${_total.toStringAsFixed(0)} EUR', style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.gold)),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(onPressed: () => setState(() => _step = 2), child: const Text('Next')),
          ] else ...[
            _buildMethodOption('balance', 'Balance', 'Available: ${balance.toStringAsFixed(0)} EUR', Icons.account_balance_wallet),
            const SizedBox(height: 8),
            _buildMethodOption('stripe', 'Bank Card', 'Visa, Mastercard', Icons.credit_card),
            const SizedBox(height: 8),
            _buildMethodOption('crypto', 'Crypto', 'BTC, ETH, USDT', Icons.currency_bitcoin),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(child: OutlinedButton(onPressed: () => setState(() => _step = 1), child: const Text('Back'))),
                const SizedBox(width: 12),
                Expanded(child: ElevatedButton(onPressed: _loading ? null : _buy, child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : const Text('Pay'))),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Widget _buildMethodOption(String value, String title, String subtitle, IconData icon) {
    final selected = _method == value;
    return InkWell(
      onTap: () => setState(() => _method = value),
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: selected ? AppColors.gold : Colors.grey.shade300, width: selected ? 2 : 1),
        ),
        child: Row(children: [
          Icon(icon, color: selected ? AppColors.gold : Colors.grey),
          const SizedBox(width: 12),
          Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
            Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
          ]),
          const Spacer(),
          if (selected) const Icon(Icons.check_circle, color: AppColors.gold),
        ]),
      ),
    );
  }
}
