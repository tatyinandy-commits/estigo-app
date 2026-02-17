import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../core/network/api_client.dart';
import '../../data/datasources/auth_api.dart';
import '../../data/datasources/object_api.dart';
import '../../data/datasources/portfolio_api.dart';
import '../../data/datasources/p2p_api.dart';
import '../../data/datasources/transaction_api.dart';
import '../../data/datasources/payment_api.dart';
import '../../data/datasources/user_api.dart';
import '../../data/datasources/support_api.dart';
import '../../data/datasources/kyc_api.dart';

final authApiProvider = Provider<AuthApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return AuthApi(client.dio);
});

final objectApiProvider = Provider<ObjectApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return ObjectApi(client.dio);
});

final portfolioApiProvider = Provider<PortfolioApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return PortfolioApi(client.dio);
});

final p2pApiProvider = Provider<P2PApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return P2PApi(client.dio);
});

final transactionApiProvider = Provider<TransactionApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return TransactionApi(client.dio);
});

final paymentApiProvider = Provider<PaymentApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return PaymentApi(client.dio);
});

final userApiProvider = Provider<UserApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return UserApi(client.dio);
});

final supportApiProvider = Provider<SupportApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return SupportApi(client.dio);
});

final kycApiProvider = Provider<KycApi>((ref) {
  final client = ref.watch(apiClientProvider);
  return KycApi(client.dio);
});
