// To parse this JSON data, do
//
//     final replicateSheetRespModel = replicateSheetRespModelFromJson(jsonString);

import 'dart:convert';

ReplicateSheetRespModel replicateSheetRespModelFromJson(String str) =>
    ReplicateSheetRespModel.fromJson(json.decode(str));

class ReplicateSheetRespModel {
  String? message;
  String? errorOnFailure;
  bool? isSuccess;
  int? costSimulatorId;

  ReplicateSheetRespModel({
    this.message,
    this.errorOnFailure,
    this.isSuccess,
    this.costSimulatorId,
  });

  factory ReplicateSheetRespModel.fromJson(Map<String, dynamic> json) =>
      ReplicateSheetRespModel(
        message: json["message"],
        errorOnFailure: json["errorOnFailure"],
        isSuccess: json["isSuccess"],
        costSimulatorId: json["costSimulatorID"],
      );
}
