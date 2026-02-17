// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'payment.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PaymentImpl _$$PaymentImplFromJson(Map<String, dynamic> json) =>
    _$PaymentImpl(
      id: json['id'] as String,
      purpose: $enumDecode(_$PaymentPurposeEnumMap, json['purpose']),
      provider: $enumDecode(_$PaymentProviderEnumMap, json['provider']),
      amount: (json['amount'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'EUR',
      status: $enumDecodeNullable(_$PaymentStatusEnumMap, json['status']) ??
          PaymentStatus.pending,
      roomId: json['roomId'] as String?,
      shares: (json['shares'] as num?)?.toInt(),
      createdAt: json['createdAt'] as String,
    );

Map<String, dynamic> _$$PaymentImplToJson(_$PaymentImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'purpose': _$PaymentPurposeEnumMap[instance.purpose]!,
      'provider': _$PaymentProviderEnumMap[instance.provider]!,
      'amount': instance.amount,
      'currency': instance.currency,
      'status': _$PaymentStatusEnumMap[instance.status]!,
      'roomId': instance.roomId,
      'shares': instance.shares,
      'createdAt': instance.createdAt,
    };

const _$PaymentPurposeEnumMap = {
  PaymentPurpose.deposit: 'deposit',
  PaymentPurpose.sharePurchase: 'share_purchase',
};

const _$PaymentProviderEnumMap = {
  PaymentProvider.stripe: 'stripe',
  PaymentProvider.coingate: 'coingate',
  PaymentProvider.balance: 'balance',
};

const _$PaymentStatusEnumMap = {
  PaymentStatus.pending: 'pending',
  PaymentStatus.processing: 'processing',
  PaymentStatus.completed: 'completed',
  PaymentStatus.expired: 'expired',
  PaymentStatus.failed: 'failed',
};

_$CheckoutSessionImpl _$$CheckoutSessionImplFromJson(
        Map<String, dynamic> json) =>
    _$CheckoutSessionImpl(
      sessionId: json['sessionId'] as String,
      url: json['url'] as String,
    );

Map<String, dynamic> _$$CheckoutSessionImplToJson(
        _$CheckoutSessionImpl instance) =>
    <String, dynamic>{
      'sessionId': instance.sessionId,
      'url': instance.url,
    };
