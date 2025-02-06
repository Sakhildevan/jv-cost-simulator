// To parse this JSON data, do
//
//     final versionListModel = versionListModelFromJson(jsonString);

import 'dart:convert';

VersionListModel versionListModelFromJson(String str) =>
    VersionListModel.fromJson(json.decode(str));

class VersionListModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<CostSimulatorRevisionListItem>? costSimulatorRevisionListItems;

  VersionListModel({
    this.isSuccess,
    this.errorOnFailure,
    this.costSimulatorRevisionListItems,
  });

  factory VersionListModel.fromJson(Map<String, dynamic> json) =>
      VersionListModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        costSimulatorRevisionListItems:
            json["costSimulatorRevisionListItems"] == null
                ? []
                : List<CostSimulatorRevisionListItem>.from(
                    json["costSimulatorRevisionListItems"]!
                        .map((x) => CostSimulatorRevisionListItem.fromJson(x))),
      );
}

class CostSimulatorRevisionListItem {
  String? revisionNo;
  String? revisionNoText;
  String? createdon;
  String? grossProfitPrcnt;

  CostSimulatorRevisionListItem({
    this.revisionNo,
    this.revisionNoText,
    this.createdon,
    this.grossProfitPrcnt,
  });

  factory CostSimulatorRevisionListItem.fromJson(Map<String, dynamic> json) =>
      CostSimulatorRevisionListItem(
        revisionNo: json["revisionNo"],
        revisionNoText: json["revisionNoText"],
        createdon: json["createdon"],
        grossProfitPrcnt: json["grossProfitPrcnt"],
      );
}
