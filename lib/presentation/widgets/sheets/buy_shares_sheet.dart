import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';
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
    final l = S.of(context);
    setState(() => _loading = true);
    try {
      if (_method == 'balance') {
        await ref.read(paymentApiProvider).payFromBalance(
          roomId: widget.room.id,
          shares: _shares,
        );
        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text(l?.purchaseSuccessful ?? 'Purchase successful!'), backgroundColor: AppColors.success),
          );
        }
      } else if (_method == 'stripe') {
        final session = await ref.read(paymentApiProvider).createStripeCheckout(
          purpose: 'share_purchase',
          amount: _total,
          roomId: widget.room.id,
          shares: _shares,
        );
        final url = Uri.parse(session.url);
        if (await canLaunchUrl(url)) {
          await launchUrl(url, mode: LaunchMode.externalApplication);
        }
        if (mounted) Navigator.pop(context);
      } else {
        final result = await ref.read(paymentApiProvider).createCryptoPayment(
          purpose: 'share_purchase',
          amount: _total,
          roomId: widget.room.id,
          shares: _shares,
        );
        final paymentUrl = result['payment_url'] ?? result['paymentUrl'] ?? '';
        if (paymentUrl.toString().isNotEmpty) {
          final url = Uri.parse(paymentUrl.toString());
          if (await canLaunchUrl(url)) {
            await launchUrl(url, mode: LaunchMode.externalApplication);
          }
        }
        if (mounted) Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        final l = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(l?.operationFailed ?? 'Operation failed'), backgroundColor: AppColors.error),
        );
      }
    } finally {
      if (mounted) setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final user = ref.watch(authProvider).user;
    final balance = user?.balance ?? 0;

    return Padding(
      padding: EdgeInsets.only(
        left: 24,
        right: 24,
        top: 24,
        bottom: MediaQuery.of(context).viewInsets.bottom + 24,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Center(
            child: Container(
              width: 40,
              height: 4,
              decoration: BoxDecoration(
                color: AppColors.textMuted.withAlpha(80),
                borderRadius: BorderRadius.circular(2),
              ),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            _step == 1 ? (l?.buyShares ?? 'Buy Shares') : (l?.paymentMethod ?? 'Payment Method'),
            style: Theme.of(context).textTheme.titleLarge,
          ),
          const SizedBox(height: 16),
          Text(
            l?.roomFloor(widget.room.number, widget.room.floor) ?? 'Room ${widget.room.number} | Floor ${widget.room.floor}',
            style: const TextStyle(color: AppColors.textMuted),
          ),
          Text(l?.pricePerShare(widget.room.sharePrice.toStringAsFixed(0)) ?? 'Price: ${widget.room.sharePrice.toStringAsFixed(0)} EUR/share'),
          const SizedBox(height: 16),

          if (_step == 1) ...[
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  onPressed: _shares > 1 ? () => setState(() => _shares--) : null,
                  icon: const Icon(Icons.remove_circle_outline),
                ),
                Text('$_shares', style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                IconButton(
                  onPressed: _shares < widget.room.availableShares
                      ? () => setState(() => _shares++)
                      : null,
                  icon: const Icon(Icons.add_circle_outline),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Text(
              l?.availableShares(widget.room.availableShares) ?? 'Available: ${widget.room.availableShares}',
              style: const TextStyle(color: AppColors.textMuted),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: AppColors.gold.withAlpha(25),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(l?.total ?? 'Total:', style: const TextStyle(fontWeight: FontWeight.w600)),
                  Text(
                    '${_total.toStringAsFixed(0)} EUR',
                    style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold, color: AppColors.gold),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () => setState(() => _step = 2),
              child: Text(l?.next ?? 'Next'),
            ),
          ] else ...[
            _buildMethodOption('balance', l?.balance ?? 'Balance', l?.availableBalance(balance.toStringAsFixed(0)) ?? 'Available: ${balance.toStringAsFixed(0)} EUR', Icons.account_balance_wallet),
            const SizedBox(height: 8),
            _buildMethodOption('stripe', l?.bankCard ?? 'Bank Card', l?.visaMastercard ?? 'Visa, Mastercard', Icons.credit_card),
            const SizedBox(height: 8),
            _buildMethodOption('crypto', l?.crypto ?? 'Crypto', l?.btcEthUsdt ?? 'BTC, ETH, USDT', Icons.currency_bitcoin),
            const SizedBox(height: 24),
            Row(
              children: [
                Expanded(
                  child: OutlinedButton(
                    onPressed: () => setState(() => _step = 1),
                    child: Text(l?.back ?? 'Back'),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: ElevatedButton(
                    onPressed: _loading ? null : _buy,
                    child: _loading
                        ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2))
                        : Text(l?.pay ?? 'Pay'),
                  ),
                ),
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
          border: Border.all(
            color: selected ? AppColors.gold : AppColors.textMuted.withAlpha(60),
            width: selected ? 2 : 1,
          ),
        ),
        child: Row(
          children: [
            Icon(icon, color: selected ? AppColors.gold : AppColors.textMuted),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
                Text(subtitle, style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
              ],
            ),
            const Spacer(),
            if (selected) const Icon(Icons.check_circle, color: AppColors.gold),
          ],
        ),
      ),
    );
  }
}
