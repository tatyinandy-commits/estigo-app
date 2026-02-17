import 'package:freezed_annotation/freezed_annotation.dart';

part 'room.freezed.dart';
part 'room.g.dart';

enum RoomStatus {
  @JsonValue('active')
  active,
  @JsonValue('renovation')
  renovation,
  @JsonValue('upcoming')
  upcoming,
}

@freezed
class RoomType with _$RoomType {
  const factory RoomType({
    required String id,
    required String name,
    required String nameRu,
    required double pricePerNight,
    @Default('') String description,
  }) = _RoomType;

  factory RoomType.fromJson(Map<String, dynamic> json) =>
      _$RoomTypeFromJson(json);
}

@freezed
class Room with _$Room {
  const factory Room({
    required String id,
    required String number,
    required String typeId,
    required int floor,
    required int totalShares,
    required int availableShares,
    required int soldShares,
    required double sharePrice,
    required double occupancyRate,
    required double monthlyRevenue,
    @Default(RoomStatus.active) RoomStatus status,
    required String objectId,
  }) = _Room;

  factory Room.fromJson(Map<String, dynamic> json) => _$RoomFromJson(json);
}
