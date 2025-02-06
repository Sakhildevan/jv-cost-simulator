// To parse this JSON data, do
//
//     final newVersionRespModel = newVersionRespModelFromJson(jsonString);

import 'dart:convert';

NewVersionRespModel newVersionRespModelFromJson(String str) =>
    NewVersionRespModel.fromJson(json.decode(str));

String newVersionRespModelToJson(NewVersionRespModel data) =>
    json.encode(data.toJson());

class NewVersionRespModel {
  String? message;
  String? errorOnFailure;
  bool? isSuccess;
  int? costSimulatorId;
  int? revisionNumber;

  NewVersionRespModel({
    this.message,
    this.errorOnFailure,
    this.isSuccess,
    this.costSimulatorId,
    this.revisionNumber,
  });

  factory NewVersionRespModel.fromJson(Map<String, dynamic> json) =>
      NewVersionRespModel(
        message: json["message"],
        errorOnFailure: json["errorOnFailure"],
        isSuccess: json["isSuccess"],
        costSimulatorId: json["costSimulatorID"],
        revisionNumber: json["revisionNumber"],
      );

  Map<String, dynamic> toJson() => {
        "message": message,
        "errorOnFailure": errorOnFailure,
        "isSuccess": isSuccess,
        "costSimulatorID": costSimulatorId,
        "revisionNumber": revisionNumber,
      };
}
