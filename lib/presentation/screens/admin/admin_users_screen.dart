import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../data/models/models.dart';
import '../../../domain/providers/api_providers.dart';
import '../../widgets/common/error_view.dart';

final _adminUsersProvider = FutureProvider.family<AdminUsersResponse, _UsersQuery>(
  (ref, query) async {
    final api = ref.watch(adminApiProvider);
    return api.getUsers(
      page: query.page,
      limit: 20,
      search: query.search,
    );
  },
);

class _UsersQuery {
  final int page;
  final String? search;

  const _UsersQuery({this.page = 1, this.search});

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is _UsersQuery && other.page == page && other.search == search;

  @override
  int get hashCode => page.hashCode ^ search.hashCode;
}

class AdminUsersScreen extends ConsumerStatefulWidget {
  const AdminUsersScreen({super.key});

  @override
  ConsumerState<AdminUsersScreen> createState() => _AdminUsersScreenState();
}

class _AdminUsersScreenState extends ConsumerState<AdminUsersScreen> {
  final _searchController = TextEditingController();
  int _page = 1;
  String? _search;

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  _UsersQuery get _query => _UsersQuery(page: _page, search: _search);

  void _doSearch() {
    setState(() {
      _search = _searchController.text.trim().isEmpty
          ? null
          : _searchController.text.trim();
      _page = 1;
    });
    ref.invalidate(_adminUsersProvider);
  }

  @override
  Widget build(BuildContext context) {
    final usersAsync = ref.watch(_adminUsersProvider(_query));

    return Scaffold(
      appBar: AppBar(
        title: const Text('User Management'),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(16),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Search by name or email...',
                prefixIcon: const Icon(Icons.search),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.clear),
                  onPressed: () {
                    _searchController.clear();
                    _doSearch();
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              onSubmitted: (_) => _doSearch(),
            ),
          ),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () async =>
                  ref.invalidate(_adminUsersProvider),
              child: usersAsync.when(
                loading: () =>
                    const Center(child: CircularProgressIndicator()),
                error: (e, _) => ErrorView(
                  message: e.toString(),
                  onRetry: () =>
                      ref.invalidate(_adminUsersProvider),
                ),
                data: (response) {
                  if (response.users.isEmpty) {
                    return const Center(
                      child: Text('No users found'),
                    );
                  }
                  return Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          padding: const EdgeInsets.symmetric(horizontal: 16),
                          itemCount: response.users.length,
                          itemBuilder: (_, i) =>
                              _UserCard(
                                user: response.users[i],
                                onEdit: () => _showEditDialog(response.users[i]),
                                onDelete: () => _confirmDelete(response.users[i]),
                              ),
                        ),
                      ),
                      if (response.totalPages > 1)
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                onPressed: _page > 1
                                    ? () => setState(() => _page--)
                                    : null,
                                icon: const Icon(Icons.chevron_left),
                              ),
                              Text('$_page / ${response.totalPages}'),
                              IconButton(
                                onPressed: _page < response.totalPages
                                    ? () => setState(() => _page++)
                                    : null,
                                icon: const Icon(Icons.chevron_right),
                              ),
                            ],
                          ),
                        ),
                    ],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Future<void> _showEditDialog(AdminUser user) async {
    final nameController = TextEditingController(text: user.name);
    final emailController = TextEditingController(text: user.email);
    final balanceController =
        TextEditingController(text: user.balance.toStringAsFixed(2));
    String selectedRole = user.role;
    String selectedKyc = user.kycStatus;
    bool locked = user.lockedUntil != null;

    final result = await showDialog<Map<String, dynamic>>(
      context: context,
      builder: (ctx) => StatefulBuilder(
        builder: (ctx, setDialogState) => AlertDialog(
          title: Text('Edit: ${user.name}'),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                TextField(
                  controller: nameController,
                  decoration: const InputDecoration(labelText: 'Name'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: emailController,
                  decoration: const InputDecoration(labelText: 'Email'),
                ),
                const SizedBox(height: 8),
                TextField(
                  controller: balanceController,
                  decoration: const InputDecoration(labelText: 'Balance'),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedRole,
                  decoration: const InputDecoration(labelText: 'Role'),
                  items: const [
                    DropdownMenuItem(value: 'INVESTOR', child: Text('Investor')),
                    DropdownMenuItem(value: 'ADMIN', child: Text('Admin')),
                  ],
                  onChanged: (v) => setDialogState(() => selectedRole = v!),
                ),
                const SizedBox(height: 12),
                DropdownButtonFormField<String>(
                  value: selectedKyc,
                  decoration: const InputDecoration(labelText: 'KYC Status'),
                  items: const [
                    DropdownMenuItem(value: 'NONE', child: Text('None')),
                    DropdownMenuItem(value: 'PENDING', child: Text('Pending')),
                    DropdownMenuItem(value: 'VERIFIED', child: Text('Verified')),
                    DropdownMenuItem(value: 'REJECTED', child: Text('Rejected')),
                  ],
                  onChanged: (v) => setDialogState(() => selectedKyc = v!),
                ),
                const SizedBox(height: 12),
                SwitchListTile(
                  title: const Text('Locked'),
                  value: locked,
                  onChanged: (v) => setDialogState(() => locked = v),
                  contentPadding: EdgeInsets.zero,
                ),
              ],
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(ctx),
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                final changes = <String, dynamic>{};
                if (nameController.text != user.name) {
                  changes['name'] = nameController.text;
                }
                if (emailController.text != user.email) {
                  changes['email'] = emailController.text;
                }
                final newBalance = double.tryParse(balanceController.text);
                if (newBalance != null && newBalance != user.balance) {
                  changes['balance'] = newBalance;
                }
                if (selectedRole != user.role) {
                  changes['role'] = selectedRole;
                }
                if (selectedKyc != user.kycStatus) {
                  changes['kycStatus'] = selectedKyc;
                }
                final wasLocked = user.lockedUntil != null;
                if (locked != wasLocked) {
                  changes['locked'] = locked;
                }
                Navigator.pop(ctx, changes);
              },
              child: const Text('Save'),
            ),
          ],
        ),
      ),
    );

    if (result != null && result.isNotEmpty && mounted) {
      try {
        await ref.read(adminApiProvider).updateUser(user.id, result);
        ref.invalidate(_adminUsersProvider);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User updated'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }

    nameController.dispose();
    emailController.dispose();
    balanceController.dispose();
  }

  Future<void> _confirmDelete(AdminUser user) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Delete User'),
        content: Text(
          'Are you sure you want to delete "${user.name}" (${user.email})?\n\n'
          'This action is irreversible. All user data including shares, transactions, '
          'and payment records will be permanently deleted.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            onPressed: () => Navigator.pop(ctx, true),
            child: const Text('Delete'),
          ),
        ],
      ),
    );

    if (confirmed == true && mounted) {
      try {
        await ref.read(adminApiProvider).deleteUser(user.id);
        ref.invalidate(_adminUsersProvider);
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('User deleted'),
              backgroundColor: AppColors.success,
            ),
          );
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: AppColors.error,
            ),
          );
        }
      }
    }
  }
}

class _UserCard extends StatelessWidget {
  final AdminUser user;
  final VoidCallback onEdit;
  final VoidCallback onDelete;

  const _UserCard({
    required this.user,
    required this.onEdit,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    final isLocked = user.lockedUntil != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor:
              user.role == 'ADMIN' ? AppColors.gold : AppColors.info,
          child: Text(
            user.name.isNotEmpty ? user.name[0].toUpperCase() : '?',
            style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
          ),
        ),
        title: Row(
          children: [
            Expanded(child: Text(user.name, overflow: TextOverflow.ellipsis)),
            if (isLocked)
              const Icon(Icons.lock, size: 16, color: AppColors.error),
          ],
        ),
        subtitle: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(user.email, style: const TextStyle(fontSize: 12)),
            const SizedBox(height: 4),
            Row(
              children: [
                _chip(user.role, user.role == 'ADMIN' ? AppColors.gold : AppColors.info),
                const SizedBox(width: 4),
                _chip(
                  'KYC: ${user.kycStatus}',
                  user.kycStatus == 'VERIFIED'
                      ? AppColors.success
                      : AppColors.textMuted,
                ),
                const SizedBox(width: 4),
                Text(
                  '${user.balance.toStringAsFixed(0)} EUR',
                  style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600),
                ),
              ],
            ),
          ],
        ),
        isThreeLine: true,
        trailing: PopupMenuButton<String>(
          onSelected: (value) {
            if (value == 'edit') onEdit();
            if (value == 'delete') onDelete();
          },
          itemBuilder: (_) => [
            const PopupMenuItem(value: 'edit', child: Text('Edit')),
            const PopupMenuItem(
              value: 'delete',
              child: Text('Delete', style: TextStyle(color: AppColors.error)),
            ),
          ],
        ),
      ),
    );
  }

  Widget _chip(String label, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      decoration: BoxDecoration(
        color: color.withAlpha(30),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Text(
        label,
        style: TextStyle(fontSize: 10, fontWeight: FontWeight.w600, color: color),
      ),
    );
  }
}
