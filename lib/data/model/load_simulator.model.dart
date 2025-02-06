// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final loadCostSimulatorResp = loadCostSimulatorRespFromJson(jsonString);

import 'dart:convert';

LoadCostSimulatorModel loadCostSimulatorRespFromJson(String str) =>
    LoadCostSimulatorModel.fromJson(json.decode(str));

class LoadCostSimulatorModel {
  bool? isSuccess;
  String? errorOnFailure;
  String? itemDescription;
  String? productionLocationId;
  String? itemName;
  String? sellVolume;
  String? deliveredTo;
  String? packSize;
  String? packUom;
  String? sellVolumeUnit;
  String? linksPerPack;
  String? packsPerCase;
  String? itemCurrencyId;
  String? customerName;
  String? jvlSubsidiarySale;
  String? sellCurrencyId;
  String? consumerCurrencyId;
  String? plannedExchangeRate;
  String? isTaxIncluded;
  String? shelfPriceTax;
  String? retailerMargin;
  String? distributorMargin;
  String? sellPrice;
  String? sellPriceUsd;
  String? promotionalDiscount;
  String? customerDiscount;
  String? cosStdCost;
  String? cosMeatPpv;
  String? cosMfgVariance;
  // String? cosOthers;
  String? importFees;
  String? localTransport;
  String? foreignSupplyChain;
  String? usDelivery;
  String? usSupplyChain;
  String? expSubsidiarySales;
  String? expConsumerAdv;
  String? expTradeSpent;
  String? expPeopleOthers;
  String? createdDate;
  String? status;
  String? estimatedCellVolumeCmmnt;
  String? plannedExchangeRateCmmnt;
  String? retailMarginonSalesCmmnt;
  String? standardCostCmmnt;
  String? meatPpvCmmnt;
  String? mgfVarianceCmmnt;
  String? estDistributorMarginCmmnt;
  String? importFeesCmmnt;
  String? localTransportCmmnt;
  String? foreignSupplyChainCmmnt;
  String? usDeliveryCmmnt;
  String? usSupplyChainCmmnt;
  String? jvlSellPriceForeignCurrencyCmmnt;
  String? jvlSellPriceUsdCmmnt;
  String? discountsPromoCmmnt;
  String? discountsCustomerProgCmmnt;
  String? subsidiaryTradeCmmnt;
  String? advConsumerCmmnt;
  String? tradeSpendCmmnt;
  String? peopleOthersCmmnt;
  // String? sellPriceDiscountOthers;
  // String? deliverySupplyChainOthers;
  // String? sellingExpensesOthers;
  String? createdBy;
  String? createdOn;
  String? approvedBy;
  String? approvedOn;
  String? businessUnit;
  String? cosOthersCmmnt;
  String? sellPriceDiscountOthersCmmnt;
  String? deliverySupplyChainOthersCmmnt;
  String? sellingExpensesOthersCmmnt;
  List<Other>? cosOther;
  List<Other>? sellPriceDiscountsOthers;
  List<Other>? delSupplyChainOthers;
  List<Other>? sellingExpenseOthers;
  String? taxAndMarginsComment;
  String? costOfSalesComment;
  String? sellPriceAndDiscountComment;
  String? deliveryAndSuppChainComment;
  String? sellingExpensesComment;
  int? othersLimit;
  String? localTaxVat;
  String? productionCountryId;
  String? productionPlantId;
  String? subsidiaryId;
  String? retailerMarginPercent;
  String? retailSellPriceUom;
  String? brokerValue;

  LoadCostSimulatorModel({
    this.isSuccess,
    this.errorOnFailure,
    this.itemDescription,
    this.productionLocationId,
    this.itemName,
    this.sellVolume,
    this.deliveredTo,
    this.packSize,
    this.packUom,
    this.sellVolumeUnit,
    this.linksPerPack,
    this.packsPerCase,
    this.itemCurrencyId,
    this.customerName,
    this.jvlSubsidiarySale,
    this.sellCurrencyId,
    this.consumerCurrencyId,
    this.plannedExchangeRate,
    this.isTaxIncluded,
    this.shelfPriceTax,
    this.retailerMargin,
    this.distributorMargin,
    this.sellPrice,
    this.sellPriceUsd,
    this.promotionalDiscount,
    this.customerDiscount,
    this.cosStdCost,
    this.cosMeatPpv,
    this.cosMfgVariance,
    // this.cosOthers,
    this.importFees,
    this.localTransport,
    this.foreignSupplyChain,
    this.usDelivery,
    this.usSupplyChain,
    this.expSubsidiarySales,
    this.expConsumerAdv,
    this.expTradeSpent,
    this.expPeopleOthers,
    this.createdDate,
    this.status,
    this.estimatedCellVolumeCmmnt,
    this.plannedExchangeRateCmmnt,
    this.retailMarginonSalesCmmnt,
    this.standardCostCmmnt,
    this.meatPpvCmmnt,
    this.mgfVarianceCmmnt,
    this.estDistributorMarginCmmnt,
    this.importFeesCmmnt,
    this.localTransportCmmnt,
    this.foreignSupplyChainCmmnt,
    this.usDeliveryCmmnt,
    this.usSupplyChainCmmnt,
    this.jvlSellPriceForeignCurrencyCmmnt,
    this.jvlSellPriceUsdCmmnt,
    this.discountsPromoCmmnt,
    this.discountsCustomerProgCmmnt,
    this.subsidiaryTradeCmmnt,
    this.advConsumerCmmnt,
    this.tradeSpendCmmnt,
    this.peopleOthersCmmnt,
    // this.sellPriceDiscountOthers,
    // this.deliverySupplyChainOthers,
    // this.sellingExpensesOthers,
    this.createdBy,
    this.createdOn,
    this.approvedBy,
    this.approvedOn,
    this.businessUnit,
    this.cosOthersCmmnt,
    this.sellPriceDiscountOthersCmmnt,
    this.deliverySupplyChainOthersCmmnt,
    this.sellingExpensesOthersCmmnt,
    this.cosOther,
    this.sellPriceDiscountsOthers,
    this.delSupplyChainOthers,
    this.sellingExpenseOthers,
    this.taxAndMarginsComment,
    this.costOfSalesComment,
    this.sellPriceAndDiscountComment,
    this.deliveryAndSuppChainComment,
    this.sellingExpensesComment,
    this.othersLimit,
    this.localTaxVat,
    this.productionCountryId,
    this.productionPlantId,
    this.subsidiaryId,
    this.retailerMarginPercent,
    this.retailSellPriceUom,
    this.brokerValue,
  });

  factory LoadCostSimulatorModel.fromJson(Map<String, dynamic> json) =>
      LoadCostSimulatorModel(
        isSuccess: json["isSuccess"],
        businessUnit: json["businessUnit"],
        errorOnFailure: json["errorOnFailure"],
        itemDescription: json["itemDescription"],
        productionLocationId: json["productionLocationID"],
        itemName: json["itemName"],
        sellVolume: json["sellVolume"],
        deliveredTo: json["deliveredTo"],
        packSize: json["packSize"],
        packUom: json["packUOM"],
        sellVolumeUnit: json["sellVolumeUnit"],
        linksPerPack: json["linksPerPack"],
        packsPerCase: json["packsPerCase"],
        itemCurrencyId: json["itemCurrencyID"],
        customerName: json["customerName"],
        jvlSubsidiarySale: json["jvlSubsidiarySale"],
        sellCurrencyId: json["sellCurrencyID"],
        consumerCurrencyId: json["consumerCurrencyID"],
        plannedExchangeRate: json["plannedExchangeRate"],
        isTaxIncluded: json["isTaxIncluded"],
        shelfPriceTax: json["shelfPriceTax"],
        retailerMargin: json["retailerMargin"],
        distributorMargin: json["distributorMargin"],
        sellPrice: json["sellPrice"],
        sellPriceUsd: json["sellPriceUSD"],
        promotionalDiscount: json["promotionalDiscount"],
        customerDiscount: json["customerDiscount"],
        cosStdCost: json["cosStdCost"],
        cosMeatPpv: json["cosMeatPPV"],
        cosMfgVariance: json["cosMfgVariance"],
        // cosOthers: json["cosOthers"],
        importFees: json["importFees"],
        localTransport: json["localTransport"],
        foreignSupplyChain: json["foreignSupplyChain"],
        usDelivery: json["usDelivery"],
        usSupplyChain: json["usSupplyChain"],
        expSubsidiarySales: json["expSubsidiarySales"],
        expConsumerAdv: json["expConsumerAdv"],
        expTradeSpent: json["expTradeSpent"],
        expPeopleOthers: json["expPeopleOthers"],
        createdDate: json["createdDate"],
        status: json["status"],
        estimatedCellVolumeCmmnt: json["estimatedCellVolumeCmmnt"],
        plannedExchangeRateCmmnt: json["plannedExchangeRateCmmnt"],
        retailMarginonSalesCmmnt: json["retailMarginonSalesCmmnt"],
        standardCostCmmnt: json["standardCostCmmnt"],
        meatPpvCmmnt: json["meatPPVCmmnt"],
        mgfVarianceCmmnt: json["mgfVarianceCmmnt"],
        estDistributorMarginCmmnt: json["estDistributorMarginCmmnt"],
        importFeesCmmnt: json["importFeesCmmnt"],
        localTransportCmmnt: json["localTransportCmmnt"],
        foreignSupplyChainCmmnt: json["foreignSupplyChainCmmnt"],
        usDeliveryCmmnt: json["usDeliveryCmmnt"],
        usSupplyChainCmmnt: json["usSupplyChainCmmnt"],
        jvlSellPriceForeignCurrencyCmmnt:
            json["jvlSellPriceForeignCurrencyCmmnt"],
        jvlSellPriceUsdCmmnt: json["jvlSellPriceUSDCmmnt"],
        discountsPromoCmmnt: json["discountsPromoCmmnt"],
        discountsCustomerProgCmmnt: json["discountsCustomerProgCmmnt"],
        subsidiaryTradeCmmnt: json["subsidiaryTradeCmmnt"],
        advConsumerCmmnt: json["advConsumerCmmnt"],
        tradeSpendCmmnt: json["tradeSpendCmmnt"],
        peopleOthersCmmnt: json["peopleOthersCmmnt"],
        // sellPriceDiscountOthers: json["sellPriceDiscountOthers"],
        // deliverySupplyChainOthers: json["deliverySupplyChainOthers"],
        // sellingExpensesOthers: json["sellingExpensesOthers"],
        createdBy: json["createdBy"],
        createdOn: json["createdOn"],
        approvedBy: json["approvedBy"],
        approvedOn: json["approvedOn"],
        cosOthersCmmnt: json["cosOthersCmmnt"],
        sellPriceDiscountOthersCmmnt: json["sellPriceDiscountOthersCmmnt"],
        deliverySupplyChainOthersCmmnt: json["deliverySupplyChainOthersCmmnt"],
        sellingExpensesOthersCmmnt: json["sellingExpensesOthersCmmnt"],
        cosOther: json["cosOther"] == null
            ? []
            : List<Other>.from(json["cosOther"]!.map((x) => Other.fromJson(x))),
        sellPriceDiscountsOthers: json["sellPriceDiscountsOthers"] == null
            ? []
            : List<Other>.from(json["sellPriceDiscountsOthers"]!
                .map((x) => Other.fromJson(x))),
        delSupplyChainOthers: json["delSupplyChainOthers"] == null
            ? []
            : List<Other>.from(
                json["delSupplyChainOthers"]!.map((x) => Other.fromJson(x))),
        sellingExpenseOthers: json["sellingExpenseOthers"] == null
            ? []
            : List<Other>.from(
                json["sellingExpenseOthers"]!.map((x) => Other.fromJson(x))),
        taxAndMarginsComment: json["taxAndMarginsComment"],
        costOfSalesComment: json["costofSalesComment"],
        sellPriceAndDiscountComment: json["sellPriceandDiscountComment"],
        deliveryAndSuppChainComment: json["deliveryandSuppChainComment"],
        sellingExpensesComment: json["sellingExpensesComment"],
        othersLimit: json["othersLimit"], localTaxVat: json["localTaxVat"],
        productionCountryId: json["productionCountryID"],
        productionPlantId: json["productionPlantID"],
        subsidiaryId: json["subsidiaryID"],
        retailerMarginPercent: json["retailerMarginPercent"],
        retailSellPriceUom: json["retailSellPriceUOM"],
        brokerValue: json["brokerValue"],
      );
}

class Other {
  String? label;
  String? value;

  Other({
    this.label,
    this.value,
  });

  factory Other.fromJson(Map<String, dynamic> json) => Other(
        label: json["label"].toString().trim(),
        value: json["value"].toString().trim(),
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "value": value,
      };

  @override
  String toString() =>
      'Other(label: ${label?.trim()}, value: ${value?.trim()})';
}
