import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

enum PaymentPurpose {
  @JsonValue('DEPOSIT')
  deposit,
  @JsonValue('SHARE_PURCHASE')
  sharePurchase,
}

enum PaymentProvider {
  @JsonValue('STRIPE')
  stripe,
  @JsonValue('NOWPAYMENTS')
  nowpayments,
  @JsonValue('BALANCE')
  balance,
}

enum PaymentStatus {
  @JsonValue('PENDING')
  pending,
  @JsonValue('PROCESSING')
  processing,
  @JsonValue('COMPLETED')
  completed,
  @JsonValue('EXPIRED')
  expired,
  @JsonValue('FAILED')
  failed,
}

@freezed
class Payment with _$Payment {
  const factory Payment({
    required String id,
    required PaymentPurpose purpose,
    required PaymentProvider provider,
    required double amount,
    @Default('EUR') String currency,
    @Default(PaymentStatus.pending) PaymentStatus status,
    String? roomId,
    int? shares,
    required String createdAt,
  }) = _Payment;

  factory Payment.fromJson(Map<String, dynamic> json) =>
      _$PaymentFromJson(json);
}

@freezed
class CheckoutSession with _$CheckoutSession {
  const factory CheckoutSession({
    required String sessionId,
    required String url,
  }) = _CheckoutSession;

  factory CheckoutSession.fromJson(Map<String, dynamic> json) =>
      _$CheckoutSessionFromJson(json);
}
