import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/data_providers.dart';
import '../../../domain/providers/api_providers.dart';
import '../../widgets/common/error_view.dart';

class NotificationsScreen extends ConsumerWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = S.of(context);
    final notifAsync = ref.watch(notificationsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l?.notifications ?? 'Notifications'),
        actions: [
          TextButton(
            onPressed: () async {
              await ref.read(userApiProvider).markAllNotificationsRead();
              ref.invalidate(notificationsProvider);
            },
            child: Text(l?.markAllRead ?? 'Mark all read'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(notificationsProvider),
        child: notifAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ErrorView(message: e.toString(), onRetry: () => ref.invalidate(notificationsProvider)),
          data: (notifications) {
            if (notifications.isEmpty) {
              return Center(child: Text(l?.noNotifications ?? 'No notifications', style: const TextStyle(color: AppColors.textMuted)));
            }
            return ListView.builder(
              itemCount: notifications.length,
              itemBuilder: (_, i) {
                final n = notifications[i];
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: n.read ? Colors.grey.shade200 : AppColors.gold.withOpacity(0.2),
                    child: Icon(
                      _iconForType(n.type),
                      color: n.read ? AppColors.textMuted : AppColors.gold,
                      size: 20,
                    ),
                  ),
                  title: Text(n.title, style: TextStyle(fontWeight: n.read ? FontWeight.normal : FontWeight.bold)),
                  subtitle: Text(n.message, maxLines: 2, overflow: TextOverflow.ellipsis),
                  trailing: Text(n.createdAt.substring(0, 10), style: const TextStyle(fontSize: 11, color: AppColors.textMuted)),
                  onTap: () async {
                    if (!n.read) {
                      await ref.read(userApiProvider).markNotificationRead(n.id);
                      ref.invalidate(notificationsProvider);
                    }
                  },
                );
              },
            );
          },
        ),
      ),
    );
  }

  IconData _iconForType(String type) {
    switch (type) {
      case 'income': return Icons.monetization_on;
      case 'payment': return Icons.payment;
      case 'p2p': return Icons.swap_horiz;
      case 'security': return Icons.security;
      case 'kyc': return Icons.verified_user;
      default: return Icons.notifications;
    }
  }
}
