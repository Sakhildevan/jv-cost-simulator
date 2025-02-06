// To parse this JSON data, do
//
//     final saveCommentModel = saveCommentModelFromJson(jsonString);

import 'dart:convert';

SaveCommentModel saveCommentModelFromJson(String str) =>
    SaveCommentModel.fromJson(json.decode(str));

class SaveCommentModel {
  String? message;
  String? errorOnFailure;
  bool? isSuccess;
  int? costSimulatorId;

  SaveCommentModel({
    this.message,
    this.errorOnFailure,
    this.isSuccess,
    this.costSimulatorId,
  });

  factory SaveCommentModel.fromJson(Map<String, dynamic> json) =>
      SaveCommentModel(
        message: json["message"],
        errorOnFailure: json["errorOnFailure"],
        isSuccess: json["isSuccess"],
        costSimulatorId: json["costSimulatorID"],
      );
}
