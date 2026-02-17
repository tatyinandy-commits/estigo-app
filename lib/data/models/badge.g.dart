// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'badge.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$BadgeImpl _$$BadgeImplFromJson(Map<String, dynamic> json) => _$BadgeImpl(
      id: json['id'] as String,
      name: json['name'] as String,
      nameRu: json['nameRu'] as String,
      description: json['description'] as String,
      icon: json['icon'] as String,
      threshold: (json['threshold'] as num).toDouble(),
      thresholdUnit: json['thresholdUnit'] as String,
      color: json['color'] as String,
    );

Map<String, dynamic> _$$BadgeImplToJson(_$BadgeImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'nameRu': instance.nameRu,
      'description': instance.description,
      'icon': instance.icon,
      'threshold': instance.threshold,
      'thresholdUnit': instance.thresholdUnit,
      'color': instance.color,
    };

_$UserBadgeImpl _$$UserBadgeImplFromJson(Map<String, dynamic> json) =>
    _$UserBadgeImpl(
      badgeId: json['badgeId'] as String,
      earnedAt: json['earnedAt'] as String,
      progress: (json['progress'] as num?)?.toDouble() ?? 0,
    );

Map<String, dynamic> _$$UserBadgeImplToJson(_$UserBadgeImpl instance) =>
    <String, dynamic>{
      'badgeId': instance.badgeId,
      'earnedAt': instance.earnedAt,
      'progress': instance.progress,
    };
