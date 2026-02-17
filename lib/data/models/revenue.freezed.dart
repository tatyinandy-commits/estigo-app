// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'revenue.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#adding-getters-and-methods-to-our-models');

RevenueBreakdown _$RevenueBreakdownFromJson(Map<String, dynamic> json) {
  return _RevenueBreakdown.fromJson(json);
}

/// @nodoc
mixin _$RevenueBreakdown {
  String get category => throw _privateConstructorUsedError;
  String get categoryRu => throw _privateConstructorUsedError;
  double get amount => throw _privateConstructorUsedError;
  double get percent => throw _privateConstructorUsedError;

  /// Serializes this RevenueBreakdown to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of RevenueBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $RevenueBreakdownCopyWith<RevenueBreakdown> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RevenueBreakdownCopyWith<$Res> {
  factory $RevenueBreakdownCopyWith(
          RevenueBreakdown value, $Res Function(RevenueBreakdown) then) =
      _$RevenueBreakdownCopyWithImpl<$Res, RevenueBreakdown>;
  @useResult
  $Res call(
      {String category, String categoryRu, double amount, double percent});
}

/// @nodoc
class _$RevenueBreakdownCopyWithImpl<$Res, $Val extends RevenueBreakdown>
    implements $RevenueBreakdownCopyWith<$Res> {
  _$RevenueBreakdownCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of RevenueBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? categoryRu = null,
    Object? amount = null,
    Object? percent = null,
  }) {
    return _then(_value.copyWith(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      categoryRu: null == categoryRu
          ? _value.categoryRu
          : categoryRu // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RevenueBreakdownImplCopyWith<$Res>
    implements $RevenueBreakdownCopyWith<$Res> {
  factory _$$RevenueBreakdownImplCopyWith(_$RevenueBreakdownImpl value,
          $Res Function(_$RevenueBreakdownImpl) then) =
      __$$RevenueBreakdownImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String category, String categoryRu, double amount, double percent});
}

/// @nodoc
class __$$RevenueBreakdownImplCopyWithImpl<$Res>
    extends _$RevenueBreakdownCopyWithImpl<$Res, _$RevenueBreakdownImpl>
    implements _$$RevenueBreakdownImplCopyWith<$Res> {
  __$$RevenueBreakdownImplCopyWithImpl(_$RevenueBreakdownImpl _value,
      $Res Function(_$RevenueBreakdownImpl) _then)
      : super(_value, _then);

  /// Create a copy of RevenueBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? category = null,
    Object? categoryRu = null,
    Object? amount = null,
    Object? percent = null,
  }) {
    return _then(_$RevenueBreakdownImpl(
      category: null == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as String,
      categoryRu: null == categoryRu
          ? _value.categoryRu
          : categoryRu // ignore: cast_nullable_to_non_nullable
              as String,
      amount: null == amount
          ? _value.amount
          : amount // ignore: cast_nullable_to_non_nullable
              as double,
      percent: null == percent
          ? _value.percent
          : percent // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RevenueBreakdownImpl implements _RevenueBreakdown {
  const _$RevenueBreakdownImpl(
      {required this.category,
      required this.categoryRu,
      required this.amount,
      required this.percent});

  factory _$RevenueBreakdownImpl.fromJson(Map<String, dynamic> json) =>
      _$$RevenueBreakdownImplFromJson(json);

  @override
  final String category;
  @override
  final String categoryRu;
  @override
  final double amount;
  @override
  final double percent;

  @override
  String toString() {
    return 'RevenueBreakdown(category: $category, categoryRu: $categoryRu, amount: $amount, percent: $percent)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RevenueBreakdownImpl &&
            (identical(other.category, category) ||
                other.category == category) &&
            (identical(other.categoryRu, categoryRu) ||
                other.categoryRu == categoryRu) &&
            (identical(other.amount, amount) || other.amount == amount) &&
            (identical(other.percent, percent) || other.percent == percent));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode =>
      Object.hash(runtimeType, category, categoryRu, amount, percent);

  /// Create a copy of RevenueBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$RevenueBreakdownImplCopyWith<_$RevenueBreakdownImpl> get copyWith =>
      __$$RevenueBreakdownImplCopyWithImpl<_$RevenueBreakdownImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RevenueBreakdownImplToJson(
      this,
    );
  }
}

abstract class _RevenueBreakdown implements RevenueBreakdown {
  const factory _RevenueBreakdown(
      {required final String category,
      required final String categoryRu,
      required final double amount,
      required final double percent}) = _$RevenueBreakdownImpl;

  factory _RevenueBreakdown.fromJson(Map<String, dynamic> json) =
      _$RevenueBreakdownImpl.fromJson;

  @override
  String get category;
  @override
  String get categoryRu;
  @override
  double get amount;
  @override
  double get percent;

  /// Create a copy of RevenueBreakdown
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$RevenueBreakdownImplCopyWith<_$RevenueBreakdownImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

MonthlyIncome _$MonthlyIncomeFromJson(Map<String, dynamic> json) {
  return _MonthlyIncome.fromJson(json);
}

/// @nodoc
mixin _$MonthlyIncome {
  String get month => throw _privateConstructorUsedError;
  String get monthRu => throw _privateConstructorUsedError;
  double get revenue => throw _privateConstructorUsedError;
  double get expenses => throw _privateConstructorUsedError;
  double get netProfit => throw _privateConstructorUsedError;
  double get distributedPerShare => throw _privateConstructorUsedError;

  /// Serializes this MonthlyIncome to a JSON map.
  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;

  /// Create a copy of MonthlyIncome
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  $MonthlyIncomeCopyWith<MonthlyIncome> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MonthlyIncomeCopyWith<$Res> {
  factory $MonthlyIncomeCopyWith(
          MonthlyIncome value, $Res Function(MonthlyIncome) then) =
      _$MonthlyIncomeCopyWithImpl<$Res, MonthlyIncome>;
  @useResult
  $Res call(
      {String month,
      String monthRu,
      double revenue,
      double expenses,
      double netProfit,
      double distributedPerShare});
}

/// @nodoc
class _$MonthlyIncomeCopyWithImpl<$Res, $Val extends MonthlyIncome>
    implements $MonthlyIncomeCopyWith<$Res> {
  _$MonthlyIncomeCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  /// Create a copy of MonthlyIncome
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? monthRu = null,
    Object? revenue = null,
    Object? expenses = null,
    Object? netProfit = null,
    Object? distributedPerShare = null,
  }) {
    return _then(_value.copyWith(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      monthRu: null == monthRu
          ? _value.monthRu
          : monthRu // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as double,
      netProfit: null == netProfit
          ? _value.netProfit
          : netProfit // ignore: cast_nullable_to_non_nullable
              as double,
      distributedPerShare: null == distributedPerShare
          ? _value.distributedPerShare
          : distributedPerShare // ignore: cast_nullable_to_non_nullable
              as double,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$MonthlyIncomeImplCopyWith<$Res>
    implements $MonthlyIncomeCopyWith<$Res> {
  factory _$$MonthlyIncomeImplCopyWith(
          _$MonthlyIncomeImpl value, $Res Function(_$MonthlyIncomeImpl) then) =
      __$$MonthlyIncomeImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {String month,
      String monthRu,
      double revenue,
      double expenses,
      double netProfit,
      double distributedPerShare});
}

/// @nodoc
class __$$MonthlyIncomeImplCopyWithImpl<$Res>
    extends _$MonthlyIncomeCopyWithImpl<$Res, _$MonthlyIncomeImpl>
    implements _$$MonthlyIncomeImplCopyWith<$Res> {
  __$$MonthlyIncomeImplCopyWithImpl(
      _$MonthlyIncomeImpl _value, $Res Function(_$MonthlyIncomeImpl) _then)
      : super(_value, _then);

  /// Create a copy of MonthlyIncome
  /// with the given fields replaced by the non-null parameter values.
  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? month = null,
    Object? monthRu = null,
    Object? revenue = null,
    Object? expenses = null,
    Object? netProfit = null,
    Object? distributedPerShare = null,
  }) {
    return _then(_$MonthlyIncomeImpl(
      month: null == month
          ? _value.month
          : month // ignore: cast_nullable_to_non_nullable
              as String,
      monthRu: null == monthRu
          ? _value.monthRu
          : monthRu // ignore: cast_nullable_to_non_nullable
              as String,
      revenue: null == revenue
          ? _value.revenue
          : revenue // ignore: cast_nullable_to_non_nullable
              as double,
      expenses: null == expenses
          ? _value.expenses
          : expenses // ignore: cast_nullable_to_non_nullable
              as double,
      netProfit: null == netProfit
          ? _value.netProfit
          : netProfit // ignore: cast_nullable_to_non_nullable
              as double,
      distributedPerShare: null == distributedPerShare
          ? _value.distributedPerShare
          : distributedPerShare // ignore: cast_nullable_to_non_nullable
              as double,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$MonthlyIncomeImpl implements _MonthlyIncome {
  const _$MonthlyIncomeImpl(
      {required this.month,
      required this.monthRu,
      required this.revenue,
      required this.expenses,
      required this.netProfit,
      required this.distributedPerShare});

  factory _$MonthlyIncomeImpl.fromJson(Map<String, dynamic> json) =>
      _$$MonthlyIncomeImplFromJson(json);

  @override
  final String month;
  @override
  final String monthRu;
  @override
  final double revenue;
  @override
  final double expenses;
  @override
  final double netProfit;
  @override
  final double distributedPerShare;

  @override
  String toString() {
    return 'MonthlyIncome(month: $month, monthRu: $monthRu, revenue: $revenue, expenses: $expenses, netProfit: $netProfit, distributedPerShare: $distributedPerShare)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$MonthlyIncomeImpl &&
            (identical(other.month, month) || other.month == month) &&
            (identical(other.monthRu, monthRu) || other.monthRu == monthRu) &&
            (identical(other.revenue, revenue) || other.revenue == revenue) &&
            (identical(other.expenses, expenses) ||
                other.expenses == expenses) &&
            (identical(other.netProfit, netProfit) ||
                other.netProfit == netProfit) &&
            (identical(other.distributedPerShare, distributedPerShare) ||
                other.distributedPerShare == distributedPerShare));
  }

  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  int get hashCode => Object.hash(runtimeType, month, monthRu, revenue,
      expenses, netProfit, distributedPerShare);

  /// Create a copy of MonthlyIncome
  /// with the given fields replaced by the non-null parameter values.
  @JsonKey(includeFromJson: false, includeToJson: false)
  @override
  @pragma('vm:prefer-inline')
  _$$MonthlyIncomeImplCopyWith<_$MonthlyIncomeImpl> get copyWith =>
      __$$MonthlyIncomeImplCopyWithImpl<_$MonthlyIncomeImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$MonthlyIncomeImplToJson(
      this,
    );
  }
}

abstract class _MonthlyIncome implements MonthlyIncome {
  const factory _MonthlyIncome(
      {required final String month,
      required final String monthRu,
      required final double revenue,
      required final double expenses,
      required final double netProfit,
      required final double distributedPerShare}) = _$MonthlyIncomeImpl;

  factory _MonthlyIncome.fromJson(Map<String, dynamic> json) =
      _$MonthlyIncomeImpl.fromJson;

  @override
  String get month;
  @override
  String get monthRu;
  @override
  double get revenue;
  @override
  double get expenses;
  @override
  double get netProfit;
  @override
  double get distributedPerShare;

  /// Create a copy of MonthlyIncome
  /// with the given fields replaced by the non-null parameter values.
  @override
  @JsonKey(includeFromJson: false, includeToJson: false)
  _$$MonthlyIncomeImplCopyWith<_$MonthlyIncomeImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
