// To parse this JSON data, do
//
//     final CommentFieldResponseModel = CommentFieldResponseModelFromJson(jsonString);

import 'dart:convert';

CommentFieldResponseModel commentFieldResponseModelFromJson(String str) =>
    CommentFieldResponseModel.fromJson(json.decode(str));

class CommentFieldResponseModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<CommentField>? commentFields;

  CommentFieldResponseModel({
    this.isSuccess,
    this.errorOnFailure,
    this.commentFields,
  });

  factory CommentFieldResponseModel.fromJson(Map<String, dynamic> json) =>
      CommentFieldResponseModel(
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
