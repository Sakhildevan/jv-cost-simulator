// To parse this JSON data, do
//
//     final profitCenterModel = profitCenterModelFromJson(jsonString);

import 'dart:convert';

ProfitCenterModel profitCenterModelFromJson(String str) =>
    ProfitCenterModel.fromJson(json.decode(str));

class ProfitCenterModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<ProfitCenter>? profitCenters;

  ProfitCenterModel({
    this.isSuccess,
    this.errorOnFailure,
    this.profitCenters,
  });

  factory ProfitCenterModel.fromJson(Map<String, dynamic> json) =>
      ProfitCenterModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        profitCenters: json["profitCenters"] == null
            ? []
            : List<ProfitCenter>.from(
                json["profitCenters"]!.map((x) => ProfitCenter.fromJson(x))),
      );
}

class ProfitCenter {
  String? profitCenterCode;
  String? profitCenterName;

  ProfitCenter({
    this.profitCenterCode,
    this.profitCenterName,
  });

  factory ProfitCenter.fromJson(Map<String, dynamic> json) => ProfitCenter(
        profitCenterCode: json["profitCenterCode"],
        profitCenterName: json["profitCenterName"],
      );
}
