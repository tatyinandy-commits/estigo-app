// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'referral.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

Referral _$ReferralFromJson(Map<String, dynamic> json) {
  return _Referral.fromJson(json);
}

/// @nodoc
mixin _$Referral {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get registeredAt => throw _privateConstructorUsedError;
  double get invested => throw _privateConstructorUsedError;
  double get commission => throw _privateConstructorUsedError;
  ReferralStatus get status => throw _privateConstructorUsedError;

  /// Serializes this Referral to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $ReferralCopyWith<Referral> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $ReferralCopyWith<$Res> {
  factory $ReferralCopyWith(Referral value, $Res Function(Referral) then) =
      _$ReferralCopyWithImpl<$Res, Referral>;
  @useResult
  $Res call(
      {String id,
      String name,
      String registeredAt,
      double invested,
      double commission,
      ReferralStatus status});
}

/// @nodoc
class _$ReferralCopyWithImpl<$Res, $Val extends Referral>
    implements $ReferralCopyWith<$Res> {
  _$ReferralCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? registeredAt = null,
    Object? invested = null,
    Object? commission = null,
    Object? status = null,
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
      registeredAt: null == registeredAt
          ? _value.registeredAt
          : registeredAt // ignore: cast_nullable_to_non_nullable
              as String,
      invested: null == invested
          ? _value.invested
          : invested // ignore: cast_nullable_to_non_nullable
              as double,
      commission: null == commission
          ? _value.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReferralStatus,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$ReferralImplCopyWith<$Res>
    implements $ReferralCopyWith<$Res> {
  factory _$$ReferralImplCopyWith(
          _$ReferralImpl value, $Res Function(_$ReferralImpl) then) =
      __$$ReferralImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String name,
      String registeredAt,
      double invested,
      double commission,
      ReferralStatus status});
}

/// @nodoc
class __$$ReferralImplCopyWithImpl<$Res>
    extends _$ReferralCopyWithImpl<$Res, _$ReferralImpl>
    implements _$$ReferralImplCopyWith<$Res> {
  __$$ReferralImplCopyWithImpl(
      _$ReferralImpl _value, $Res Function(_$ReferralImpl) _then)
      : super(_value, _then);

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? registeredAt = null,
    Object? invested = null,
    Object? commission = null,
    Object? status = null,
  }) {
    return _then(_$ReferralImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      registeredAt: null == registeredAt
          ? _value.registeredAt
          : registeredAt // ignore: cast_nullable_to_non_nullable
              as String,
      invested: null == invested
          ? _value.invested
          : invested // ignore: cast_nullable_to_non_nullable
              as double,
      commission: null == commission
          ? _value.commission
          : commission // ignore: cast_nullable_to_non_nullable
              as double,
      status: null == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as ReferralStatus,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$ReferralImpl implements _Referral {
  const _$ReferralImpl(
      {required this.id,
      required this.name,
      required this.registeredAt,
      this.invested = 0,
      this.commission = 0,
      this.status = ReferralStatus.active});

  factory _$ReferralImpl.fromJson(Map<String, dynamic> json) =>
      _$$ReferralImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String registeredAt;
  @override
  @JsonKey()
  final double invested;
  @override
  @JsonKey()
  final double commission;
  @override
  @JsonKey()
  final ReferralStatus status;

  @override
  String toString() {
    return 'Referral(id: $id, name: $name, registeredAt: $registeredAt, invested: $invested, commission: $commission, status: $status)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$ReferralImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.registeredAt, registeredAt) ||
                other.registeredAt == registeredAt) &&
            (identical(other.invested, invested) ||
                other.invested == invested) &&
            (identical(other.commission, commission) ||
                other.commission == commission) &&
            (identical(other.status, status) || other.status == status));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, name, registeredAt, invested, commission, status);

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$ReferralImplCopyWith<_$ReferralImpl> get copyWith =>
      __$$ReferralImplCopyWithImpl<_$ReferralImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$ReferralImplToJson(
      this,
    );
  }
}

abstract class _Referral implements Referral {
  const factory _Referral(
      {required final String id,
      required final String name,
      required final String registeredAt,
      final double invested,
      final double commission,
      final ReferralStatus status}) = _$ReferralImpl;

  factory _Referral.fromJson(Map<String, dynamic> json) =
      _$ReferralImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get registeredAt;
  @override
  double get invested;
  @override
  double get commission;
  @override
  ReferralStatus get status;

  /// Create a copy of Referral
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$ReferralImplCopyWith<_$ReferralImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

PartnerData _$PartnerDataFromJson(Map<String, dynamic> json) {
  return _PartnerData.fromJson(json);
}

/// @nodoc
mixin _$PartnerData {
  String get referralCode => throw _privateConstructorUsedError;
  String get referralLink => throw _privateConstructorUsedError;
  PartnerTier get tier => throw _privateConstructorUsedError;
  int get totalReferrals => throw _privateConstructorUsedError;
  int get activeReferrals => throw _privateConstructorUsedError;
  double get totalCommission => throw _privateConstructorUsedError;
  double get pendingCommission => throw _privateConstructorUsedError;
  double get commissionRate => throw _privateConstructorUsedError;
  List<Referral> get referrals => throw _privateConstructorUsedError;

  /// Serializes this PartnerData to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of PartnerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $PartnerDataCopyWith<PartnerData> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PartnerDataCopyWith<$Res> {
  factory $PartnerDataCopyWith(
          PartnerData value, $Res Function(PartnerData) then) =
      _$PartnerDataCopyWithImpl<$Res, PartnerData>;
  @useResult
  $Res call(
      {String referralCode,
      String referralLink,
      PartnerTier tier,
      int totalReferrals,
      int activeReferrals,
      double totalCommission,
      double pendingCommission,
      double commissionRate,
      List<Referral> referrals});
}

/// @nodoc
class _$PartnerDataCopyWithImpl<$Res, $Val extends PartnerData>
    implements $PartnerDataCopyWith<$Res> {
  _$PartnerDataCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of PartnerData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referralCode = null,
    Object? referralLink = null,
    Object? tier = null,
    Object? totalReferrals = null,
    Object? activeReferrals = null,
    Object? totalCommission = null,
    Object? pendingCommission = null,
    Object? commissionRate = null,
    Object? referrals = null,
  }) {
    return _then(_value.copyWith(
      referralCode: null == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String,
      referralLink: null == referralLink
          ? _value.referralLink
          : referralLink // ignore: cast_nullable_to_non_nullable
              as String,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as PartnerTier,
      totalReferrals: null == totalReferrals
          ? _value.totalReferrals
          : totalReferrals // ignore: cast_nullable_to_non_nullable
              as int,
      activeReferrals: null == activeReferrals
          ? _value.activeReferrals
          : activeReferrals // ignore: cast_nullable_to_non_nullable
              as int,
      totalCommission: null == totalCommission
          ? _value.totalCommission
          : totalCommission // ignore: cast_nullable_to_non_nullable
              as double,
      pendingCommission: null == pendingCommission
          ? _value.pendingCommission
          : pendingCommission // ignore: cast_nullable_to_non_nullable
              as double,
      commissionRate: null == commissionRate
          ? _value.commissionRate
          : commissionRate // ignore: cast_nullable_to_non_nullable
              as double,
      referrals: null == referrals
          ? _value.referrals
          : referrals // ignore: cast_nullable_to_non_nullable
              as List<Referral>,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$PartnerDataImplCopyWith<$Res>
    implements $PartnerDataCopyWith<$Res> {
  factory _$$PartnerDataImplCopyWith(
          _$PartnerDataImpl value, $Res Function(_$PartnerDataImpl) then) =
      __$$PartnerDataImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String referralCode,
      String referralLink,
      PartnerTier tier,
      int totalReferrals,
      int activeReferrals,
      double totalCommission,
      double pendingCommission,
      double commissionRate,
      List<Referral> referrals});
}

/// @nodoc
class __$$PartnerDataImplCopyWithImpl<$Res>
    extends _$PartnerDataCopyWithImpl<$Res, _$PartnerDataImpl>
    implements _$$PartnerDataImplCopyWith<$Res> {
  __$$PartnerDataImplCopyWithImpl(
      _$PartnerDataImpl _value, $Res Function(_$PartnerDataImpl) _then)
      : super(_value, _then);

  /// Create a copy of PartnerData
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? referralCode = null,
    Object? referralLink = null,
    Object? tier = null,
    Object? totalReferrals = null,
    Object? activeReferrals = null,
    Object? totalCommission = null,
    Object? pendingCommission = null,
    Object? commissionRate = null,
    Object? referrals = null,
  }) {
    return _then(_$PartnerDataImpl(
      referralCode: null == referralCode
          ? _value.referralCode
          : referralCode // ignore: cast_nullable_to_non_nullable
              as String,
      referralLink: null == referralLink
          ? _value.referralLink
          : referralLink // ignore: cast_nullable_to_non_nullable
              as String,
      tier: null == tier
          ? _value.tier
          : tier // ignore: cast_nullable_to_non_nullable
              as PartnerTier,
      totalReferrals: null == totalReferrals
          ? _value.totalReferrals
          : totalReferrals // ignore: cast_nullable_to_non_nullable
              as int,
      activeReferrals: null == activeReferrals
          ? _value.activeReferrals
          : activeReferrals // ignore: cast_nullable_to_non_nullable
              as int,
      totalCommission: null == totalCommission
          ? _value.totalCommission
          : totalCommission // ignore: cast_nullable_to_non_nullable
              as double,
      pendingCommission: null == pendingCommission
          ? _value.pendingCommission
          : pendingCommission // ignore: cast_nullable_to_non_nullable
              as double,
      commissionRate: null == commissionRate
          ? _value.commissionRate
          : commissionRate // ignore: cast_nullable_to_non_nullable
              as double,
      referrals: null == referrals
          ? _value._referrals
          : referrals // ignore: cast_nullable_to_non_nullable
              as List<Referral>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$PartnerDataImpl implements _PartnerData {
  const _$PartnerDataImpl(
      {required this.referralCode,
      required this.referralLink,
      this.tier = PartnerTier.bronze,
      this.totalReferrals = 0,
      this.activeReferrals = 0,
      this.totalCommission = 0,
      this.pendingCommission = 0,
      this.commissionRate = 0,
      final List<Referral> referrals = const []})
      : _referrals = referrals;

  factory _$PartnerDataImpl.fromJson(Map<String, dynamic> json) =>
      _$$PartnerDataImplFromJson(json);

  @override
  final String referralCode;
  @override
  final String referralLink;
  @override
  @JsonKey()
  final PartnerTier tier;
  @override
  @JsonKey()
  final int totalReferrals;
  @override
  @JsonKey()
  final int activeReferrals;
  @override
  @JsonKey()
  final double totalCommission;
  @override
  @JsonKey()
  final double pendingCommission;
  @override
  @JsonKey()
  final double commissionRate;
  final List<Referral> _referrals;
  @override
  @JsonKey()
  List<Referral> get referrals {
    if (_referrals is EqualUnmodifiableListView) return _referrals;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_referrals);
  }

  @override
  String toString() {
    return 'PartnerData(referralCode: $referralCode, referralLink: $referralLink, tier: $tier, totalReferrals: $totalReferrals, activeReferrals: $activeReferrals, totalCommission: $totalCommission, pendingCommission: $pendingCommission, commissionRate: $commissionRate, referrals: $referrals)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$PartnerDataImpl &&
            (identical(other.referralCode, referralCode) ||
                other.referralCode == referralCode) &&
            (identical(other.referralLink, referralLink) ||
                other.referralLink == referralLink) &&
            (identical(other.tier, tier) || other.tier == tier) &&
            (identical(other.totalReferrals, totalReferrals) ||
                other.totalReferrals == totalReferrals) &&
            (identical(other.activeReferrals, activeReferrals) ||
                other.activeReferrals == activeReferrals) &&
            (identical(other.totalCommission, totalCommission) ||
                other.totalCommission == totalCommission) &&
            (identical(other.pendingCommission, pendingCommission) ||
                other.pendingCommission == pendingCommission) &&
            (identical(other.commissionRate, commissionRate) ||
                other.commissionRate == commissionRate) &&
            const DeepCollectionEquality()
                .equals(other._referrals, _referrals));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      referralCode,
      referralLink,
      tier,
      totalReferrals,
      activeReferrals,
      totalCommission,
      pendingCommission,
      commissionRate,
      const DeepCollectionEquality().hash(_referrals));

  /// Create a copy of PartnerData
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$PartnerDataImplCopyWith<_$PartnerDataImpl> get copyWith =>
      __$$PartnerDataImplCopyWithImpl<_$PartnerDataImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$PartnerDataImplToJson(
      this,
    );
  }
}

abstract class _PartnerData implements PartnerData {
  const factory _PartnerData(
      {required final String referralCode,
      required final String referralLink,
      final PartnerTier tier,
      final int totalReferrals,
      final int activeReferrals,
      final double totalCommission,
      final double pendingCommission,
      final double commissionRate,
      final List<Referral> referrals}) = _$PartnerDataImpl;

  factory _PartnerData.fromJson(Map<String, dynamic> json) =
      _$PartnerDataImpl.fromJson;

  @override
  String get referralCode;
  @override
  String get referralLink;
  @override
  PartnerTier get tier;
  @override
  int get totalReferrals;
  @override
  int get activeReferrals;
  @override
  double get totalCommission;
  @override
  double get pendingCommission;
  @override
  double get commissionRate;
  @override
  List<Referral> get referrals;

  /// Create a copy of PartnerData
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$PartnerDataImplCopyWith<_$PartnerDataImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
