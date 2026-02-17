import 'package:freezed_annotation/freezed_annotation.dart';

part 'portfolio.freezed.dart';
part 'portfolio.g.dart';

@freezed
class UserShare with _$UserShare {
  const factory UserShare({
    required String roomId,
    required String roomNumber,
    required String roomType,
    required int shares,
    required double purchasePrice,
    required double currentValue,
    required double totalIncome,
    required String purchaseDate,
  }) = _UserShare;

  factory UserShare.fromJson(Map<String, dynamic> json) =>
      _$UserShareFromJson(json);
}
