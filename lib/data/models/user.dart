import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum UserRole {
  @JsonValue('investor')
  investor,
  @JsonValue('partner')
  partner,
  @JsonValue('admin')
  admin,
}

enum KycStatus {
  @JsonValue('none')
  none,
  @JsonValue('pending')
  pending,
  @JsonValue('verified')
  verified,
  @JsonValue('rejected')
  rejected,
}

@freezed
class User with _$User {
  const factory User({
    required String id,
    required String name,
    required String email,
    @Default('') String phone,
    @Default(KycStatus.none) KycStatus kycStatus,
    @Default(UserRole.investor) UserRole role,
    @Default([]) List<UserRole> roles,
    @Default(0) double balance,
    @Default('') String avatar,
    required String registeredAt,
    @Default(false) bool emailVerified,
    @Default(false) bool twoFactorEnabled,
    @Default('') String referralCode,
    String? referredBy,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
