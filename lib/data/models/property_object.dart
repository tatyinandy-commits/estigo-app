import 'package:freezed_annotation/freezed_annotation.dart';

part 'property_object.freezed.dart';
part 'property_object.g.dart';

enum ObjectStatus {
  @JsonValue('ACTIVE')
  active,
  @JsonValue('UPCOMING')
  upcoming,
}

@freezed
class PropertyObject with _$PropertyObject {
  const factory PropertyObject({
    required String id,
    required String name,
    required String nameRu,
    required String location,
    required String locationRu,
    required String country,
    required int totalRooms,
    required int totalShares,
    required double sharePrice,
    @Default('EUR') String currency,
    required double occupancyRate,
    required double annualRevenue,
    required double operatingExpenses,
    required double netProfit,
    required double profitMargin,
    required String description,
    required String descriptionRu,
    required String imageUrl,
    @Default(ObjectStatus.active) ObjectStatus status,
    @Default(0) int yearBuilt,
    @Default(0) int lastRenovation,
    @Default([]) List<String> amenities,
  }) = _PropertyObject;

  factory PropertyObject.fromJson(Map<String, dynamic> json) =>
      _$PropertyObjectFromJson(json);
}
