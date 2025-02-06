// To parse this JSON data, do
//
//     final updateFieldSaveRespModel = updateFieldSaveRespModelFromJson(jsonString);

import 'dart:convert';

UpdateFieldSaveRespModel updateFieldSaveRespModelFromJson(String str) =>
    UpdateFieldSaveRespModel.fromJson(json.decode(str));

String updateFieldSaveRespModelToJson(UpdateFieldSaveRespModel data) =>
    json.encode(data.toJson());

class UpdateFieldSaveRespModel {
  String? message;
  String? errorOnFailure;
  bool? isSuccess;
  int? costSimulatorId;

  UpdateFieldSaveRespModel({
    this.message,
    this.errorOnFailure,
    this.isSuccess,
    this.costSimulatorId,
  });

  factory UpdateFieldSaveRespModel.fromJson(Map<String, dynamic> json) =>
      UpdateFieldSaveRespModel(
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
