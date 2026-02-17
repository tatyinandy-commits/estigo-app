// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'revenue.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$RevenueBreakdownImpl _$$RevenueBreakdownImplFromJson(
        Map<String, dynamic> json) =>
    _$RevenueBreakdownImpl(
      category: json['category'] as String,
      categoryRu: json['categoryRu'] as String,
      amount: (json['amount'] as num).toDouble(),
      percent: (json['percent'] as num).toDouble(),
    );

Map<String, dynamic> _$$RevenueBreakdownImplToJson(
        _$RevenueBreakdownImpl instance) =>
    <String, dynamic>{
      'category': instance.category,
      'categoryRu': instance.categoryRu,
      'amount': instance.amount,
      'percent': instance.percent,
    };

_$MonthlyIncomeImpl _$$MonthlyIncomeImplFromJson(Map<String, dynamic> json) =>
    _$MonthlyIncomeImpl(
      month: json['month'] as String,
      monthRu: json['monthRu'] as String,
      revenue: (json['revenue'] as num).toDouble(),
      expenses: (json['expenses'] as num).toDouble(),
      netProfit: (json['netProfit'] as num).toDouble(),
      distributedPerShare: (json['distributedPerShare'] as num).toDouble(),
    );

Map<String, dynamic> _$$MonthlyIncomeImplToJson(_$MonthlyIncomeImpl instance) =>
    <String, dynamic>{
      'month': instance.month,
      'monthRu': instance.monthRu,
      'revenue': instance.revenue,
      'expenses': instance.expenses,
      'netProfit': instance.netProfit,
      'distributedPerShare': instance.distributedPerShare,
    };
