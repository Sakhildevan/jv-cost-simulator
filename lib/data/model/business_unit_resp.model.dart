// To parse this JSON data, do
//
//     final businessUnitRespModel = businessUnitRespModelFromJson(jsonString);

import 'dart:convert';

BusinessUnitRespModel businessUnitRespModelFromJson(String str) =>
    BusinessUnitRespModel.fromJson(json.decode(str));

class BusinessUnitRespModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<BusinessUnit>? businessUnits;

  BusinessUnitRespModel({
    this.isSuccess,
    this.errorOnFailure,
    this.businessUnits,
  });

  factory BusinessUnitRespModel.fromJson(Map<String, dynamic> json) =>
      BusinessUnitRespModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        businessUnits: json["businessUnits"] == null
            ? []
            : List<BusinessUnit>.from(
                json["businessUnits"]!.map((x) => BusinessUnit.fromJson(x))),
      );
}

class BusinessUnit {
  String? businessUnitId;
  String? businessUnitName;

  BusinessUnit({
    this.businessUnitId,
    this.businessUnitName,
  });

  factory BusinessUnit.fromJson(Map<String, dynamic> json) => BusinessUnit(
        businessUnitId: json["businessUnitID"],
        businessUnitName: json["businessUnitName"],
      );
}
