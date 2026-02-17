// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RoomTypeImpl _$$RoomTypeImplFromJson(Map<String, dynamic> json) =>
    _$RoomTypeImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      nameRu: json['nameRu'] as String,
      pricePerNight: (json['pricePerNight'] as num).toDouble(),
      description: json['description'] as String? ?? '',
    );

Map<String, dynamic> _$$RoomTypeImplToJson(_$RoomTypeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameRu': instance.nameRu,
      'pricePerNight': instance.pricePerNight,
      'description': instance.description,
    };

_$RoomImpl _$$RoomImplFromJson(Map<String, dynamic> json) => _$RoomImpl(
      id: json['id'] as String,
      number: json['number'] as String,
      typeId: json['typeId'] as String,
      floor: (json['floor'] as num).toInt(),
      totalShares: (json['totalShares'] as num).toInt(),
      availableShares: (json['availableShares'] as num).toInt(),
      soldShares: (json['soldShares'] as num).toInt(),
      sharePrice: (json['sharePrice'] as num).toDouble(),
      occupancyRate: (json['occupancyRate'] as num).toDouble(),
      monthlyRevenue: (json['monthlyRevenue'] as num).toDouble(),
      status: $enumDecodeNullable(_$RoomStatusEnumMap, json['status']) ??
          RoomStatus.active,
      objectId: json['objectId'] as String,
    );

Map<String, dynamic> _$$RoomImplToJson(_$RoomImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'number': instance.number,
      'typeId': instance.typeId,
      'floor': instance.floor,
      'totalShares': instance.totalShares,
      'availableShares': instance.availableShares,
      'soldShares': instance.soldShares,
      'sharePrice': instance.sharePrice,
      'occupancyRate': instance.occupancyRate,
      'monthlyRevenue': instance.monthlyRevenue,
      'status': _$RoomStatusEnumMap[instance.status]!,
      'objectId': instance.objectId,
    };

const _$RoomStatusEnumMap = {
  RoomStatus.active: 'active',
  RoomStatus.renovation: 'renovation',
  RoomStatus.upcoming: 'upcoming',
};
