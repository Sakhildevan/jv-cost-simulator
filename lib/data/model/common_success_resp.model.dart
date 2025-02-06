// To parse this JSON data, do
//
//     final commonSuccessRespModel = commonSuccessRespModelFromJson(jsonString);

import 'dart:convert';

CommonSuccessRespModel commonSuccessRespModelFromJson(String str) =>
    CommonSuccessRespModel.fromJson(json.decode(str));

String commonSuccessRespModelToJson(CommonSuccessRespModel data) =>
    json.encode(data.toJson());

class CommonSuccessRespModel {
  String? message;
  String? errorOnFailure;
  bool? isSuccess;
  int? costSimulatorId;

  CommonSuccessRespModel({
    this.message,
    this.errorOnFailure,
    this.isSuccess,
    this.costSimulatorId,
  });

  factory CommonSuccessRespModel.fromJson(Map<String, dynamic> json) =>
      CommonSuccessRespModel(
        message: json["message"],
        errorOnFailure: json["errorOnFailure"],
        isSuccess: json["isSuccess"],
        costSimulatorId: json["costSimulatorID"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errorOnFailure": errorOnFailure,
        "isSuccess": isSuccess,
        "costSimulatorID": costSimulatorId,
      };
}
