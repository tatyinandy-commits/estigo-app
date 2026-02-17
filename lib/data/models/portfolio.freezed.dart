// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'portfolio.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

UserShare _$UserShareFromJson(Map<String, dynamic> json) {
  return _UserShare.fromJson(json);
}

/// @nodoc
mixin _$UserShare {
  String get roomId => throw _privateConstructorUsedError;
  String get roomNumber => throw _privateConstructorUsedError;
  String get roomType => throw _privateConstructorUsedError;
  int get shares => throw _privateConstructorUsedError;
  double get purchasePrice => throw _privateConstructorUsedError;
  double get currentValue => throw _privateConstructorUsedError;
  double get totalIncome => throw _privateConstructorUsedError;
  String get purchaseDate => throw _privateConstructorUsedError;

  /// Serializes this UserShare to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of UserShare
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $UserShareCopyWith<UserShare> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UserShareCopyWith<$Res> {
  factory $UserShareCopyWith(UserShare value, $Res Function(UserShare) then) =
      _$UserShareCopyWithImpl<$Res, UserShare>;
  @useResult
  $Res call(
      {String roomId,
      String roomNumber,
      String roomType,
      int shares,
      double purchasePrice,
      double currentValue,
      double totalIncome,
      String purchaseDate});
}

/// @nodoc
class _$UserShareCopyWithImpl<$Res, $Val extends UserShare>
    implements $UserShareCopyWith<$Res> {
  _$UserShareCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of UserShare
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? roomNumber = null,
    Object? roomType = null,
    Object? shares = null,
    Object? purchasePrice = null,
    Object? currentValue = null,
    Object? totalIncome = null,
    Object? purchaseDate = null,
  }) {
    return _then(_value.copyWith(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      roomType: null == roomType
          ? _value.roomType
          : roomType // ignore: cast_nullable_to_non_nullable
              as String,
      shares: null == shares
          ? _value.shares
          : shares // ignore: cast_nullable_to_non_nullable
              as int,
      purchasePrice: null == purchasePrice
          ? _value.purchasePrice
          : purchasePrice // ignore: cast_nullable_to_non_nullable
              as double,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalIncome: null == totalIncome
          ? _value.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as double,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$UserShareImplCopyWith<$Res>
    implements $UserShareCopyWith<$Res> {
  factory _$$UserShareImplCopyWith(
          _$UserShareImpl value, $Res Function(_$UserShareImpl) then) =
      __$$UserShareImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String roomId,
      String roomNumber,
      String roomType,
      int shares,
      double purchasePrice,
      double currentValue,
      double totalIncome,
      String purchaseDate});
}

/// @nodoc
class __$$UserShareImplCopyWithImpl<$Res>
    extends _$UserShareCopyWithImpl<$Res, _$UserShareImpl>
    implements _$$UserShareImplCopyWith<$Res> {
  __$$UserShareImplCopyWithImpl(
      _$UserShareImpl _value, $Res Function(_$UserShareImpl) _then)
      : super(_value, _then);

  /// Create a copy of UserShare
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? roomId = null,
    Object? roomNumber = null,
    Object? roomType = null,
    Object? shares = null,
    Object? purchasePrice = null,
    Object? currentValue = null,
    Object? totalIncome = null,
    Object? purchaseDate = null,
  }) {
    return _then(_$UserShareImpl(
      roomId: null == roomId
          ? _value.roomId
          : roomId // ignore: cast_nullable_to_non_nullable
              as String,
      roomNumber: null == roomNumber
          ? _value.roomNumber
          : roomNumber // ignore: cast_nullable_to_non_nullable
              as String,
      roomType: null == roomType
          ? _value.roomType
          : roomType // ignore: cast_nullable_to_non_nullable
              as String,
      shares: null == shares
          ? _value.shares
          : shares // ignore: cast_nullable_to_non_nullable
              as int,
      purchasePrice: null == purchasePrice
          ? _value.purchasePrice
          : purchasePrice // ignore: cast_nullable_to_non_nullable
              as double,
      currentValue: null == currentValue
          ? _value.currentValue
          : currentValue // ignore: cast_nullable_to_non_nullable
              as double,
      totalIncome: null == totalIncome
          ? _value.totalIncome
          : totalIncome // ignore: cast_nullable_to_non_nullable
              as double,
      purchaseDate: null == purchaseDate
          ? _value.purchaseDate
          : purchaseDate // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$UserShareImpl implements _UserShare {
  const _$UserShareImpl(
      {required this.roomId,
      required this.roomNumber,
      required this.roomType,
      required this.shares,
      required this.purchasePrice,
      required this.currentValue,
      required this.totalIncome,
      required this.purchaseDate});

  factory _$UserShareImpl.fromJson(Map<String, dynamic> json) =>
      _$$UserShareImplFromJson(json);

  @override
  final String roomId;
  @override
  final String roomNumber;
  @override
  final String roomType;
  @override
  final int shares;
  @override
  final double purchasePrice;
  @override
  final double currentValue;
  @override
  final double totalIncome;
  @override
  final String purchaseDate;

  @override
  String toString() {
    return 'UserShare(roomId: $roomId, roomNumber: $roomNumber, roomType: $roomType, shares: $shares, purchasePrice: $purchasePrice, currentValue: $currentValue, totalIncome: $totalIncome, purchaseDate: $purchaseDate)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$UserShareImpl &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.roomType, roomType) ||
                other.roomType == roomType) &&
            (identical(other.shares, shares) || other.shares == shares) &&
            (identical(other.purchasePrice, purchasePrice) ||
                other.purchasePrice == purchasePrice) &&
            (identical(other.currentValue, currentValue) ||
                other.currentValue == currentValue) &&
            (identical(other.totalIncome, totalIncome) ||
                other.totalIncome == totalIncome) &&
            (identical(other.purchaseDate, purchaseDate) ||
                other.purchaseDate == purchaseDate));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, roomId, roomNumber, roomType,
      shares, purchasePrice, currentValue, totalIncome, purchaseDate);

  /// Create a copy of UserShare
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$UserShareImplCopyWith<_$UserShareImpl> get copyWith =>
      __$$UserShareImplCopyWithImpl<_$UserShareImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$UserShareImplToJson(
      this,
    );
  }
}

abstract class _UserShare implements UserShare {
  const factory _UserShare(
      {required final String roomId,
      required final String roomNumber,
      required final String roomType,
      required final int shares,
      required final double purchasePrice,
      required final double currentValue,
      required final double totalIncome,
      required final String purchaseDate}) = _$UserShareImpl;

  factory _UserShare.fromJson(Map<String, dynamic> json) =
      _$UserShareImpl.fromJson;

  @override
  String get roomId;
  @override
  String get roomNumber;
  @override
  String get roomType;
  @override
  int get shares;
  @override
  double get purchasePrice;
  @override
  double get currentValue;
  @override
  double get totalIncome;
  @override
  String get purchaseDate;

  /// Create a copy of UserShare
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$UserShareImplCopyWith<_$UserShareImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
