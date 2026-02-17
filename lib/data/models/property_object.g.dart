// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'property_object.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$PropertyObjectImpl _$$PropertyObjectImplFromJson(Map<String, dynamic> json) =>
    _$PropertyObjectImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      nameRu: json['nameRu'] as String,
      location: json['location'] as String,
      locationRu: json['locationRu'] as String,
      country: json['country'] as String,
      totalRooms: (json['totalRooms'] as num).toInt(),
      totalShares: (json['totalShares'] as num).toInt(),
      sharePrice: (json['sharePrice'] as num).toDouble(),
      currency: json['currency'] as String? ?? 'EUR',
      occupancyRate: (json['occupancyRate'] as num).toDouble(),
      annualRevenue: (json['annualRevenue'] as num).toDouble(),
      operatingExpenses: (json['operatingExpenses'] as num).toDouble(),
      netProfit: (json['netProfit'] as num).toDouble(),
      profitMargin: (json['profitMargin'] as num).toDouble(),
      description: json['description'] as String,
      descriptionRu: json['descriptionRu'] as String,
      imageUrl: json['imageUrl'] as String,
      status: $enumDecodeNullable(_$ObjectStatusEnumMap, json['status']) ??
          ObjectStatus.active,
      yearBuilt: (json['yearBuilt'] as num?)?.toInt() ?? 0,
      lastRenovation: (json['lastRenovation'] as num?)?.toInt() ?? 0,
      amenities: (json['amenities'] as List<dynamic>?)
              ?.map((e) => e as String)
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PropertyObjectImplToJson(
        _$PropertyObjectImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameRu': instance.nameRu,
      'location': instance.location,
      'locationRu': instance.locationRu,
      'country': instance.country,
      'totalRooms': instance.totalRooms,
      'totalShares': instance.totalShares,
      'sharePrice': instance.sharePrice,
      'currency': instance.currency,
      'occupancyRate': instance.occupancyRate,
      'annualRevenue': instance.annualRevenue,
      'operatingExpenses': instance.operatingExpenses,
      'netProfit': instance.netProfit,
      'profitMargin': instance.profitMargin,
      'description': instance.description,
      'descriptionRu': instance.descriptionRu,
      'imageUrl': instance.imageUrl,
      'status': _$ObjectStatusEnumMap[instance.status]!,
      'yearBuilt': instance.yearBuilt,
      'lastRenovation': instance.lastRenovation,
      'amenities': instance.amenities,
    };

const _$ObjectStatusEnumMap = {
  ObjectStatus.active: 'ACTIVE',
  ObjectStatus.upcoming: 'UPCOMING',
};
