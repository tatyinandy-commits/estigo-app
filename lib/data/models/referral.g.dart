// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'referral.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ReferralImpl _$$ReferralImplFromJson(Map<String, dynamic> json) =>
    _$ReferralImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      registeredAt: json['registeredAt'] as String,
      invested: (json['invested'] as num?)?.toDouble() ?? 0,
      commission: (json['commission'] as num?)?.toDouble() ?? 0,
      status: $enumDecodeNullable(_$ReferralStatusEnumMap, json['status']) ??
          ReferralStatus.active,
    );

Map<String, dynamic> _$$ReferralImplToJson(_$ReferralImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'registeredAt': instance.registeredAt,
      'invested': instance.invested,
      'commission': instance.commission,
      'status': _$ReferralStatusEnumMap[instance.status]!,
    };

const _$ReferralStatusEnumMap = {
  ReferralStatus.active: 'active',
  ReferralStatus.inactive: 'inactive',
};

_$PartnerDataImpl _$$PartnerDataImplFromJson(Map<String, dynamic> json) =>
    _$PartnerDataImpl(
      referralCode: json['referralCode'] as String,
      referralLink: json['referralLink'] as String,
      tier: $enumDecodeNullable(_$PartnerTierEnumMap, json['tier']) ??
          PartnerTier.bronze,
      totalReferrals: (json['totalReferrals'] as num?)?.toInt() ?? 0,
      activeReferrals: (json['activeReferrals'] as num?)?.toInt() ?? 0,
      totalCommission: (json['totalCommission'] as num?)?.toDouble() ?? 0,
      pendingCommission: (json['pendingCommission'] as num?)?.toDouble() ?? 0,
      commissionRate: (json['commissionRate'] as num?)?.toDouble() ?? 0,
      referrals: (json['referrals'] as List<dynamic>?)
              ?.map((e) => Referral.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const [],
    );

Map<String, dynamic> _$$PartnerDataImplToJson(_$PartnerDataImpl instance) =>
    <String, dynamic>{
      'referralCode': instance.referralCode,
      'referralLink': instance.referralLink,
      'tier': _$PartnerTierEnumMap[instance.tier]!,
      'totalReferrals': instance.totalReferrals,
      'activeReferrals': instance.activeReferrals,
      'totalCommission': instance.totalCommission,
      'pendingCommission': instance.pendingCommission,
      'commissionRate': instance.commissionRate,
      'referrals': instance.referrals,
    };

const _$PartnerTierEnumMap = {
  PartnerTier.bronze: 'Bronze',
  PartnerTier.silver: 'Silver',
  PartnerTier.gold: 'Gold',
  PartnerTier.platinum: 'Platinum',
};
