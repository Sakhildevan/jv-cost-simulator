import 'dart:convert';

import 'package:equatable/equatable.dart';

PricingWorkSheetModel pricingWorkSheetModelFromJson(String str) =>
    PricingWorkSheetModel.fromJson(json.decode(str));

class PricingWorkSheetModel extends Equatable {
  final bool? isSuccess;
  final String? errorOnFailure;
  final PricingWorksheetSegmentItems? pricingWorksheetSegmentItems;
  const PricingWorkSheetModel({
    this.isSuccess,
    this.errorOnFailure,
    this.pricingWorksheetSegmentItems,
  });

  factory PricingWorkSheetModel.fromJson(Map<String, dynamic> json) =>
      PricingWorkSheetModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        pricingWorksheetSegmentItems:
            json["pricingWorksheetSegmentItems"] == null
                ? null
                : PricingWorksheetSegmentItems.fromJson(
                    json["pricingWorksheetSegmentItems"]),
      );

  @override
  List<Object?> get props => [
        isSuccess,
        errorOnFailure,
        pricingWorksheetSegmentItems,
      ];
  @override
  bool get stringify => true;
}

class PricingWorksheetSegmentItems extends Equatable {
  final String? title;
  final String? month;
  final String? lastupdatedon;
  final String? projectName;
  final String? customer;
  final String? worksheetUrl;
  final String? createdBy;
  final String? createdOn;
  final String? approvedBy;
  final String? approvedOn;
  final String? status;
  final String? sellVolume;
  final PricingWorksheetTableHeadings? pricingWorksheetTableHeadings;
  final PricingWorksheetSubTableHeadings? pricingWorksheetSubTableHeadings;
  final Calculatedshelfprice? calculatedshelfprice;
  final Calculatedshelfprice? retailTaxMargin;
  final Calculatedshelfprice? distributorMargin;
  final Calculatedshelfprice? jvlsellpricediscount;
  final Calculatedshelfprice? netsales;
  final Calculatedshelfprice? costofSales;
  final Calculatedshelfprice? costotal;
  final Calculatedshelfprice? deliveryAndSupplychain;
  final Calculatedshelfprice? delsupplychainTotal;
  final Calculatedshelfprice? grossProfit;
  final Calculatedshelfprice? grosssales;
  final Calculatedshelfprice? grossProfitpercent;
  final Calculatedshelfprice? sellingExpense;
  final Calculatedshelfprice? sellingExpenseTotal;
  final Calculatedshelfprice? operatingProfit;
  final Calculatedshelfprice? operatingProfitpercent;
  final Calculatedshelfprice? broker;
  final Calculatedshelfprice? standardCost;
  final String? customers;
  final String? jvlSubsidiary;

  const PricingWorksheetSegmentItems({
    this.title,
    this.month,
    this.lastupdatedon,
    this.customer,
    this.broker,
    this.projectName,
    this.worksheetUrl,
    this.pricingWorksheetTableHeadings,
    this.pricingWorksheetSubTableHeadings,
    this.calculatedshelfprice,
    this.retailTaxMargin,
    this.distributorMargin,
    this.jvlsellpricediscount,
    this.netsales,
    this.costofSales,
    this.costotal,
    this.deliveryAndSupplychain,
    this.delsupplychainTotal,
    this.grossProfit,
    this.grossProfitpercent,
    this.sellingExpense,
    this.sellingExpenseTotal,
    this.operatingProfit,
    this.operatingProfitpercent,
    this.grosssales,
    this.createdBy,
    this.createdOn,
    this.approvedBy,
    this.approvedOn,
    this.status,
    this.customers,
    this.jvlSubsidiary,
    this.sellVolume,
    this.standardCost,
  });

  factory PricingWorksheetSegmentItems.fromJson(Map<String, dynamic> json) =>
      PricingWorksheetSegmentItems(
        title: json["title"],
        projectName: json["projectname"],
        month: json["month"],
        lastupdatedon: json["lastupdatedon"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"],
        approvedBy: json["approvedBy"],
        approvedOn: json["approvedOn"],
        status: json["status"],
        customer: json["customer"],
        customers: json["customers"],
        jvlSubsidiary: json["jvlSubsidiary"],
        worksheetUrl: json["worksheetUrl"],
        sellVolume: json["sellVolume"],
        pricingWorksheetTableHeadings:
            json["pricingWorksheetTableHeadings"] == null
                ? null
                : PricingWorksheetTableHeadings.fromJson(
                    json["pricingWorksheetTableHeadings"]),
        pricingWorksheetSubTableHeadings:
            json["pricingWorksheetSubTableHeadings"] == null
                ? null
                : PricingWorksheetSubTableHeadings.fromJson(
                    json["pricingWorksheetSubTableHeadings"]),
        calculatedshelfprice: json["calculatedshelfprice"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["calculatedshelfprice"]),
        retailTaxMargin: json["retailTaxMargin"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["retailTaxMargin"]),
        distributorMargin: json["distributorMargin"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["distributorMargin"]),
        grosssales: json["grosssales"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["grosssales"]),
        jvlsellpricediscount: json["jvlsellpricediscount"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["jvlsellpricediscount"]),
        netsales: json["netsales"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["netsales"]),
        costofSales: json["costofSales"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["costofSales"]),
        costotal: json["costotal"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["costotal"]),
        deliveryAndSupplychain: json["deliveryAndSupplychain"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["deliveryAndSupplychain"]),
        delsupplychainTotal: json["delsupplychainTotal"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["delsupplychainTotal"]),
        grossProfit: json["grossProfit"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["grossProfit"]),
        grossProfitpercent: json["grossProfitpercent"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["grossProfitpercent"]),
        sellingExpense: json["sellingExpense"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["sellingExpense"]),
        sellingExpenseTotal: json["sellingExpenseTotal"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["sellingExpenseTotal"]),
        operatingProfit: json["operatingProfit"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["operatingProfit"]),
        operatingProfitpercent: json["operatingProfitpercent"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["operatingProfitpercent"]),
        broker: json["broker"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["broker"]),
        standardCost: json["standardcost"] == null
            ? null
            : Calculatedshelfprice.fromJson(json["standardcost"]),
      );

  @override
  List<Object?> get props => [
        createdBy,
        createdOn,
        approvedBy,
        approvedOn,
        status,
        title,
        projectName,
        month,
        lastupdatedon,
        customer,
        worksheetUrl,
        pricingWorksheetTableHeadings,
        pricingWorksheetSubTableHeadings,
        calculatedshelfprice,
        retailTaxMargin,
        distributorMargin,
        jvlsellpricediscount,
        netsales,
        costofSales,
        costotal,
        deliveryAndSupplychain,
        delsupplychainTotal,
        grossProfit,
        grossProfitpercent,
        sellingExpense,
        sellingExpenseTotal,
        operatingProfit,
        operatingProfitpercent,
        sellVolume,
        broker,
        standardCost,
      ];

  @override
  bool get stringify => true;
}

class Calculatedshelfprice extends Equatable {
  final String? title;
  final List<Datum>? data;

  const Calculatedshelfprice({
    this.title,
    this.data,
  });

  factory Calculatedshelfprice.fromJson(Map<String, dynamic> json) =>
      Calculatedshelfprice(
        title: json["title"],
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
      );

  @override
  List<Object?> get props => [
        title,
        data,
      ];
  @override
  bool get stringify => true;
}

class Datum extends Equatable {
  final String? component;
  final String? componentName;
  final String? valInUsd;
  final bool? isEditable1;
  final String? volLvlUsd;
  final bool? isEditable2;
  final String? packlvlUsd;
  final bool? isEditable3;
  final String? caselvlUsd;
  final bool? isEditable4;
  final String? linklvlUsd;
  final bool? isEditable5;
  final String? vollvlCad;
  final bool? isEditable6;
  final String? packlvlCad;
  final bool? isEditable7;
  final String? caselvlCad;
  final bool? isEditable8;
  final String? linklvlCad;
  final bool? isEditable9;

  const Datum({
    this.component,
    this.componentName,
    this.valInUsd,
    this.isEditable1,
    this.volLvlUsd,
    this.isEditable2,
    this.packlvlUsd,
    this.isEditable3,
    this.caselvlUsd,
    this.isEditable4,
    this.linklvlUsd,
    this.isEditable5,
    this.vollvlCad,
    this.isEditable6,
    this.packlvlCad,
    this.isEditable7,
    this.caselvlCad,
    this.isEditable8,
    this.linklvlCad,
    this.isEditable9,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        component: json["component"],
        componentName: json["componentname"],
        valInUsd: json["valinUsd"],
        isEditable1: json["isEditable1"],
        volLvlUsd: json["vollvlUsd"],
        isEditable2: json["isEditable2"],
        packlvlUsd: json["packlvlUsd"],
        isEditable3: json["isEditable3"],
        caselvlUsd: json["caselvlUsd"],
        isEditable4: json["isEditable4"],
        linklvlUsd: json["linklvlUsd"],
        isEditable5: json["isEditable5"],
        vollvlCad: json["vollvlCad"],
        isEditable6: json["isEditable6"],
        packlvlCad: json["packlvlCad"],
        isEditable7: json["isEditable7"],
        caselvlCad: json["caselvlCad"],
        isEditable8: json["isEditable8"],
        linklvlCad: json["linklvlCad"],
        isEditable9: json["isEditable9"],
      );

  @override
  List<Object?> get props => [
        component,
        componentName,
        valInUsd,
        isEditable1,
        volLvlUsd,
        isEditable2,
        packlvlUsd,
        isEditable3,
        caselvlUsd,
        isEditable4,
        linklvlUsd,
        isEditable5,
        vollvlCad,
        isEditable6,
        packlvlCad,
        isEditable7,
        caselvlCad,
        isEditable8,
        linklvlCad,
        isEditable9,
      ];
  @override
  bool get stringify => true;
}

class PricingWorksheetSubTableHeadings extends Equatable {
  final String? itemNameDescription;
  final String? valueInUsd;
  final String? volumeLevelUsd;
  final String? packageLevelUsd;
  final String? caseLevelUsd;
  final String? linkLevelUsd;
  final String? volumeLevelCad;
  final String? packageLevelCad;
  final String? caseLevelCad;
  final String? linkLevelCad;

  const PricingWorksheetSubTableHeadings({
    this.itemNameDescription,
    this.valueInUsd,
    this.volumeLevelUsd,
    this.packageLevelUsd,
    this.caseLevelUsd,
    this.linkLevelUsd,
    this.volumeLevelCad,
    this.packageLevelCad,
    this.caseLevelCad,
    this.linkLevelCad,
  });

  factory PricingWorksheetSubTableHeadings.fromJson(
          Map<String, dynamic> json) =>
      PricingWorksheetSubTableHeadings(
        itemNameDescription: json["itemNameDescription"],
        valueInUsd: json["valueInUSD"],
        volumeLevelUsd: json["volumeLevelUSD"],
        packageLevelUsd: json["packageLevelUSD"],
        caseLevelUsd: json["caseLevelUSD"],
        linkLevelUsd: json["linkLevelUSD"],
        volumeLevelCad: json["volumeLevelCAD"],
        packageLevelCad: json["packageLevelCAD"],
        caseLevelCad: json["caseLevelCAD"],
        linkLevelCad: json["linkLevelCAD"],
      );

  @override
  List<Object?> get props => [
        itemNameDescription,
        valueInUsd,
        volumeLevelUsd,
        packageLevelUsd,
        caseLevelUsd,
        linkLevelUsd,
        volumeLevelCad,
        packageLevelCad,
        caseLevelCad,
        linkLevelCad,
      ];
  @override
  bool get stringify => true;
}

class PricingWorksheetTableHeadings extends Equatable {
  final String? itemDetailsVolume;
  final String? usdBasis;
  final String? foreignCurrencyCadBasis;

  const PricingWorksheetTableHeadings({
    this.itemDetailsVolume,
    this.usdBasis,
    this.foreignCurrencyCadBasis,
  });

  factory PricingWorksheetTableHeadings.fromJson(Map<String, dynamic> json) =>
      PricingWorksheetTableHeadings(
        itemDetailsVolume: json["itemDetailsVolume"],
        usdBasis: json["usdBasis"],
        foreignCurrencyCadBasis: json["foreignCurrencyCADBasis"],
      );

  @override
  List<Object?> get props => [
        itemDetailsVolume,
        usdBasis,
        foreignCurrencyCadBasis,
      ];

  @override
  bool get stringify => true;
}
