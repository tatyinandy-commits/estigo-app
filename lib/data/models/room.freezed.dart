// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'room.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RoomType _$RoomTypeFromJson(Map<String, dynamic> json) {
  return _RoomType.fromJson(json);
}

/// @nodoc
mixin _$RoomType {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get nameRu => throw _privateConstructorUsedError;
  double get pricePerNight => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;

  /// Serializes this RoomType to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RoomType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomTypeCopyWith<RoomType> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomTypeCopyWith<$Res> {
  factory $RoomTypeCopyWith(RoomType value, $Res Function(RoomType) then) =
      _$RoomTypeCopyWithImpl<$Res, RoomType>;
  @useResult
  $Res call(
      {String id,
      String name,
      String nameRu,
      double pricePerNight,
      String description});
}

/// @nodoc
class _$RoomTypeCopyWithImpl<$Res, $Val extends RoomType>
    implements $RoomTypeCopyWith<$Res> {
  _$RoomTypeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RoomType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameRu = null,
    Object? pricePerNight = null,
    Object? description = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameRu: null == nameRu
          ? _value.nameRu
          : nameRu // ignore: cast_nullable_to_non_nullable
              as String,
      pricePerNight: null == pricePerNight
          ? _value.pricePerNight
          : pricePerNight // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomTypeImplCopyWith<$Res>
    implements $RoomTypeCopyWith<$Res> {
  factory _$$RoomTypeImplCopyWith(
          _$RoomTypeImpl value, $Res Function(_$RoomTypeImpl) then) =
      __$$RoomTypeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String nameRu,
      double pricePerNight,
      String description});
}

/// @nodoc
class __$$RoomTypeImplCopyWithImpl<$Res>
    extends _$RoomTypeCopyWithImpl<$Res, _$RoomTypeImpl>
    implements _$$RoomTypeImplCopyWith<$Res> {
  __$$RoomTypeImplCopyWithImpl(
      _$RoomTypeImpl _value, $Res Function(_$RoomTypeImpl) _then)
      : super(_value, _then);

  /// Create a copy of RoomType
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? nameRu = null,
    Object? pricePerNight = null,
    Object? description = null,
  }) {
    return _then(_$RoomTypeImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      nameRu: null == nameRu
          ? _value.nameRu
          : nameRu // ignore: cast_nullable_to_non_nullable
              as String,
      pricePerNight: null == pricePerNight
          ? _value.pricePerNight
          : pricePerNight // ignore: cast_nullable_to_non_nullable
              as double,
      description: null == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomTypeImpl implements _RoomType {
  const _$RoomTypeImpl(
      {required this.id,
      required this.name,
      required this.nameRu,
      required this.pricePerNight,
      this.description = ''});

  factory _$RoomTypeImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomTypeImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String nameRu;
  @override
  final double pricePerNight;
  @override
  @JsonKey()
  final String description;

  @override
  String toString() {
    return 'RoomType(id: $id, name: $name, nameRu: $nameRu, pricePerNight: $pricePerNight, description: $description)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomTypeImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.nameRu, nameRu) || other.nameRu == nameRu) &&
            (identical(other.pricePerNight, pricePerNight) ||
                other.pricePerNight == pricePerNight) &&
            (identical(other.description, description) ||
                other.description == description));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, name, nameRu, pricePerNight, description);

  /// Create a copy of RoomType
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomTypeImplCopyWith<_$RoomTypeImpl> get copyWith =>
      __$$RoomTypeImplCopyWithImpl<_$RoomTypeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomTypeImplToJson(
      this,
    );
  }
}

abstract class _RoomType implements RoomType {
  const factory _RoomType(
      {required final String id,
      required final String name,
      required final String nameRu,
      required final double pricePerNight,
      final String description}) = _$RoomTypeImpl;

  factory _RoomType.fromJson(Map<String, dynamic> json) =
      _$RoomTypeImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get nameRu;
  @override
  double get pricePerNight;
  @override
  String get description;

  /// Create a copy of RoomType
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomTypeImplCopyWith<_$RoomTypeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Room _$RoomFromJson(Map<String, dynamic> json) {
  return _Room.fromJson(json);
}

/// @nodoc
mixin _$Room {
  String get id => throw _privateConstructorUsedError;
  String get number => throw _privateConstructorUsedError;
  String get typeId => throw _privateConstructorUsedError;
  int get floor => throw _privateConstructorUsedError;
  int get totalShares => throw _privateConstructorUsedError;
  int get availableShares => throw _privateConstructorUsedError;
  int get soldShares => throw _privateConstructorUsedError;
  double get sharePrice => throw _privateConstructorUsedError;
  double get occupancyRate => throw _privateConstructorUsedError;
  double get monthlyRevenue => throw _privateConstructorUsedError;
  RoomStatus get status => throw _privateConstructorUsedError;
  String get objectId => throw _privateConstructorUsedError;

  /// Serializes this Room to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RoomCopyWith<Room> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RoomCopyWith<$Res> {
  factory $RoomCopyWith(Room value, $Res Function(Room) then) =
      _$RoomCopyWithImpl<$Res, Room>;
  @useResult
  $Res call(
      {String id,
      String number,
      String typeId,
      int floor,
      int totalShares,
      int availableShares,
      int soldShares,
      double sharePrice,
      double occupancyRate,
      double monthlyRevenue,
      RoomStatus status,
      String objectId});
}

/// @nodoc
class _$RoomCopyWithImpl<$Res, $Val extends Room>
    implements $RoomCopyWith<$Res> {
  _$RoomCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? typeId = null,
    Object? floor = null,
    Object? totalShares = null,
    Object? availableShares = null,
    Object? soldShares = null,
    Object? sharePrice = null,
    Object? occupancyRate = null,
    Object? monthlyRevenue = null,
    Object? status = null,
    Object? objectId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      typeId: null == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as int,
      totalShares: null == totalShares
          ? _value.totalShares
          : totalShares // ignore: cast_nullable_to_non_nullable
              as int,
      availableShares: null == availableShares
          ? _value.availableShares
          : availableShares // ignore: cast_nullable_to_non_nullable
              as int,
      soldShares: null == soldShares
          ? _value.soldShares
          : soldShares // ignore: cast_nullable_to_non_nullable
              as int,
      sharePrice: null == sharePrice
          ? _value.sharePrice
          : sharePrice // ignore: cast_nullable_to_non_nullable
              as double,
      occupancyRate: null == occupancyRate
          ? _value.occupancyRate
          : occupancyRate // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyRevenue: null == monthlyRevenue
          ? _value.monthlyRevenue
          : monthlyRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RoomStatus,
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RoomImplCopyWith<$Res> implements $RoomCopyWith<$Res> {
  factory _$$RoomImplCopyWith(
          _$RoomImpl value, $Res Function(_$RoomImpl) then) =
      __$$RoomImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String number,
      String typeId,
      int floor,
      int totalShares,
      int availableShares,
      int soldShares,
      double sharePrice,
      double occupancyRate,
      double monthlyRevenue,
      RoomStatus status,
      String objectId});
}

/// @nodoc
class __$$RoomImplCopyWithImpl<$Res>
    extends _$RoomCopyWithImpl<$Res, _$RoomImpl>
    implements _$$RoomImplCopyWith<$Res> {
  __$$RoomImplCopyWithImpl(_$RoomImpl _value, $Res Function(_$RoomImpl) _then)
      : super(_value, _then);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? number = null,
    Object? typeId = null,
    Object? floor = null,
    Object? totalShares = null,
    Object? availableShares = null,
    Object? soldShares = null,
    Object? sharePrice = null,
    Object? occupancyRate = null,
    Object? monthlyRevenue = null,
    Object? status = null,
    Object? objectId = null,
  }) {
    return _then(_$RoomImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      number: null == number
          ? _value.number
          : number // ignore: cast_nullable_to_non_nullable
              as String,
      typeId: null == typeId
          ? _value.typeId
          : typeId // ignore: cast_nullable_to_non_nullable
              as String,
      floor: null == floor
          ? _value.floor
          : floor // ignore: cast_nullable_to_non_nullable
              as int,
      totalShares: null == totalShares
          ? _value.totalShares
          : totalShares // ignore: cast_nullable_to_non_nullable
              as int,
      availableShares: null == availableShares
          ? _value.availableShares
          : availableShares // ignore: cast_nullable_to_non_nullable
              as int,
      soldShares: null == soldShares
          ? _value.soldShares
          : soldShares // ignore: cast_nullable_to_non_nullable
              as int,
      sharePrice: null == sharePrice
          ? _value.sharePrice
          : sharePrice // ignore: cast_nullable_to_non_nullable
              as double,
      occupancyRate: null == occupancyRate
          ? _value.occupancyRate
          : occupancyRate // ignore: cast_nullable_to_non_nullable
              as double,
      monthlyRevenue: null == monthlyRevenue
          ? _value.monthlyRevenue
          : monthlyRevenue // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as RoomStatus,
      objectId: null == objectId
          ? _value.objectId
          : objectId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RoomImpl implements _Room {
  const _$RoomImpl(
      {required this.id,
      required this.number,
      required this.typeId,
      required this.floor,
      required this.totalShares,
      required this.availableShares,
      required this.soldShares,
      required this.sharePrice,
      required this.occupancyRate,
      required this.monthlyRevenue,
      this.status = RoomStatus.active,
      required this.objectId});

  factory _$RoomImpl.fromJson(Map<String, dynamic> json) =>
      _$$RoomImplFromJson(json);

  @override
  final String id;
  @override
  final String number;
  @override
  final String typeId;
  @override
  final int floor;
  @override
  final int totalShares;
  @override
  final int availableShares;
  @override
  final int soldShares;
  @override
  final double sharePrice;
  @override
  final double occupancyRate;
  @override
  final double monthlyRevenue;
  @override
  @JsonKey()
  final RoomStatus status;
  @override
  final String objectId;

  @override
  String toString() {
    return 'Room(id: $id, number: $number, typeId: $typeId, floor: $floor, totalShares: $totalShares, availableShares: $availableShares, soldShares: $soldShares, sharePrice: $sharePrice, occupancyRate: $occupancyRate, monthlyRevenue: $monthlyRevenue, status: $status, objectId: $objectId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RoomImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.number, number) || other.number == number) &&
            (identical(other.typeId, typeId) || other.typeId == typeId) &&
            (identical(other.floor, floor) || other.floor == floor) &&
            (identical(other.totalShares, totalShares) ||
                other.totalShares == totalShares) &&
            (identical(other.availableShares, availableShares) ||
                other.availableShares == availableShares) &&
            (identical(other.soldShares, soldShares) ||
                other.soldShares == soldShares) &&
            (identical(other.sharePrice, sharePrice) ||
                other.sharePrice == sharePrice) &&
            (identical(other.occupancyRate, occupancyRate) ||
                other.occupancyRate == occupancyRate) &&
            (identical(other.monthlyRevenue, monthlyRevenue) ||
                other.monthlyRevenue == monthlyRevenue) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.objectId, objectId) ||
                other.objectId == objectId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      number,
      typeId,
      floor,
      totalShares,
      availableShares,
      soldShares,
      sharePrice,
      occupancyRate,
      monthlyRevenue,
      status,
      objectId);

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      __$$RoomImplCopyWithImpl<_$RoomImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RoomImplToJson(
      this,
    );
  }
}

abstract class _Room implements Room {
  const factory _Room(
      {required final String id,
      required final String number,
      required final String typeId,
      required final int floor,
      required final int totalShares,
      required final int availableShares,
      required final int soldShares,
      required final double sharePrice,
      required final double occupancyRate,
      required final double monthlyRevenue,
      final RoomStatus status,
      required final String objectId}) = _$RoomImpl;

  factory _Room.fromJson(Map<String, dynamic> json) = _$RoomImpl.fromJson;

  @override
  String get id;
  @override
  String get number;
  @override
  String get typeId;
  @override
  int get floor;
  @override
  int get totalShares;
  @override
  int get availableShares;
  @override
  int get soldShares;
  @override
  double get sharePrice;
  @override
  double get occupancyRate;
  @override
  double get monthlyRevenue;
  @override
  RoomStatus get status;
  @override
  String get objectId;

  /// Create a copy of Room
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RoomImplCopyWith<_$RoomImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
