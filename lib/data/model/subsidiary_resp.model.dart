// To parse this JSON data, do
//
//     final subsidiaryRespModel = subsidiaryRespModelFromJson(jsonString);

import 'dart:convert';

SubsidiaryRespModel subsidiaryRespModelFromJson(String str) =>
    SubsidiaryRespModel.fromJson(json.decode(str));

class SubsidiaryRespModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<Subsidiary>? subsidiaries;

  SubsidiaryRespModel({
    this.isSuccess,
    this.errorOnFailure,
    this.subsidiaries,
  });

  factory SubsidiaryRespModel.fromJson(Map<String, dynamic> json) =>
      SubsidiaryRespModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        subsidiaries: json["subsidiaries"] == null
            ? []
            : List<Subsidiary>.from(
                json["subsidiaries"]!.map((x) => Subsidiary.fromJson(x))),
      );
}

class Subsidiary {
  String? subsidiaryId;
  String? subsidiaryName;
  String? countryId;

  Subsidiary({
    this.subsidiaryId,
    this.subsidiaryName,
    this.countryId,
  });

  factory Subsidiary.fromJson(Map<String, dynamic> json) => Subsidiary(
        subsidiaryId: json["subsidiaryID"],
        subsidiaryName: json["subsidiaryName"],
        countryId: json["countryID"],
      );
}
