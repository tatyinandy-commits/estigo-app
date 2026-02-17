import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/data_providers.dart';
import '../../../domain/providers/api_providers.dart';
import '../../../data/models/models.dart';
import '../../widgets/common/error_view.dart';

class P2PScreen extends ConsumerStatefulWidget {
  const P2PScreen({super.key});

  @override
  ConsumerState<P2PScreen> createState() => _P2PScreenState();
}

class _P2PScreenState extends ConsumerState<P2PScreen> with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  void _showCreateOrder() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (_) => const _CreateOrderSheet(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(l?.p2pMarket ?? 'P2P Market'),
        actions: [
          TextButton.icon(
            onPressed: _showCreateOrder,
            icon: const Icon(Icons.add),
            label: Text(l?.createOrder ?? 'Create'),
          ),
        ],
        bottom: TabBar(
          controller: _tabController,
          tabs: [Tab(text: l?.allOrders ?? 'All Orders'), Tab(text: l?.myOrders ?? 'My Orders')],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _AllOrdersTab(),
          _MyOrdersTab(),
        ],
      ),
    );
  }
}

class _AllOrdersTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = S.of(context);
    final ordersAsync = ref.watch(p2pOrdersProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(p2pOrdersProvider),
      child: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(p2pOrdersProvider),
        ),
        data: (orders) {
          final active = orders.where((o) => o.status == OrderStatus.active).toList();
          if (active.isEmpty) {
            return Center(child: Text(l?.noData ?? 'No active orders', style: const TextStyle(color: AppColors.textMuted)));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: active.length,
            itemBuilder: (_, i) => _OrderCard(order: active[i], showAction: true)
                .animate().fadeIn(duration: 400.ms, delay: (i * 80).ms).slideY(begin: 0.03, end: 0, duration: 400.ms, delay: (i * 80).ms),
          );
        },
      ),
    );
  }
}

class _MyOrdersTab extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = S.of(context);
    final ordersAsync = ref.watch(p2pMyOrdersProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(p2pMyOrdersProvider),
      child: ordersAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => ErrorView(
          message: e.toString(),
          onRetry: () => ref.invalidate(p2pMyOrdersProvider),
        ),
        data: (orders) {
          if (orders.isEmpty) {
            return Center(child: Text(l?.noData ?? 'No orders', style: const TextStyle(color: AppColors.textMuted)));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: orders.length,
            itemBuilder: (_, i) => _OrderCard(order: orders[i], showCancel: true)
                .animate().fadeIn(duration: 400.ms, delay: (i * 80).ms).slideY(begin: 0.03, end: 0, duration: 400.ms, delay: (i * 80).ms),
          );
        },
      ),
    );
  }
}

class _OrderCard extends ConsumerWidget {
  final P2POrder order;
  final bool showAction;
  final bool showCancel;

  const _OrderCard({required this.order, this.showAction = false, this.showCancel = false});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = S.of(context);
    final isBuy = order.type == OrderType.buy;
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: (isBuy ? AppColors.success : AppColors.error).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(isBuy ? (l?.buy ?? 'BUY').toUpperCase() : (l?.sell ?? 'SELL').toUpperCase(), style: TextStyle(color: isBuy ? AppColors.success : AppColors.error, fontWeight: FontWeight.bold, fontSize: 12)),
              ),
              const SizedBox(width: 8),
              Text('Room ${order.roomNumber}', style: const TextStyle(fontWeight: FontWeight.bold)),
              const Spacer(),
              Text(order.createdAt.substring(0, 10), style: const TextStyle(fontSize: 12, color: AppColors.textMuted)),
            ]),
            const SizedBox(height: 12),
            Row(children: [
              _Info('Shares', '${order.shares}'),
              _Info('Price/share', '${order.pricePerShare.toStringAsFixed(0)}'),
              _Info(l?.amount ?? 'Total', '${order.totalPrice.toStringAsFixed(0)} EUR'),
            ]),
            if (showAction && order.status == OrderStatus.active) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () async {
                    try {
                      await ref.read(p2pApiProvider).executeOrder(order.id);
                      ref.invalidate(p2pOrdersProvider);
                      ref.invalidate(portfolioProvider);
                    } catch (e) {
                      if (context.mounted) {
                        final l = S.of(context);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l?.operationFailed ?? 'Operation failed')));
                      }
                    }
                  },
                  child: Text(isBuy ? 'Sell to Buyer' : (l?.buy ?? 'Buy')),
                ),
              ),
            ],
            if (showCancel && order.status == OrderStatus.active) ...[
              const SizedBox(height: 12),
              SizedBox(
                width: double.infinity,
                child: OutlinedButton(
                  onPressed: () async {
                    await ref.read(p2pApiProvider).cancelOrder(order.id);
                    ref.invalidate(p2pMyOrdersProvider);
                  },
                  child: Text(l?.cancel ?? 'Cancel Order'),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _Info extends StatelessWidget {
  final String label, value;
  const _Info(this.label, this.value);
  @override
  Widget build(BuildContext context) => Expanded(
    child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 10, color: AppColors.textMuted)),
        Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
      ],
    ),
  );
}

class _CreateOrderSheet extends ConsumerStatefulWidget {
  const _CreateOrderSheet();
  @override
  ConsumerState<_CreateOrderSheet> createState() => _CreateOrderSheetState();
}

class _CreateOrderSheetState extends ConsumerState<_CreateOrderSheet> {
  String _type = 'buy';
  final _sharesController = TextEditingController(text: '1');
  final _priceController = TextEditingController();
  String? _selectedRoomId;
  bool _loading = false;

  Future<void> _create() async {
    if (_selectedRoomId == null) return;
    final shares = int.tryParse(_sharesController.text) ?? 0;
    final price = double.tryParse(_priceController.text) ?? 0;
    if (shares <= 0 || price <= 0) return;

    setState(() => _loading = true);
    try {
      await ref.read(p2pApiProvider).createOrder(
        type: _type,
        roomId: _selectedRoomId!,
        shares: shares,
        pricePerShare: price,
      );
      ref.invalidate(p2pMyOrdersProvider);
      ref.invalidate(p2pOrdersProvider);
      if (mounted) Navigator.pop(context);
    } catch (e) {
      if (mounted) {
        final l = S.of(context);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(l?.operationFailed ?? 'Operation failed')));
      }
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final l = S.of(context);
    final roomsAsync = ref.watch(roomsProvider);

    return Padding(
      padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(context).viewInsets.bottom + 24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Text(l?.createOrder ?? 'Create Order', style: Theme.of(context).textTheme.titleLarge),
          const SizedBox(height: 16),
          SegmentedButton<String>(
            segments: [
              ButtonSegment(value: 'buy', label: Text(l?.buy ?? 'Buy')),
              ButtonSegment(value: 'sell', label: Text(l?.sell ?? 'Sell')),
            ],
            selected: {_type},
            onSelectionChanged: (s) => setState(() => _type = s.first),
          ),
          const SizedBox(height: 16),
          roomsAsync.when(
            data: (rooms) => DropdownButtonFormField<String>(
              value: _selectedRoomId,
              decoration: const InputDecoration(labelText: 'Room'),
              items: rooms.map((r) => DropdownMenuItem(value: r.id, child: Text('Room ${r.number}'))).toList(),
              onChanged: (v) => setState(() => _selectedRoomId = v),
            ),
            loading: () => const LinearProgressIndicator(),
            error: (e, _) => ErrorView(
              message: e.toString(),
              onRetry: () => ref.invalidate(roomsProvider),
            ),
          ),
          const SizedBox(height: 12),
          TextFormField(controller: _sharesController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Shares')),
          const SizedBox(height: 12),
          TextFormField(controller: _priceController, keyboardType: TextInputType.number, decoration: const InputDecoration(labelText: 'Price per Share (EUR)')),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _loading ? null : _create,
            child: _loading ? const SizedBox(width: 20, height: 20, child: CircularProgressIndicator(strokeWidth: 2)) : Text(l?.createOrder ?? 'Create Order'),
          ),
        ],
      ),
    );
  }
}
