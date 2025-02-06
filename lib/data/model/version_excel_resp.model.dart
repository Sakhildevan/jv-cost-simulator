// To parse this JSON data, do
//
//     final versionExcelRespModel = versionExcelRespModelFromJson(jsonString);

import 'dart:convert';

VersionExcelRespModel versionExcelRespModelFromJson(String str) =>
    VersionExcelRespModel.fromJson(json.decode(str));

String versionExcelRespModelToJson(VersionExcelRespModel data) =>
    json.encode(data.toJson());

class VersionExcelRespModel {
  bool? isSuccess;
  String? errorOnFailure;
  String? xlSheetUrl;

  VersionExcelRespModel({
    this.isSuccess,
    this.errorOnFailure,
    this.xlSheetUrl,
  });

  factory VersionExcelRespModel.fromJson(Map<String, dynamic> json) =>
      VersionExcelRespModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        xlSheetUrl: json["xlSheetUrl"],
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "errorOnFailure": errorOnFailure,
        "xlSheetUrl": xlSheetUrl,
      };
}
