import 'package:freezed_annotation/freezed_annotation.dart';

part 'transaction.freezed.dart';
part 'transaction.g.dart';

enum TransactionType {
  @JsonValue('deposit')
  deposit,
  @JsonValue('withdrawal')
  withdrawal,
  @JsonValue('share_purchase')
  sharePurchase,
  @JsonValue('share_sale')
  shareSale,
  @JsonValue('income_accrual')
  incomeAccrual,
  @JsonValue('p2p_buy')
  p2pBuy,
  @JsonValue('p2p_sell')
  p2pSell,
}

enum TransactionStatus {
  @JsonValue('completed')
  completed,
  @JsonValue('pending')
  pending,
  @JsonValue('failed')
  failed,
}

@freezed
class Transaction with _$Transaction {
  const factory Transaction({
    required String id,
    required TransactionType type,
    required double amount,
    required String description,
    required String date,
    @Default(TransactionStatus.completed) TransactionStatus status,
    String? roomNumber,
    int? shares,
  }) = _Transaction;

  factory Transaction.fromJson(Map<String, dynamic> json) =>
      _$TransactionFromJson(json);
}
