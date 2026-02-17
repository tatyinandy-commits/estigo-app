import 'package:freezed_annotation/freezed_annotation.dart';

part 'payment.freezed.dart';
part 'payment.g.dart';

enum PaymentPurpose {
  @JsonValue('deposit')
  deposit,
  @JsonValue('share_purchase')
  sharePurchase,
}

enum PaymentProvider {
  @JsonValue('stripe')
  stripe,
  @JsonValue('coingate')
  coingate,
  @JsonValue('balance')
  balance,
}

enum PaymentStatus {
  @JsonValue('pending')
  pending,
  @JsonValue('processing')
  processing,
  @JsonValue('completed')
  completed,
  @JsonValue('expired')
  expired,
  @JsonValue('failed')
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
