import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../core/theme/app_theme.dart';
import '../../data/models/user.dart';
import '../../domain/providers/auth_provider.dart';
import '../../domain/providers/data_providers.dart';
import '../widgets/common/connectivity_banner.dart';

class CabinetShell extends ConsumerWidget {
  final Widget child;

  const CabinetShell({super.key, required this.child});

  static const _tabs = [
    '/cabinet',
    '/cabinet/object',
    '/cabinet/portfolio',
    '/cabinet/p2p',
  ];

  int _currentIndex(BuildContext context) {
    final location = GoRouterState.of(context).matchedLocation;
    final idx = _tabs.indexOf(location);
    return idx >= 0 ? idx : 0;
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authState = ref.watch(authProvider);
    final user = authState.user;

    return Scaffold(
      body: ConnectivityBanner(child: child),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex(context),
        onTap: (index) => context.go(_tabs[index]),
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard_outlined),
            activeIcon: Icon(Icons.dashboard),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.apartment_outlined),
            activeIcon: Icon(Icons.apartment),
            label: 'Object',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.pie_chart_outline),
            activeIcon: Icon(Icons.pie_chart),
            label: 'Portfolio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.swap_horiz_outlined),
            activeIcon: Icon(Icons.swap_horiz),
            label: 'P2P',
          ),
        ],
      ),
      drawer: _buildDrawer(context, ref, user),
    );
  }

  Widget _buildDrawer(BuildContext context, WidgetRef ref, dynamic user) {
    final notifications = ref.watch(notificationsProvider);
    final unreadCount = notifications.whenOrNull(
          data: (list) => list.where((n) => !n.read).length,
        ) ??
        0;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: const BoxDecoration(color: AppColors.gold),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                CircleAvatar(
                  radius: 28,
                  backgroundColor: Colors.white24,
                  child: Text(
                    (user?.name ?? 'U')[0].toUpperCase(),
                    style: const TextStyle(
                      fontSize: 24,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  user?.name ?? 'Investor',
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                  ),
                ),
                Text(
                  user?.email ?? '',
                  style: const TextStyle(color: Colors.white70, fontSize: 13),
                ),
              ],
            ),
          ),
          _drawerItem(context, Icons.trending_up, 'Income', '/cabinet/income'),
          _drawerItem(context, Icons.history, 'History', '/cabinet/history'),
          _drawerItem(context, Icons.people, 'Referral', '/cabinet/referral'),
          _drawerItem(
              context, Icons.settings, 'Settings', '/cabinet/settings'),
          _drawerItem(
              context, Icons.support_agent, 'Support', '/cabinet/support'),
          ListTile(
            leading: Badge(
              isLabelVisible: unreadCount > 0,
              label: Text('$unreadCount'),
              child: const Icon(Icons.notifications_outlined),
            ),
            title: const Text('Notifications'),
            onTap: () {
              Navigator.pop(context);
              context.go('/cabinet/notifications');
            },
          ),
          const Divider(),
          if (user?.roles?.contains(UserRole.partner) == true ||
              user?.role == UserRole.partner) ...[
            _drawerItem(
                context, Icons.star, 'Partner Zone', '/partner'),
            const Divider(),
          ],
          ListTile(
            leading: const Icon(Icons.logout, color: AppColors.error),
            title: const Text('Logout',
                style: TextStyle(color: AppColors.error)),
            onTap: () {
              Navigator.pop(context);
              ref.read(authProvider.notifier).logout();
              context.go('/login');
            },
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
      BuildContext context, IconData icon, String title, String path) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: () {
        Navigator.pop(context);
        context.go(path);
      },
    );
  }
}
