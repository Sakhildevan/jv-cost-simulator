// To parse this JSON data, do
//
//     final costSimulatorListModel = costSimulatorListModelFromJson(jsonString);

import 'dart:convert';

CostSimulatorListModel costSimulatorListModelFromJson(String str) =>
    CostSimulatorListModel.fromJson(json.decode(str));

class CostSimulatorListModel {
  bool? isSuccess;
  String? errorOnFailure;
  CostSimulatorListSegmentItems? costSimulatorListSegmentItems;

  CostSimulatorListModel({
    this.isSuccess,
    this.errorOnFailure,
    this.costSimulatorListSegmentItems,
  });

  factory CostSimulatorListModel.fromJson(Map<String, dynamic> json) =>
      CostSimulatorListModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        costSimulatorListSegmentItems:
            json["costSimulatorListSegmentItems"] == null
                ? null
                : CostSimulatorListSegmentItems.fromJson(
                    json["costSimulatorListSegmentItems"]),
      );
}

class CostSimulatorListSegmentItems {
  String? title;
  String? subtitle;
  TableHeadings? tableHeadings;
  List<CostSimulatorListItem>? costSimulatorListItems;

  CostSimulatorListSegmentItems({
    this.title,
    this.subtitle,
    this.tableHeadings,
    this.costSimulatorListItems,
  });

  factory CostSimulatorListSegmentItems.fromJson(Map<String, dynamic> json) =>
      CostSimulatorListSegmentItems(
        title: json["title"],
        subtitle: json["subtitle"],
        tableHeadings: json["tableHeadings"] == null
            ? null
            : TableHeadings.fromJson(json["tableHeadings"]),
        costSimulatorListItems: json["costSimulatorListItems"] == null
            ? []
            : List<CostSimulatorListItem>.from(json["costSimulatorListItems"]!
                .map((x) => CostSimulatorListItem.fromJson(x))),
      );
}

class CostSimulatorListItem {
  String? slno;
  String? simulatorId;
  String? itemName;
  String? customerName;
  String? jvlSub;
  String? volume;
  String? sellCurrency;
  String? status;
  String? createdby;
  String? createdon;
  String? approvedby;
  String? approvedon;
  String? businessUnitName;

  CostSimulatorListItem({
    this.slno,
    this.simulatorId,
    this.itemName,
    this.customerName,
    this.jvlSub,
    this.volume,
    this.sellCurrency,
    this.status,
    this.createdby,
    this.createdon,
    this.approvedby,
    this.approvedon,
    this.businessUnitName,
  });

  factory CostSimulatorListItem.fromJson(Map<String, dynamic> json) =>
      CostSimulatorListItem(
        slno: json["slno"],
        simulatorId: json["simulatorID"],
        itemName: json["itemName"],
        customerName: json["customerName"],
        jvlSub: json["jvlSub"],
        volume: json["volume"],
        sellCurrency: json["sellCurrency"],
        status: json["status"],
        createdby: json["createdby"],
        createdon: json["createdon"],
        approvedby: json["approvedby"],
        approvedon: json["approvedon"],
        businessUnitName: json["businessUnitName"],
      );
}

class TableHeadings {
  String? itemName;
  String? custName;
  String? jvlSub;
  String? volume;
  String? sellCorrency;
  String? status;
  String? createdby;
  String? createdon;
  String? approvedby;
  String? approvedon;

  TableHeadings({
    this.itemName,
    this.custName,
    this.jvlSub,
    this.volume,
    this.sellCorrency,
    this.status,
    this.createdby,
    this.createdon,
    this.approvedby,
    this.approvedon,
  });

  factory TableHeadings.fromJson(Map<String, dynamic> json) => TableHeadings(
        itemName: json["itemName"],
        custName: json["custName"],
        jvlSub: json["jvlSub"],
        volume: json["volume"],
        sellCorrency: json["sellCorrency"],
        status: json["status"],
        createdby: json["createdby"],
        createdon: json["createdon"],
        approvedby: json["approvedby"],
        approvedon: json["approvedon"],
      );
}
