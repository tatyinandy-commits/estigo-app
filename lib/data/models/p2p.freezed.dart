// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'p2p.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

P2POrder _$P2POrderFromJson(Map<String, dynamic> json) {
  return _P2POrder.fromJson(json);
}

/// @nodoc
mixin _$P2POrder {
  String get id => throw _privateConstructorUsedError;
  OrderType get type => throw _privateConstructorUsedError;
  String get roomId => throw _privateConstructorUsedError;
  String get roomNumber => throw _privateConstructorUsedError;
  String get roomType => throw _privateConstructorUsedError;
  int get shares => throw _privateConstructorUsedError;
  double get pricePerShare => throw _privateConstructorUsedError;
  double get totalPrice => throw _privateConstructorUsedError;
  String? get sellerName => throw _privateConstructorUsedError;
  String? get buyerName => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  OrderStatus get status => throw _privateConstructorUsedError;
  String get userId => throw _privateConstructorUsedError;

  /// Serializes this P2POrder to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of P2POrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $P2POrderCopyWith<P2POrder> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $P2POrderCopyWith<$Res> {
  factory $P2POrderCopyWith(P2POrder value, $Res Function(P2POrder) then) =
      _$P2POrderCopyWithImpl<$Res, P2POrder>;
  @useResult
  $Res call(
      {String id,
      OrderType type,
      String roomId,
      String roomNumber,
      String roomType,
      int shares,
      double pricePerShare,
      double totalPrice,
      String? sellerName,
      String? buyerName,
      String createdAt,
      OrderStatus status,
      String userId});
}

/// @nodoc
class _$P2POrderCopyWithImpl<$Res, $Val extends P2POrder>
    implements $P2POrderCopyWith<$Res> {
  _$P2POrderCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of P2POrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? roomId = null,
    Object? roomNumber = null,
    Object? roomType = null,
    Object? shares = null,
    Object? pricePerShare = null,
    Object? totalPrice = null,
    Object? sellerName = freezed,
    Object? buyerName = freezed,
    Object? createdAt = null,
    Object? status = null,
    Object? userId = null,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as OrderType,
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
      pricePerShare: null == pricePerShare
          ? _value.pricePerShare
          : pricePerShare // ignore: cast_nullable_to_non_nullable
              as double,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      sellerName: freezed == sellerName
          ? _value.sellerName
          : sellerName // ignore: cast_nullable_to_non_nullable
              as String?,
      buyerName: freezed == buyerName
          ? _value.buyerName
          : buyerName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$P2POrderImplCopyWith<$Res>
    implements $P2POrderCopyWith<$Res> {
  factory _$$P2POrderImplCopyWith(
          _$P2POrderImpl value, $Res Function(_$P2POrderImpl) then) =
      __$$P2POrderImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      OrderType type,
      String roomId,
      String roomNumber,
      String roomType,
      int shares,
      double pricePerShare,
      double totalPrice,
      String? sellerName,
      String? buyerName,
      String createdAt,
      OrderStatus status,
      String userId});
}

/// @nodoc
class __$$P2POrderImplCopyWithImpl<$Res>
    extends _$P2POrderCopyWithImpl<$Res, _$P2POrderImpl>
    implements _$$P2POrderImplCopyWith<$Res> {
  __$$P2POrderImplCopyWithImpl(
      _$P2POrderImpl _value, $Res Function(_$P2POrderImpl) _then)
      : super(_value, _then);

  /// Create a copy of P2POrder
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? type = null,
    Object? roomId = null,
    Object? roomNumber = null,
    Object? roomType = null,
    Object? shares = null,
    Object? pricePerShare = null,
    Object? totalPrice = null,
    Object? sellerName = freezed,
    Object? buyerName = freezed,
    Object? createdAt = null,
    Object? status = null,
    Object? userId = null,
  }) {
    return _then(_$P2POrderImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      type: null == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as OrderType,
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
      pricePerShare: null == pricePerShare
          ? _value.pricePerShare
          : pricePerShare // ignore: cast_nullable_to_non_nullable
              as double,
      totalPrice: null == totalPrice
          ? _value.totalPrice
          : totalPrice // ignore: cast_nullable_to_non_nullable
              as double,
      sellerName: freezed == sellerName
          ? _value.sellerName
          : sellerName // ignore: cast_nullable_to_non_nullable
              as String?,
      buyerName: freezed == buyerName
          ? _value.buyerName
          : buyerName // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as OrderStatus,
      userId: null == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$P2POrderImpl implements _P2POrder {
  const _$P2POrderImpl(
      {required this.id,
      required this.type,
      required this.roomId,
      required this.roomNumber,
      required this.roomType,
      required this.shares,
      required this.pricePerShare,
      required this.totalPrice,
      this.sellerName,
      this.buyerName,
      required this.createdAt,
      this.status = OrderStatus.active,
      this.userId = ''});

  factory _$P2POrderImpl.fromJson(Map<String, dynamic> json) =>
      _$$P2POrderImplFromJson(json);

  @override
  final String id;
  @override
  final OrderType type;
  @override
  final String roomId;
  @override
  final String roomNumber;
  @override
  final String roomType;
  @override
  final int shares;
  @override
  final double pricePerShare;
  @override
  final double totalPrice;
  @override
  final String? sellerName;
  @override
  final String? buyerName;
  @override
  final String createdAt;
  @override
  @JsonKey()
  final OrderStatus status;
  @override
  @JsonKey()
  final String userId;

  @override
  String toString() {
    return 'P2POrder(id: $id, type: $type, roomId: $roomId, roomNumber: $roomNumber, roomType: $roomType, shares: $shares, pricePerShare: $pricePerShare, totalPrice: $totalPrice, sellerName: $sellerName, buyerName: $buyerName, createdAt: $createdAt, status: $status, userId: $userId)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$P2POrderImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.roomId, roomId) || other.roomId == roomId) &&
            (identical(other.roomNumber, roomNumber) ||
                other.roomNumber == roomNumber) &&
            (identical(other.roomType, roomType) ||
                other.roomType == roomType) &&
            (identical(other.shares, shares) || other.shares == shares) &&
            (identical(other.pricePerShare, pricePerShare) ||
                other.pricePerShare == pricePerShare) &&
            (identical(other.totalPrice, totalPrice) ||
                other.totalPrice == totalPrice) &&
            (identical(other.sellerName, sellerName) ||
                other.sellerName == sellerName) &&
            (identical(other.buyerName, buyerName) ||
                other.buyerName == buyerName) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.userId, userId) || other.userId == userId));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      type,
      roomId,
      roomNumber,
      roomType,
      shares,
      pricePerShare,
      totalPrice,
      sellerName,
      buyerName,
      createdAt,
      status,
      userId);

  /// Create a copy of P2POrder
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$P2POrderImplCopyWith<_$P2POrderImpl> get copyWith =>
      __$$P2POrderImplCopyWithImpl<_$P2POrderImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$P2POrderImplToJson(
      this,
    );
  }
}

abstract class _P2POrder implements P2POrder {
  const factory _P2POrder(
      {required final String id,
      required final OrderType type,
      required final String roomId,
      required final String roomNumber,
      required final String roomType,
      required final int shares,
      required final double pricePerShare,
      required final double totalPrice,
      final String? sellerName,
      final String? buyerName,
      required final String createdAt,
      final OrderStatus status,
      final String userId}) = _$P2POrderImpl;

  factory _P2POrder.fromJson(Map<String, dynamic> json) =
      _$P2POrderImpl.fromJson;

  @override
  String get id;
  @override
  OrderType get type;
  @override
  String get roomId;
  @override
  String get roomNumber;
  @override
  String get roomType;
  @override
  int get shares;
  @override
  double get pricePerShare;
  @override
  double get totalPrice;
  @override
  String? get sellerName;
  @override
  String? get buyerName;
  @override
  String get createdAt;
  @override
  OrderStatus get status;
  @override
  String get userId;

  /// Create a copy of P2POrder
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$P2POrderImplCopyWith<_$P2POrderImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
