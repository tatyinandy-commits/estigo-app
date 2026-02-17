import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/data_providers.dart';
import '../../../domain/providers/api_providers.dart';

class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final ticketsAsync = ref.watch(ticketsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Support'),
        actions: [
          TextButton.icon(
            onPressed: () => _showNewTicket(context, ref),
            icon: const Icon(Icons.add),
            label: const Text('New'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(ticketsProvider),
        child: ticketsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => Center(child: Text('Error: $e')),
          data: (tickets) {
            if (tickets.isEmpty) {
              return const Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  Icon(Icons.support_agent, size: 64, color: AppColors.textMuted),
                  SizedBox(height: 16),
                  Text('No tickets yet'),
                  SizedBox(height: 8),
                  Text('Create a ticket if you need help', style: TextStyle(color: AppColors.textMuted)),
                ]),
              );
            }
            return ListView.builder(
              padding: const EdgeInsets.all(16),
              itemCount: tickets.length,
              itemBuilder: (_, i) {
                final t = tickets[i];
                return Card(
                  margin: const EdgeInsets.only(bottom: 12),
                  child: ListTile(
                    title: Text(t['subject'] ?? 'No subject'),
                    subtitle: Text(t['message'] ?? '', maxLines: 2, overflow: TextOverflow.ellipsis),
                    trailing: Chip(
                      label: Text(t['status'] ?? 'open', style: const TextStyle(fontSize: 10)),
                      backgroundColor: _statusColor(t['status']),
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }

  Color _statusColor(String? status) {
    switch (status) {
      case 'resolved': return AppColors.success.withOpacity(0.2);
      case 'in_progress': return AppColors.warning.withOpacity(0.2);
      case 'closed': return AppColors.textMuted.withOpacity(0.2);
      default: return AppColors.info.withOpacity(0.2);
    }
  }

  void _showNewTicket(BuildContext context, WidgetRef ref) {
    final subjectC = TextEditingController();
    final messageC = TextEditingController();

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (ctx) => Padding(
        padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(ctx).viewInsets.bottom + 24),
        child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Text('New Ticket', style: Theme.of(ctx).textTheme.titleLarge),
          const SizedBox(height: 16),
          TextFormField(controller: subjectC, decoration: const InputDecoration(labelText: 'Subject')),
          const SizedBox(height: 12),
          TextFormField(controller: messageC, maxLines: 4, decoration: const InputDecoration(labelText: 'Message')),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () async {
              if (subjectC.text.isEmpty || messageC.text.isEmpty) return;
              await ref.read(supportApiProvider).createTicket(subject: subjectC.text, message: messageC.text);
              ref.invalidate(ticketsProvider);
              if (ctx.mounted) Navigator.pop(ctx);
            },
            child: const Text('Submit'),
          ),
        ]),
      ),
    );
  }
}
