import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/theme/app_theme.dart';
import '../../../domain/providers/data_providers.dart';
import '../../../domain/providers/api_providers.dart';
import '../../widgets/common/error_view.dart';

class SupportScreen extends ConsumerWidget {
  const SupportScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l = S.of(context);
    final ticketsAsync = ref.watch(ticketsProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text(l?.support ?? 'Support'),
        actions: [
          TextButton.icon(
            onPressed: () => _showNewTicket(context, ref),
            icon: const Icon(Icons.add),
            label: Text(l?.newBtn ?? 'New'),
          ),
        ],
      ),
      body: RefreshIndicator(
        onRefresh: () async => ref.invalidate(ticketsProvider),
        child: ticketsAsync.when(
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, _) => ErrorView(message: e.toString(), onRetry: () => ref.invalidate(ticketsProvider)),
          data: (tickets) {
            if (tickets.isEmpty) {
              return Center(
                child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
                  const Icon(Icons.support_agent, size: 64, color: AppColors.textMuted),
                  const SizedBox(height: 16),
                  Text(l?.noTickets ?? 'No tickets yet'),
                  const SizedBox(height: 8),
                  Text(l?.createTicketHelp ?? 'Create a ticket if you need help', style: const TextStyle(color: AppColors.textMuted)),
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
      builder: (ctx) {
        final sl = S.of(ctx);
        return Padding(
          padding: EdgeInsets.only(left: 24, right: 24, top: 24, bottom: MediaQuery.of(ctx).viewInsets.bottom + 24),
          child: Column(mainAxisSize: MainAxisSize.min, crossAxisAlignment: CrossAxisAlignment.stretch, children: [
            Text(sl?.newTicket ?? 'New Ticket', style: Theme.of(ctx).textTheme.titleLarge),
            const SizedBox(height: 16),
            TextFormField(controller: subjectC, decoration: InputDecoration(labelText: sl?.subject ?? 'Subject')),
            const SizedBox(height: 12),
            TextFormField(controller: messageC, maxLines: 4, decoration: InputDecoration(labelText: sl?.message ?? 'Message')),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed: () async {
                if (subjectC.text.isEmpty || messageC.text.isEmpty) return;
                await ref.read(supportApiProvider).createTicket(subject: subjectC.text, message: messageC.text);
                ref.invalidate(ticketsProvider);
                if (ctx.mounted) Navigator.pop(ctx);
              },
              child: Text(sl?.submit ?? 'Submit'),
            ),
          ]),
        );
      },
    );
  }
}
