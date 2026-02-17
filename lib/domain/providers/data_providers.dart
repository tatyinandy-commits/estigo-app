import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/models.dart';
import 'api_providers.dart';

// Object
final objectProvider = FutureProvider<PropertyObject>((ref) async {
  final api = ref.watch(objectApiProvider);
  return api.getObject();
});

final roomsProvider = FutureProvider<List<Room>>((ref) async {
  final api = ref.watch(objectApiProvider);
  return api.getRooms();
});

final roomTypesProvider = FutureProvider<List<RoomType>>((ref) async {
  final api = ref.watch(objectApiProvider);
  return api.getRoomTypes();
});

final revenueBreakdownProvider =
    FutureProvider<List<RevenueBreakdown>>((ref) async {
  final api = ref.watch(objectApiProvider);
  return api.getRevenueBreakdown();
});

final monthlyIncomeProvider =
    FutureProvider<List<MonthlyIncome>>((ref) async {
  final api = ref.watch(objectApiProvider);
  return api.getMonthlyIncome();
});

// Portfolio
final portfolioProvider = FutureProvider<List<UserShare>>((ref) async {
  final api = ref.watch(portfolioApiProvider);
  return api.getPortfolio();
});

// P2P
final p2pOrdersProvider = FutureProvider<List<P2POrder>>((ref) async {
  final api = ref.watch(p2pApiProvider);
  return api.getOrders();
});

final p2pMyOrdersProvider = FutureProvider<List<P2POrder>>((ref) async {
  final api = ref.watch(p2pApiProvider);
  return api.getMyOrders();
});

final p2pRecentTradesProvider = FutureProvider<List<P2POrder>>((ref) async {
  final api = ref.watch(p2pApiProvider);
  return api.getRecentTrades();
});

// Transactions
final transactionsProvider =
    FutureProvider.family<List<Transaction>, Map<String, dynamic>>(
        (ref, params) async {
  final api = ref.watch(transactionApiProvider);
  return api.getTransactions(
    page: params['page'] ?? 1,
    limit: params['limit'] ?? 20,
    type: params['type'],
  );
});

final recentTransactionsProvider =
    FutureProvider<List<Transaction>>((ref) async {
  final api = ref.watch(transactionApiProvider);
  return api.getTransactions(limit: 5);
});

final incomeAccrualsProvider =
    FutureProvider<List<MonthlyIncome>>((ref) async {
  final api = ref.watch(transactionApiProvider);
  return api.getIncomeAccruals();
});

// Notifications
final notificationsProvider =
    FutureProvider<List<AppNotification>>((ref) async {
  final api = ref.watch(userApiProvider);
  return api.getNotifications();
});

// Partner
final partnerDataProvider = FutureProvider<PartnerData>((ref) async {
  final api = ref.watch(userApiProvider);
  return api.getPartnerData();
});

// Sessions
final sessionsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final api = ref.watch(userApiProvider);
  return api.getSessions();
});

// Support
final ticketsProvider =
    FutureProvider<List<Map<String, dynamic>>>((ref) async {
  final api = ref.watch(supportApiProvider);
  return api.getTickets();
});
