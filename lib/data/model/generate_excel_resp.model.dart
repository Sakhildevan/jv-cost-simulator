// To parse this JSON data, do
//
//     final generateExcelRespModel = generateExcelRespModelFromJson(jsonString);

import 'dart:convert';

GenerateExcelRespModel generateExcelRespModelFromJson(String str) =>
    GenerateExcelRespModel.fromJson(json.decode(str));

class GenerateExcelRespModel {
  bool? isSuccess;
  String? errorOnFailure;
  String? xlSheetUrl;

  GenerateExcelRespModel({
    this.isSuccess,
    this.errorOnFailure,
    this.xlSheetUrl,
  });

  factory GenerateExcelRespModel.fromJson(Map<String, dynamic> json) =>
      GenerateExcelRespModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        xlSheetUrl: json["xlSheetUrl"],
      );
}
