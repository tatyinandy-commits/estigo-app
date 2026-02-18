// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'admin.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

AdminUser _$AdminUserFromJson(Map<String, dynamic> json) {
  return _AdminUser.fromJson(json);
}

/// @nodoc
mixin _$AdminUser {
  String get id => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  double get balance => throw _privateConstructorUsedError;
  String get role => throw _privateConstructorUsedError;
  List<String> get roles => throw _privateConstructorUsedError;
  String get kycStatus => throw _privateConstructorUsedError;
  bool get emailVerified => throw _privateConstructorUsedError;
  String? get lockedUntil => throw _privateConstructorUsedError;
  String? get locale => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  @JsonKey(name: '_count')
  AdminUserCount? get count => throw _privateConstructorUsedError;

  /// Serializes this AdminUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminUserCopyWith<AdminUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminUserCopyWith<$Res> {
  factory $AdminUserCopyWith(AdminUser value, $Res Function(AdminUser) then) =
      _$AdminUserCopyWithImpl<$Res, AdminUser>;
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      double balance,
      String role,
      List<String> roles,
      String kycStatus,
      bool emailVerified,
      String? lockedUntil,
      String? locale,
      String createdAt,
      @JsonKey(name: '_count') AdminUserCount? count});

  $AdminUserCountCopyWith<$Res>? get count;
}

/// @nodoc
class _$AdminUserCopyWithImpl<$Res, $Val extends AdminUser>
    implements $AdminUserCopyWith<$Res> {
  _$AdminUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? balance = null,
    Object? role = null,
    Object? roles = null,
    Object? kycStatus = null,
    Object? emailVerified = null,
    Object? lockedUntil = freezed,
    Object? locale = freezed,
    Object? createdAt = null,
    Object? count = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _value.roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      kycStatus: null == kycStatus
          ? _value.kycStatus
          : kycStatus // ignore: cast_nullable_to_non_nullable
              as String,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      lockedUntil: freezed == lockedUntil
          ? _value.lockedUntil
          : lockedUntil // ignore: cast_nullable_to_non_nullable
              as String?,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as AdminUserCount?,
    ) as $Val);
  }

  /// Create a copy of AdminUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AdminUserCountCopyWith<$Res>? get count {
    if (_value.count == null) {
      return null;
    }

    return $AdminUserCountCopyWith<$Res>(_value.count!, (value) {
      return _then(_value.copyWith(count: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AdminUserImplCopyWith<$Res>
    implements $AdminUserCopyWith<$Res> {
  factory _$$AdminUserImplCopyWith(
          _$AdminUserImpl value, $Res Function(_$AdminUserImpl) then) =
      __$$AdminUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String email,
      String name,
      double balance,
      String role,
      List<String> roles,
      String kycStatus,
      bool emailVerified,
      String? lockedUntil,
      String? locale,
      String createdAt,
      @JsonKey(name: '_count') AdminUserCount? count});

  @override
  $AdminUserCountCopyWith<$Res>? get count;
}

/// @nodoc
class __$$AdminUserImplCopyWithImpl<$Res>
    extends _$AdminUserCopyWithImpl<$Res, _$AdminUserImpl>
    implements _$$AdminUserImplCopyWith<$Res> {
  __$$AdminUserImplCopyWithImpl(
      _$AdminUserImpl _value, $Res Function(_$AdminUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? email = null,
    Object? name = null,
    Object? balance = null,
    Object? role = null,
    Object? roles = null,
    Object? kycStatus = null,
    Object? emailVerified = null,
    Object? lockedUntil = freezed,
    Object? locale = freezed,
    Object? createdAt = null,
    Object? count = freezed,
  }) {
    return _then(_$AdminUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      balance: null == balance
          ? _value.balance
          : balance // ignore: cast_nullable_to_non_nullable
              as double,
      role: null == role
          ? _value.role
          : role // ignore: cast_nullable_to_non_nullable
              as String,
      roles: null == roles
          ? _value._roles
          : roles // ignore: cast_nullable_to_non_nullable
              as List<String>,
      kycStatus: null == kycStatus
          ? _value.kycStatus
          : kycStatus // ignore: cast_nullable_to_non_nullable
              as String,
      emailVerified: null == emailVerified
          ? _value.emailVerified
          : emailVerified // ignore: cast_nullable_to_non_nullable
              as bool,
      lockedUntil: freezed == lockedUntil
          ? _value.lockedUntil
          : lockedUntil // ignore: cast_nullable_to_non_nullable
              as String?,
      locale: freezed == locale
          ? _value.locale
          : locale // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as AdminUserCount?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminUserImpl implements _AdminUser {
  const _$AdminUserImpl(
      {required this.id,
      required this.email,
      required this.name,
      this.balance = 0,
      this.role = 'INVESTOR',
      final List<String> roles = const [],
      this.kycStatus = 'NONE',
      this.emailVerified = false,
      this.lockedUntil,
      this.locale,
      required this.createdAt,
      @JsonKey(name: '_count') this.count})
      : _roles = roles;

  factory _$AdminUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminUserImplFromJson(json);

  @override
  final String id;
  @override
  final String email;
  @override
  final String name;
  @override
  @JsonKey()
  final double balance;
  @override
  @JsonKey()
  final String role;
  final List<String> _roles;
  @override
  @JsonKey()
  List<String> get roles {
    if (_roles is EqualUnmodifiableListView) return _roles;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(_roles);
  }

  @override
  @JsonKey()
  final String kycStatus;
  @override
  @JsonKey()
  final bool emailVerified;
  @override
  final String? lockedUntil;
  @override
  final String? locale;
  @override
  final String createdAt;
  @override
  @JsonKey(name: '_count')
  final AdminUserCount? count;

  @override
  String toString() {
    return 'AdminUser(id: $id, email: $email, name: $name, balance: $balance, role: $role, roles: $roles, kycStatus: $kycStatus, emailVerified: $emailVerified, lockedUntil: $lockedUntil, locale: $locale, createdAt: $createdAt, count: $count)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.balance, balance) || other.balance == balance) &&
            (identical(other.role, role) || other.role == role) &&
            const DeepCollectionEquality().equals(other._roles, _roles) &&
            (identical(other.kycStatus, kycStatus) ||
                other.kycStatus == kycStatus) &&
            (identical(other.emailVerified, emailVerified) ||
                other.emailVerified == emailVerified) &&
            (identical(other.lockedUntil, lockedUntil) ||
                other.lockedUntil == lockedUntil) &&
            (identical(other.locale, locale) || other.locale == locale) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.count, count) || other.count == count));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      email,
      name,
      balance,
      role,
      const DeepCollectionEquality().hash(_roles),
      kycStatus,
      emailVerified,
      lockedUntil,
      locale,
      createdAt,
      count);

  /// Create a copy of AdminUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminUserImplCopyWith<_$AdminUserImpl> get copyWith =>
      __$$AdminUserImplCopyWithImpl<_$AdminUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminUserImplToJson(
      this,
    );
  }
}

abstract class _AdminUser implements AdminUser {
  const factory _AdminUser(
      {required final String id,
      required final String email,
      required final String name,
      final double balance,
      final String role,
      final List<String> roles,
      final String kycStatus,
      final bool emailVerified,
      final String? lockedUntil,
      final String? locale,
      required final String createdAt,
      @JsonKey(name: '_count') final AdminUserCount? count}) = _$AdminUserImpl;

  factory _AdminUser.fromJson(Map<String, dynamic> json) =
      _$AdminUserImpl.fromJson;

  @override
  String get id;
  @override
  String get email;
  @override
  String get name;
  @override
  double get balance;
  @override
  String get role;
  @override
  List<String> get roles;
  @override
  String get kycStatus;
  @override
  bool get emailVerified;
  @override
  String? get lockedUntil;
  @override
  String? get locale;
  @override
  String get createdAt;
  @override
  @JsonKey(name: '_count')
  AdminUserCount? get count;

  /// Create a copy of AdminUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminUserImplCopyWith<_$AdminUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdminUserCount _$AdminUserCountFromJson(Map<String, dynamic> json) {
  return _AdminUserCount.fromJson(json);
}

/// @nodoc
mixin _$AdminUserCount {
  int get shareOwnerships => throw _privateConstructorUsedError;
  int get transactions => throw _privateConstructorUsedError;

  /// Serializes this AdminUserCount to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminUserCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminUserCountCopyWith<AdminUserCount> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminUserCountCopyWith<$Res> {
  factory $AdminUserCountCopyWith(
          AdminUserCount value, $Res Function(AdminUserCount) then) =
      _$AdminUserCountCopyWithImpl<$Res, AdminUserCount>;
  @useResult
  $Res call({int shareOwnerships, int transactions});
}

/// @nodoc
class _$AdminUserCountCopyWithImpl<$Res, $Val extends AdminUserCount>
    implements $AdminUserCountCopyWith<$Res> {
  _$AdminUserCountCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminUserCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shareOwnerships = null,
    Object? transactions = null,
  }) {
    return _then(_value.copyWith(
      shareOwnerships: null == shareOwnerships
          ? _value.shareOwnerships
          : shareOwnerships // ignore: cast_nullable_to_non_nullable
              as int,
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as int,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminUserCountImplCopyWith<$Res>
    implements $AdminUserCountCopyWith<$Res> {
  factory _$$AdminUserCountImplCopyWith(_$AdminUserCountImpl value,
          $Res Function(_$AdminUserCountImpl) then) =
      __$$AdminUserCountImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({int shareOwnerships, int transactions});
}

/// @nodoc
class __$$AdminUserCountImplCopyWithImpl<$Res>
    extends _$AdminUserCountCopyWithImpl<$Res, _$AdminUserCountImpl>
    implements _$$AdminUserCountImplCopyWith<$Res> {
  __$$AdminUserCountImplCopyWithImpl(
      _$AdminUserCountImpl _value, $Res Function(_$AdminUserCountImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminUserCount
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? shareOwnerships = null,
    Object? transactions = null,
  }) {
    return _then(_$AdminUserCountImpl(
      shareOwnerships: null == shareOwnerships
          ? _value.shareOwnerships
          : shareOwnerships // ignore: cast_nullable_to_non_nullable
              as int,
      transactions: null == transactions
          ? _value.transactions
          : transactions // ignore: cast_nullable_to_non_nullable
              as int,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminUserCountImpl implements _AdminUserCount {
  const _$AdminUserCountImpl({this.shareOwnerships = 0, this.transactions = 0});

  factory _$AdminUserCountImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminUserCountImplFromJson(json);

  @override
  @JsonKey()
  final int shareOwnerships;
  @override
  @JsonKey()
  final int transactions;

  @override
  String toString() {
    return 'AdminUserCount(shareOwnerships: $shareOwnerships, transactions: $transactions)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminUserCountImpl &&
            (identical(other.shareOwnerships, shareOwnerships) ||
                other.shareOwnerships == shareOwnerships) &&
            (identical(other.transactions, transactions) ||
                other.transactions == transactions));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, shareOwnerships, transactions);

  /// Create a copy of AdminUserCount
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminUserCountImplCopyWith<_$AdminUserCountImpl> get copyWith =>
      __$$AdminUserCountImplCopyWithImpl<_$AdminUserCountImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminUserCountImplToJson(
      this,
    );
  }
}

abstract class _AdminUserCount implements AdminUserCount {
  const factory _AdminUserCount(
      {final int shareOwnerships,
      final int transactions}) = _$AdminUserCountImpl;

  factory _AdminUserCount.fromJson(Map<String, dynamic> json) =
      _$AdminUserCountImpl.fromJson;

  @override
  int get shareOwnerships;
  @override
  int get transactions;

  /// Create a copy of AdminUserCount
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminUserCountImplCopyWith<_$AdminUserCountImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AdminStats _$AdminStatsFromJson(Map<String, dynamic> json) {
  return _AdminStats.fromJson(json);
}

/// @nodoc
mixin _$AdminStats {
  int get totalUsers => throw _privateConstructorUsedError;
  int get totalInvestors => throw _privateConstructorUsedError;
  int get totalTransactions => throw _privateConstructorUsedError;
  int get activeP2POrders => throw _privateConstructorUsedError;
  int get pendingPayouts => throw _privateConstructorUsedError;
  double get totalBalance => throw _privateConstructorUsedError;
  double get portfolioValue => throw _privateConstructorUsedError;

  /// Serializes this AdminStats to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AdminStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AdminStatsCopyWith<AdminStats> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AdminStatsCopyWith<$Res> {
  factory $AdminStatsCopyWith(
          AdminStats value, $Res Function(AdminStats) then) =
      _$AdminStatsCopyWithImpl<$Res, AdminStats>;
  @useResult
  $Res call(
      {int totalUsers,
      int totalInvestors,
      int totalTransactions,
      int activeP2POrders,
      int pendingPayouts,
      double totalBalance,
      double portfolioValue});
}

/// @nodoc
class _$AdminStatsCopyWithImpl<$Res, $Val extends AdminStats>
    implements $AdminStatsCopyWith<$Res> {
  _$AdminStatsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AdminStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalUsers = null,
    Object? totalInvestors = null,
    Object? totalTransactions = null,
    Object? activeP2POrders = null,
    Object? pendingPayouts = null,
    Object? totalBalance = null,
    Object? portfolioValue = null,
  }) {
    return _then(_value.copyWith(
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      totalInvestors: null == totalInvestors
          ? _value.totalInvestors
          : totalInvestors // ignore: cast_nullable_to_non_nullable
              as int,
      totalTransactions: null == totalTransactions
          ? _value.totalTransactions
          : totalTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      activeP2POrders: null == activeP2POrders
          ? _value.activeP2POrders
          : activeP2POrders // ignore: cast_nullable_to_non_nullable
              as int,
      pendingPayouts: null == pendingPayouts
          ? _value.pendingPayouts
          : pendingPayouts // ignore: cast_nullable_to_non_nullable
              as int,
      totalBalance: null == totalBalance
          ? _value.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double,
      portfolioValue: null == portfolioValue
          ? _value.portfolioValue
          : portfolioValue // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AdminStatsImplCopyWith<$Res>
    implements $AdminStatsCopyWith<$Res> {
  factory _$$AdminStatsImplCopyWith(
          _$AdminStatsImpl value, $Res Function(_$AdminStatsImpl) then) =
      __$$AdminStatsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int totalUsers,
      int totalInvestors,
      int totalTransactions,
      int activeP2POrders,
      int pendingPayouts,
      double totalBalance,
      double portfolioValue});
}

/// @nodoc
class __$$AdminStatsImplCopyWithImpl<$Res>
    extends _$AdminStatsCopyWithImpl<$Res, _$AdminStatsImpl>
    implements _$$AdminStatsImplCopyWith<$Res> {
  __$$AdminStatsImplCopyWithImpl(
      _$AdminStatsImpl _value, $Res Function(_$AdminStatsImpl) _then)
      : super(_value, _then);

  /// Create a copy of AdminStats
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? totalUsers = null,
    Object? totalInvestors = null,
    Object? totalTransactions = null,
    Object? activeP2POrders = null,
    Object? pendingPayouts = null,
    Object? totalBalance = null,
    Object? portfolioValue = null,
  }) {
    return _then(_$AdminStatsImpl(
      totalUsers: null == totalUsers
          ? _value.totalUsers
          : totalUsers // ignore: cast_nullable_to_non_nullable
              as int,
      totalInvestors: null == totalInvestors
          ? _value.totalInvestors
          : totalInvestors // ignore: cast_nullable_to_non_nullable
              as int,
      totalTransactions: null == totalTransactions
          ? _value.totalTransactions
          : totalTransactions // ignore: cast_nullable_to_non_nullable
              as int,
      activeP2POrders: null == activeP2POrders
          ? _value.activeP2POrders
          : activeP2POrders // ignore: cast_nullable_to_non_nullable
              as int,
      pendingPayouts: null == pendingPayouts
          ? _value.pendingPayouts
          : pendingPayouts // ignore: cast_nullable_to_non_nullable
              as int,
      totalBalance: null == totalBalance
          ? _value.totalBalance
          : totalBalance // ignore: cast_nullable_to_non_nullable
              as double,
      portfolioValue: null == portfolioValue
          ? _value.portfolioValue
          : portfolioValue // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AdminStatsImpl implements _AdminStats {
  const _$AdminStatsImpl(
      {this.totalUsers = 0,
      this.totalInvestors = 0,
      this.totalTransactions = 0,
      this.activeP2POrders = 0,
      this.pendingPayouts = 0,
      this.totalBalance = 0,
      this.portfolioValue = 0});

  factory _$AdminStatsImpl.fromJson(Map<String, dynamic> json) =>
      _$$AdminStatsImplFromJson(json);

  @override
  @JsonKey()
  final int totalUsers;
  @override
  @JsonKey()
  final int totalInvestors;
  @override
  @JsonKey()
  final int totalTransactions;
  @override
  @JsonKey()
  final int activeP2POrders;
  @override
  @JsonKey()
  final int pendingPayouts;
  @override
  @JsonKey()
  final double totalBalance;
  @override
  @JsonKey()
  final double portfolioValue;

  @override
  String toString() {
    return 'AdminStats(totalUsers: $totalUsers, totalInvestors: $totalInvestors, totalTransactions: $totalTransactions, activeP2POrders: $activeP2POrders, pendingPayouts: $pendingPayouts, totalBalance: $totalBalance, portfolioValue: $portfolioValue)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AdminStatsImpl &&
            (identical(other.totalUsers, totalUsers) ||
                other.totalUsers == totalUsers) &&
            (identical(other.totalInvestors, totalInvestors) ||
                other.totalInvestors == totalInvestors) &&
            (identical(other.totalTransactions, totalTransactions) ||
                other.totalTransactions == totalTransactions) &&
            (identical(other.activeP2POrders, activeP2POrders) ||
                other.activeP2POrders == activeP2POrders) &&
            (identical(other.pendingPayouts, pendingPayouts) ||
                other.pendingPayouts == pendingPayouts) &&
            (identical(other.totalBalance, totalBalance) ||
                other.totalBalance == totalBalance) &&
            (identical(other.portfolioValue, portfolioValue) ||
                other.portfolioValue == portfolioValue));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      totalUsers,
      totalInvestors,
      totalTransactions,
      activeP2POrders,
      pendingPayouts,
      totalBalance,
      portfolioValue);

  /// Create a copy of AdminStats
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AdminStatsImplCopyWith<_$AdminStatsImpl> get copyWith =>
      __$$AdminStatsImplCopyWithImpl<_$AdminStatsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AdminStatsImplToJson(
      this,
    );
  }
}

abstract class _AdminStats implements AdminStats {
  const factory _AdminStats(
      {final int totalUsers,
      final int totalInvestors,
      final int totalTransactions,
      final int activeP2POrders,
      final int pendingPayouts,
      final double totalBalance,
      final double portfolioValue}) = _$AdminStatsImpl;

  factory _AdminStats.fromJson(Map<String, dynamic> json) =
      _$AdminStatsImpl.fromJson;

  @override
  int get totalUsers;
  @override
  int get totalInvestors;
  @override
  int get totalTransactions;
  @override
  int get activeP2POrders;
  @override
  int get pendingPayouts;
  @override
  double get totalBalance;
  @override
  double get portfolioValue;

  /// Create a copy of AdminStats
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AdminStatsImplCopyWith<_$AdminStatsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuditLog _$AuditLogFromJson(Map<String, dynamic> json) {
  return _AuditLog.fromJson(json);
}

/// @nodoc
mixin _$AuditLog {
  String get id => throw _privateConstructorUsedError;
  String? get userId => throw _privateConstructorUsedError;
  String get action => throw _privateConstructorUsedError;
  String? get details => throw _privateConstructorUsedError;
  String? get ip => throw _privateConstructorUsedError;
  String? get userAgent => throw _privateConstructorUsedError;
  String get createdAt => throw _privateConstructorUsedError;
  AuditLogUser? get user => throw _privateConstructorUsedError;

  /// Serializes this AuditLog to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuditLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuditLogCopyWith<AuditLog> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditLogCopyWith<$Res> {
  factory $AuditLogCopyWith(AuditLog value, $Res Function(AuditLog) then) =
      _$AuditLogCopyWithImpl<$Res, AuditLog>;
  @useResult
  $Res call(
      {String id,
      String? userId,
      String action,
      String? details,
      String? ip,
      String? userAgent,
      String createdAt,
      AuditLogUser? user});

  $AuditLogUserCopyWith<$Res>? get user;
}

/// @nodoc
class _$AuditLogCopyWithImpl<$Res, $Val extends AuditLog>
    implements $AuditLogCopyWith<$Res> {
  _$AuditLogCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuditLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? action = null,
    Object? details = freezed,
    Object? ip = freezed,
    Object? userAgent = freezed,
    Object? createdAt = null,
    Object? user = freezed,
  }) {
    return _then(_value.copyWith(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      userAgent: freezed == userAgent
          ? _value.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AuditLogUser?,
    ) as $Val);
  }

  /// Create a copy of AuditLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @pragma('vm:prefer-inline')
  $AuditLogUserCopyWith<$Res>? get user {
    if (_value.user == null) {
      return null;
    }

    return $AuditLogUserCopyWith<$Res>(_value.user!, (value) {
      return _then(_value.copyWith(user: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AuditLogImplCopyWith<$Res>
    implements $AuditLogCopyWith<$Res> {
  factory _$$AuditLogImplCopyWith(
          _$AuditLogImpl value, $Res Function(_$AuditLogImpl) then) =
      __$$AuditLogImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String id,
      String? userId,
      String action,
      String? details,
      String? ip,
      String? userAgent,
      String createdAt,
      AuditLogUser? user});

  @override
  $AuditLogUserCopyWith<$Res>? get user;
}

/// @nodoc
class __$$AuditLogImplCopyWithImpl<$Res>
    extends _$AuditLogCopyWithImpl<$Res, _$AuditLogImpl>
    implements _$$AuditLogImplCopyWith<$Res> {
  __$$AuditLogImplCopyWithImpl(
      _$AuditLogImpl _value, $Res Function(_$AuditLogImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuditLog
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? userId = freezed,
    Object? action = null,
    Object? details = freezed,
    Object? ip = freezed,
    Object? userAgent = freezed,
    Object? createdAt = null,
    Object? user = freezed,
  }) {
    return _then(_$AuditLogImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      userId: freezed == userId
          ? _value.userId
          : userId // ignore: cast_nullable_to_non_nullable
              as String?,
      action: null == action
          ? _value.action
          : action // ignore: cast_nullable_to_non_nullable
              as String,
      details: freezed == details
          ? _value.details
          : details // ignore: cast_nullable_to_non_nullable
              as String?,
      ip: freezed == ip
          ? _value.ip
          : ip // ignore: cast_nullable_to_non_nullable
              as String?,
      userAgent: freezed == userAgent
          ? _value.userAgent
          : userAgent // ignore: cast_nullable_to_non_nullable
              as String?,
      createdAt: null == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String,
      user: freezed == user
          ? _value.user
          : user // ignore: cast_nullable_to_non_nullable
              as AuditLogUser?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuditLogImpl implements _AuditLog {
  const _$AuditLogImpl(
      {required this.id,
      this.userId,
      required this.action,
      this.details,
      this.ip,
      this.userAgent,
      required this.createdAt,
      this.user});

  factory _$AuditLogImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuditLogImplFromJson(json);

  @override
  final String id;
  @override
  final String? userId;
  @override
  final String action;
  @override
  final String? details;
  @override
  final String? ip;
  @override
  final String? userAgent;
  @override
  final String createdAt;
  @override
  final AuditLogUser? user;

  @override
  String toString() {
    return 'AuditLog(id: $id, userId: $userId, action: $action, details: $details, ip: $ip, userAgent: $userAgent, createdAt: $createdAt, user: $user)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuditLogImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.userId, userId) || other.userId == userId) &&
            (identical(other.action, action) || other.action == action) &&
            (identical(other.details, details) || other.details == details) &&
            (identical(other.ip, ip) || other.ip == ip) &&
            (identical(other.userAgent, userAgent) ||
                other.userAgent == userAgent) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.user, user) || other.user == user));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(
      runtimeType, id, userId, action, details, ip, userAgent, createdAt, user);

  /// Create a copy of AuditLog
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuditLogImplCopyWith<_$AuditLogImpl> get copyWith =>
      __$$AuditLogImplCopyWithImpl<_$AuditLogImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuditLogImplToJson(
      this,
    );
  }
}

abstract class _AuditLog implements AuditLog {
  const factory _AuditLog(
      {required final String id,
      final String? userId,
      required final String action,
      final String? details,
      final String? ip,
      final String? userAgent,
      required final String createdAt,
      final AuditLogUser? user}) = _$AuditLogImpl;

  factory _AuditLog.fromJson(Map<String, dynamic> json) =
      _$AuditLogImpl.fromJson;

  @override
  String get id;
  @override
  String? get userId;
  @override
  String get action;
  @override
  String? get details;
  @override
  String? get ip;
  @override
  String? get userAgent;
  @override
  String get createdAt;
  @override
  AuditLogUser? get user;

  /// Create a copy of AuditLog
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuditLogImplCopyWith<_$AuditLogImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

AuditLogUser _$AuditLogUserFromJson(Map<String, dynamic> json) {
  return _AuditLogUser.fromJson(json);
}

/// @nodoc
mixin _$AuditLogUser {
  String get id => throw _privateConstructorUsedError;
  String get name => throw _privateConstructorUsedError;
  String get email => throw _privateConstructorUsedError;

  /// Serializes this AuditLogUser to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of AuditLogUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $AuditLogUserCopyWith<AuditLogUser> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AuditLogUserCopyWith<$Res> {
  factory $AuditLogUserCopyWith(
          AuditLogUser value, $Res Function(AuditLogUser) then) =
      _$AuditLogUserCopyWithImpl<$Res, AuditLogUser>;
  @useResult
  $Res call({String id, String name, String email});
}

/// @nodoc
class _$AuditLogUserCopyWithImpl<$Res, $Val extends AuditLogUser>
    implements $AuditLogUserCopyWith<$Res> {
  _$AuditLogUserCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of AuditLogUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
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
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$AuditLogUserImplCopyWith<$Res>
    implements $AuditLogUserCopyWith<$Res> {
  factory _$$AuditLogUserImplCopyWith(
          _$AuditLogUserImpl value, $Res Function(_$AuditLogUserImpl) then) =
      __$$AuditLogUserImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({String id, String name, String email});
}

/// @nodoc
class __$$AuditLogUserImplCopyWithImpl<$Res>
    extends _$AuditLogUserCopyWithImpl<$Res, _$AuditLogUserImpl>
    implements _$$AuditLogUserImplCopyWith<$Res> {
  __$$AuditLogUserImplCopyWithImpl(
      _$AuditLogUserImpl _value, $Res Function(_$AuditLogUserImpl) _then)
      : super(_value, _then);

  /// Create a copy of AuditLogUser
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = null,
    Object? name = null,
    Object? email = null,
  }) {
    return _then(_$AuditLogUserImpl(
      id: null == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String,
      name: null == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String,
      email: null == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AuditLogUserImpl implements _AuditLogUser {
  const _$AuditLogUserImpl(
      {required this.id, required this.name, required this.email});

  factory _$AuditLogUserImpl.fromJson(Map<String, dynamic> json) =>
      _$$AuditLogUserImplFromJson(json);

  @override
  final String id;
  @override
  final String name;
  @override
  final String email;

  @override
  String toString() {
    return 'AuditLogUser(id: $id, name: $name, email: $email)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AuditLogUserImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.email, email) || other.email == email));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, email);

  /// Create a copy of AuditLogUser
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$AuditLogUserImplCopyWith<_$AuditLogUserImpl> get copyWith =>
      __$$AuditLogUserImplCopyWithImpl<_$AuditLogUserImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AuditLogUserImplToJson(
      this,
    );
  }
}

abstract class _AuditLogUser implements AuditLogUser {
  const factory _AuditLogUser(
      {required final String id,
      required final String name,
      required final String email}) = _$AuditLogUserImpl;

  factory _AuditLogUser.fromJson(Map<String, dynamic> json) =
      _$AuditLogUserImpl.fromJson;

  @override
  String get id;
  @override
  String get name;
  @override
  String get email;

  /// Create a copy of AuditLogUser
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$AuditLogUserImplCopyWith<_$AuditLogUserImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
