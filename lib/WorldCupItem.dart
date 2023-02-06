import 'package:json_annotation/json_annotation.dart';

part 'WorldCupItem.g.dart';

@JsonSerializable()
class WorldCupList {
  List<WorldCupItem>? list;

  WorldCupList({
    required this.list,
  });

  factory WorldCupList.fromJson(Map<String, dynamic> json) =>
      _$WorldCupListFromJson(json);

  Map<String, dynamic> toJson() => _$WorldCupListToJson(this);
}

@JsonSerializable()
class WorldCupItem {
  String? image;
  String? name;

  WorldCupItem({
    required this.image,
    required this.name,
  });

  factory WorldCupItem.fromJson(Map<String, dynamic> json) =>
      _$WorldCupItemFromJson(json);

  Map<String, dynamic> toJson() => _$WorldCupItemToJson(this);
}