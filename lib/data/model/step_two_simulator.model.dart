// To parse this JSON data, do
//
//     final stepTwoSimulatorModel = stepTwoSimulatorModelFromJson(jsonString);

import 'dart:convert';

StepTwoSimulatorModel stepTwoSimulatorModelFromJson(String str) =>
    StepTwoSimulatorModel.fromJson(json.decode(str));

String stepTwoSimulatorModelToJson(StepTwoSimulatorModel data) =>
    json.encode(data.toJson());

class StepTwoSimulatorModel {
  String? message;
  String? errorOnFailure;
  bool? isSuccess;
  int? costSimulatorId;

  StepTwoSimulatorModel({
    this.message,
    this.errorOnFailure,
    this.isSuccess,
    this.costSimulatorId,
  });

  factory StepTwoSimulatorModel.fromJson(Map<String, dynamic> json) =>
      StepTwoSimulatorModel(
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
