import 'package:freezed_annotation/freezed_annotation.dart';

part 'revenue.freezed.dart';
part 'revenue.g.dart';

@freezed
class RevenueBreakdown with _$RevenueBreakdown {
  const factory RevenueBreakdown({
    required String category,
    required String categoryRu,
    required double amount,
    required double percent,
  }) = _RevenueBreakdown;

  factory RevenueBreakdown.fromJson(Map<String, dynamic> json) =>
      _$RevenueBreakdownFromJson(json);
}

@freezed
class MonthlyIncome with _$MonthlyIncome {
  const factory MonthlyIncome({
    required String month,
    required String monthRu,
    required double revenue,
    required double expenses,
    required double netProfit,
    required double distributedPerShare,
  }) = _MonthlyIncome;

  factory MonthlyIncome.fromJson(Map<String, dynamic> json) =>
      _$MonthlyIncomeFromJson(json);
}
