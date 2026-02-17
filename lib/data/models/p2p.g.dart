// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'p2p.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$P2POrderImpl _$$P2POrderImplFromJson(Map<String, dynamic> json) =>
    _$P2POrderImpl(
      id: json['id'] as String,
      type: $enumDecode(_$OrderTypeEnumMap, json['type']),
      roomId: json['roomId'] as String,
      roomNumber: json['roomNumber'] as String,
      roomType: json['roomType'] as String,
      shares: (json['shares'] as num).toInt(),
      pricePerShare: (json['pricePerShare'] as num).toDouble(),
      totalPrice: (json['totalPrice'] as num).toDouble(),
      sellerName: json['sellerName'] as String?,
      buyerName: json['buyerName'] as String?,
      createdAt: json['createdAt'] as String,
      status: $enumDecodeNullable(_$OrderStatusEnumMap, json['status']) ??
          OrderStatus.active,
      userId: json['userId'] as String? ?? '',
    );

Map<String, dynamic> _$$P2POrderImplToJson(_$P2POrderImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'type': _$OrderTypeEnumMap[instance.type]!,
      'roomId': instance.roomId,
      'roomNumber': instance.roomNumber,
      'roomType': instance.roomType,
      'shares': instance.shares,
      'pricePerShare': instance.pricePerShare,
      'totalPrice': instance.totalPrice,
      'sellerName': instance.sellerName,
      'buyerName': instance.buyerName,
      'createdAt': instance.createdAt,
      'status': _$OrderStatusEnumMap[instance.status]!,
      'userId': instance.userId,
    };

const _$OrderTypeEnumMap = {
  OrderType.sell: 'sell',
  OrderType.buy: 'buy',
};

const _$OrderStatusEnumMap = {
  OrderStatus.active: 'active',
  OrderStatus.completed: 'completed',
  OrderStatus.cancelled: 'cancelled',
};
