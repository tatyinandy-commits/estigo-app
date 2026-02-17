import 'package:freezed_annotation/freezed_annotation.dart';

part 'p2p.freezed.dart';
part 'p2p.g.dart';

enum OrderType {
  @JsonValue('sell')
  sell,
  @JsonValue('buy')
  buy,
}

enum OrderStatus {
  @JsonValue('active')
  active,
  @JsonValue('completed')
  completed,
  @JsonValue('cancelled')
  cancelled,
}

@freezed
class P2POrder with _$P2POrder {
  const factory P2POrder({
    required String id,
    required OrderType type,
    required String roomId,
    required String roomNumber,
    required String roomType,
    required int shares,
    required double pricePerShare,
    required double totalPrice,
    String? sellerName,
    String? buyerName,
    required String createdAt,
    @Default(OrderStatus.active) OrderStatus status,
    @Default('') String userId,
  }) = _P2POrder;

  factory P2POrder.fromJson(Map<String, dynamic> json) =>
      _$P2POrderFromJson(json);
}
