// To parse this JSON data, do
//
//     final createSimulatorModel = createSimulatorModelFromJson(jsonString);

import 'dart:convert';

CreateSimulatorModel createSimulatorModelFromJson(String str) =>
    CreateSimulatorModel.fromJson(json.decode(str));

String createSimulatorModelToJson(CreateSimulatorModel data) =>
    json.encode(data.toJson());

class CreateSimulatorModel {
  String? message;
  String? errorOnFailure;
  bool? isSuccess;
  int? costSimulatorId;

  CreateSimulatorModel({
    this.message,
    this.errorOnFailure,
    this.isSuccess,
    this.costSimulatorId,
  });

  factory CreateSimulatorModel.fromJson(Map<String, dynamic> json) =>
      CreateSimulatorModel(
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
