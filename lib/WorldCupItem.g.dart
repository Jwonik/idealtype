// GENERATED CODE - DO NOT MODIFY BY HAND
part of 'WorldCupItem.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

WorldCupList _$WorldCupListFromJson(Map<String, dynamic> json) {
  return WorldCupList(
    list: (json['list'] as List<dynamic>?)
        ?.map((e) => WorldCupItem.fromJson(e as Map<String, dynamic>))
        .toList(),
  );
}

Map<String, dynamic> _$WorldCupListToJson(WorldCupList instance) =>
    <String, dynamic>{
      'list': instance.list,
    };

WorldCupItem _$WorldCupItemFromJson(Map<String, dynamic> json) {
  return WorldCupItem(
    image: json['image'] as String?,
    name: json['name'] as String?,
  );
}

Map<String, dynamic> _$WorldCupItemToJson(WorldCupItem instance) =>
    <String, dynamic>{
      'image': instance.image,
      'name': instance.name,
    };
