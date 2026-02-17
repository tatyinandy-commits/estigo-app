// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'portfolio.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$UserShareImpl _$$UserShareImplFromJson(Map<String, dynamic> json) =>
    _$UserShareImpl(
      roomId: json['roomId'] as String,
      roomNumber: json['roomNumber'] as String,
      roomType: json['roomType'] as String,
      shares: (json['shares'] as num).toInt(),
      purchasePrice: (json['purchasePrice'] as num).toDouble(),
      currentValue: (json['currentValue'] as num).toDouble(),
      totalIncome: (json['totalIncome'] as num).toDouble(),
      purchaseDate: json['purchaseDate'] as String,
    );

Map<String, dynamic> _$$UserShareImplToJson(_$UserShareImpl instance) =>
    <String, dynamic>{
      'roomId': instance.roomId,
      'roomNumber': instance.roomNumber,
      'roomType': instance.roomType,
      'shares': instance.shares,
      'purchasePrice': instance.purchasePrice,
      'currentValue': instance.currentValue,
      'totalIncome': instance.totalIncome,
      'purchaseDate': instance.purchaseDate,
    };
