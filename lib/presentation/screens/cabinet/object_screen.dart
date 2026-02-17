import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/data_providers.dart';
import '../../widgets/common/error_view.dart';
import '../../widgets/sheets/buy_shares_sheet.dart';

class ObjectScreen extends ConsumerWidget {
  const ObjectScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = S.of(context);
    final objectAsync = ref.watch(objectProvider);
    final roomsAsync = ref.watch(roomsProvider);
    final revenueAsync = ref.watch(revenueBreakdownProvider);

    return Scaffold(
      appBar: AppBar(title: Text(l?.object ?? 'Object')),
      body: RefreshIndicator(
        onRefresh: () async {
          ref.invalidate(objectProvider);
          ref.invalidate(roomsProvider);
        },
        child: objectAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ErrorView(
            message: e.toString(),
            onRetry: () => ref.invalidate(objectProvider),
          ),
          data: (obj) => ListView(
            padding: const EdgeInsets.all(16),
            children: [
              // Header image
              ClipRRect(
                borderRadius: BorderRadius.circular(16),
                child: Image.network(
                  obj.imageUrl,
                  height: 200,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => Container(
                    height: 200,
                    color: AppColors.darkCard,
                    child: const Icon(Icons.apartment, size: 64, color: AppColors.gold),
                  ),
                ),
              ).animate().fadeIn(duration: 400.ms).slideY(begin: 0.03, end: 0, duration: 400.ms),
              const SizedBox(height: 16),

              // Name & location
              Text(obj.name, style: Theme.of(context).textTheme.headlineMedium),
              const SizedBox(height: 4),
              Row(
                children: [
                  const Icon(Icons.location_on, size: 16, color: AppColors.textMuted),
                  const SizedBox(width: 4),
                  Text(obj.location, style: Theme.of(context).textTheme.bodyMedium),
                  const Spacer(),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppColors.success.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: const Text('Active', style: TextStyle(color: AppColors.success, fontSize: 12)),
                  ),
                ],
              ).animate().fadeIn(duration: 350.ms, delay: 100.ms),
              const SizedBox(height: 24),

              // Stats row
              Row(
                children: [
                  _Stat(l?.totalRooms ?? 'Rooms', '${obj.totalRooms}'),
                  _Stat(l?.occupancy ?? 'Occupancy', '${(obj.occupancyRate * 100).toStringAsFixed(0)}%'),
                  _Stat(l?.profitMargin ?? 'Margin', '${(obj.profitMargin * 100).toStringAsFixed(0)}%'),
                  _Stat(l?.sharePrice ?? 'Share', '${obj.sharePrice.toStringAsFixed(0)} EUR'),
                ],
              ).animate().fadeIn(duration: 400.ms, delay: 150.ms).slideY(begin: 0.02, end: 0, duration: 400.ms, delay: 150.ms),
              const SizedBox(height: 24),

              // Revenue breakdown pie chart
              revenueAsync.when(
                data: (rev) {
                  if (rev.isEmpty) return const SizedBox.shrink();
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(l?.revenueStructure ?? 'Revenue Structure', style: Theme.of(context).textTheme.titleLarge),
                      const SizedBox(height: 12),
                      SizedBox(
                        height: 200,
                        child: PieChart(
                          PieChartData(
                            sections: rev.map((r) => PieChartSectionData(
                              value: r.percent,
                              title: '${r.percent.toStringAsFixed(0)}%',
                              color: _getColor(rev.indexOf(r)),
                              radius: 60,
                              titleStyle: const TextStyle(fontSize: 12, color: Colors.white, fontWeight: FontWeight.bold),
                            )).toList(),
                            centerSpaceRadius: 40,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      ...rev.map((r) => Padding(
                        padding: const EdgeInsets.symmetric(vertical: 2),
                        child: Row(
                          children: [
                            Container(width: 12, height: 12, decoration: BoxDecoration(color: _getColor(rev.indexOf(r)), borderRadius: BorderRadius.circular(3))),
                            const SizedBox(width: 8),
                            Text(r.category),
                            const Spacer(),
                            Text('${r.amount.toStringAsFixed(0)} EUR'),
                          ],
                        ),
                      )),
                    ],
                  );
                },
                loading: () => const SizedBox.shrink(),
                error: (e, _) => ErrorView(
                  message: e.toString(),
                  onRetry: () => ref.invalidate(revenueBreakdownProvider),
                ),
              ),
              const SizedBox(height: 24),

              // Rooms list
              Text(l?.rooms ?? 'Rooms', style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 12),
              roomsAsync.when(
                data: (rooms) => Column(
                  children: rooms.map((room) {
                    final soldPercent = room.totalShares > 0
                        ? room.soldShares / room.totalShares
                        : 0.0;
                    return Card(
                      margin: const EdgeInsets.only(bottom: 12),
                      child: Padding(
                        padding: const EdgeInsets.all(16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Text('Room ${room.number}', style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                                const Spacer(),
                                Text(l?.floor(room.floor) ?? 'Floor ${room.floor}', style: const TextStyle(color: AppColors.textMuted, fontSize: 12)),
                              ],
                            ),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                _RoomInfo('Yield', '${(room.occupancyRate * 100).toStringAsFixed(0)}%'),
                                _RoomInfo('Price', '${room.sharePrice.toStringAsFixed(0)} EUR'),
                                _RoomInfo(l?.available ?? 'Available', '${room.availableShares}'),
                              ],
                            ),
                            const SizedBox(height: 8),
                            LinearProgressIndicator(
                              value: soldPercent,
                              backgroundColor: Colors.grey.shade200,
                              valueColor: const AlwaysStoppedAnimation(AppColors.gold),
                            ),
                            const SizedBox(height: 4),
                            Text('${room.soldShares}/${room.totalShares} ${l?.sold ?? 'sold'}', style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                            const SizedBox(height: 12),
                            SizedBox(
                              width: double.infinity,
                              child: room.availableShares > 0
                                  ? ElevatedButton(
                                      onPressed: () => showModalBottomSheet(
                                        context: context,
                                        isScrollControlled: true,
                                        builder: (_) => BuySharesSheet(room: room),
                                      ),
                                      child: Text(l?.buyShares ?? 'Buy Shares'),
                                    )
                                  : OutlinedButton(
                                      onPressed: null,
                                      child: Text(l?.soldOut ?? 'Sold Out'),
                                    ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => ErrorView(
                  message: e.toString(),
                  onRetry: () => ref.invalidate(roomsProvider),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Color _getColor(int index) {
    const colors = [AppColors.gold, AppColors.info, AppColors.success, AppColors.warning, AppColors.error];
    return colors[index % colors.length];
  }
}

class _Stat extends StatelessWidget {
  final String label;
  final String value;
  const _Stat(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        children: [
          Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
          const SizedBox(height: 4),
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
        ],
      ),
    );
  }
}

class _RoomInfo extends StatelessWidget {
  final String label;
  final String value;
  const _RoomInfo(this.label, this.value);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
