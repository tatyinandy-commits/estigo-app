import 'package:freezed_annotation/freezed_annotation.dart';

part 'user.freezed.dart';
part 'user.g.dart';

enum UserRole {
  @JsonValue('INVESTOR')
  investor,
  @JsonValue('PARTNER')
  partner,
  @JsonValue('ADMIN')
  admin,
}

enum KycStatus {
  @JsonValue('NONE')
  none,
  @JsonValue('PENDING')
  pending,
  @JsonValue('VERIFIED')
  verified,
  @JsonValue('REJECTED')
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
    @JsonKey(name: 'createdAt') required String registeredAt,
    @Default(false) bool emailVerified,
    @Default(false) bool twoFactorEnabled,
    @Default('') String referralCode,
    String? referredBy,
  }) = _User;

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);
}
