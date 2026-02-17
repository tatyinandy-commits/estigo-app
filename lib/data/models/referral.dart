import 'package:freezed_annotation/freezed_annotation.dart';

part 'referral.freezed.dart';
part 'referral.g.dart';

enum ReferralStatus {
  @JsonValue('active')
  active,
  @JsonValue('inactive')
  inactive,
}

enum PartnerTier {
  @JsonValue('Bronze')
  bronze,
  @JsonValue('Silver')
  silver,
  @JsonValue('Gold')
  gold,
  @JsonValue('Platinum')
  platinum,
}

@freezed
class Referral with _$Referral {
  const factory Referral({
    required String id,
    required String name,
    required String registeredAt,
    @Default(0) double invested,
    @Default(0) double commission,
    @Default(ReferralStatus.active) ReferralStatus status,
  }) = _Referral;

  factory Referral.fromJson(Map<String, dynamic> json) =>
      _$ReferralFromJson(json);
}

@freezed
class PartnerData with _$PartnerData {
  const factory PartnerData({
    required String referralCode,
    required String referralLink,
    @Default(PartnerTier.bronze) PartnerTier tier,
    @Default(0) int totalReferrals,
    @Default(0) int activeReferrals,
    @Default(0) double totalCommission,
    @Default(0) double pendingCommission,
    @Default(0) double commissionRate,
    @Default([]) List<Referral> referrals,
  }) = _PartnerData;

  factory PartnerData.fromJson(Map<String, dynamic> json) =>
      _$PartnerDataFromJson(json);
}
