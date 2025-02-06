// To parse this JSON data, do
//
//     final entityModel = entityModelFromJson(jsonString);

import 'dart:convert';

EntityModel entityModelFromJson(String str) =>
    EntityModel.fromJson(json.decode(str));

class EntityModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<EntityListItem>? entityListItems;

  EntityModel({
    this.isSuccess,
    this.errorOnFailure,
    this.entityListItems,
  });

  factory EntityModel.fromJson(Map<String, dynamic> json) => EntityModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        entityListItems: json["entityListItems"] == null
            ? []
            : List<EntityListItem>.from(json["entityListItems"]!
                .map((x) => EntityListItem.fromJson(x))),
      );
}

class EntityListItem {
  int? entityId;
  int? geoLocationId;
  String? entityName;

  EntityListItem({
    this.entityId,
    this.geoLocationId,
    this.entityName,
  });

  factory EntityListItem.fromJson(Map<String, dynamic> json) => EntityListItem(
        entityId: json["entityID"],
        geoLocationId: json["geoLocationID"],
        entityName: json["entityName"],
      );
}
