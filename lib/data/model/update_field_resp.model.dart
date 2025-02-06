// To parse this JSON data, do
//
//     final updateFieldRespModel = updateFieldRespModelFromJson(jsonString);

import 'dart:convert';

UpdateFieldRespModel updateFieldRespModelFromJson(String str) =>
    UpdateFieldRespModel.fromJson(json.decode(str));

class UpdateFieldRespModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<CommentField>? commentFields;

  UpdateFieldRespModel({
    this.isSuccess,
    this.errorOnFailure,
    this.commentFields,
  });

  factory UpdateFieldRespModel.fromJson(Map<String, dynamic> json) =>
      UpdateFieldRespModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        commentFields: json["commentFields"] == null
            ? []
            : List<CommentField>.from(
                json["commentFields"]!.map((x) => CommentField.fromJson(x))),
      );
}

class CommentField {
  int? commentFieldId;
  String? commentFieldName;

  CommentField({
    this.commentFieldId,
    this.commentFieldName,
  });

  factory CommentField.fromJson(Map<String, dynamic> json) => CommentField(
        commentFieldId: json["commentFieldID"],
        commentFieldName: json["commentFieldName"],
      );
}
