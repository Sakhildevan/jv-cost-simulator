// To parse this JSON data, do
//
//     final stepTwoRequestModel = stepTwoRequestModelFromJson(jsonString);

import 'dart:convert';

import 'package:equatable/equatable.dart';

String stepTwoRequestModelToJson(StepTwoRequestModel data) =>
    json.encode(data.toJson());

// ignore: must_be_immutable
class StepTwoRequestModel extends Equatable {
  String? costSimulatorId;
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
  String? importFees;
  String? localTransport;
  String? foreignSupplyChain;
  String? usDelivery;
  String? usSupplyChain;
  String? expSubsidiarySales;
  String? expConsumerAdv;
  String? expTradeSpent;
  String? expPeopleOthers;
  String? broker;
  List<Map<String, dynamic>>? cosOthers;
  List<Map<String, dynamic>>? sellPriceDiscountOthers;
  List<Map<String, dynamic>>? deliverySupplyChainOthers;
  List<Map<String, dynamic>>? sellingExpensesOthers;
  // String? cosOthers;
  // String? sellPriceDiscountOthers;
  // String? deliverySupplyChainOthers;
  // String? sellingExpensesOthers;
  String? updatedBy;
  String? status;
  String? localTaxVat;
  String? retailerMarginPercent;
  String? retailSellPriceUOM;

  StepTwoRequestModel({
    this.costSimulatorId,
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
    this.importFees,
    this.localTransport,
    this.foreignSupplyChain,
    this.usDelivery,
    this.usSupplyChain,
    this.expSubsidiarySales,
    this.expConsumerAdv,
    this.expTradeSpent,
    this.cosOthers,
    this.expPeopleOthers,
    this.sellPriceDiscountOthers,
    this.deliverySupplyChainOthers,
    this.sellingExpensesOthers,
    this.updatedBy,
    this.status,
    this.localTaxVat,
    this.retailerMarginPercent,
    this.retailSellPriceUOM,
    this.broker,
  });

  Map<String, dynamic> toJson() => {
        "costSimulatorID": costSimulatorId,
        "isTaxIncluded": isTaxIncluded,
        "shelfPriceTax": shelfPriceTax,
        "retailerMargin": retailerMargin,
        "distributorMargin": distributorMargin,
        "sellPrice": sellPrice,
        "sellPriceUSD": sellPriceUsd,
        "promotionalDiscount": promotionalDiscount,
        "customerDiscount": customerDiscount,
        "cosStdCost": cosStdCost,
        "cosMeatPPV": cosMeatPpv,
        "cosMfgVariance": cosMfgVariance,
        "importFees": importFees,
        "localTransport": localTransport,
        "foreignSupplyChain": foreignSupplyChain,
        "usDelivery": usDelivery,
        "usSupplyChain": usSupplyChain,
        "expSubsidiarySales": expSubsidiarySales,
        "expConsumerAdv": expConsumerAdv,
        "expTradeSpent": expTradeSpent,
        "cosOther": cosOthers,
        "expPeopleOthers": expPeopleOthers,
        "SellPriceDiscountsOthers": sellPriceDiscountOthers,
        "DelSupplyChainOthers": deliverySupplyChainOthers,
        "SellingExpenseOthers": sellingExpensesOthers,
        "updatedBy": updatedBy,
        "status": status,
        "localTaxVat": localTaxVat,
        "RetailerMarginPercent": retailerMarginPercent,
        "RetailSellPriceUOM": retailSellPriceUOM,
        "brokerValue": broker,
      };

  @override
  List<Object?> get props => [
        costSimulatorId,
        isTaxIncluded,
        shelfPriceTax,
        retailerMargin,
        distributorMargin,
        sellPrice,
        sellPriceUsd,
        promotionalDiscount,
        customerDiscount,
        cosStdCost,
        cosMeatPpv,
        cosMfgVariance,
        cosOthers,
        importFees,
        localTransport,
        foreignSupplyChain,
        usDelivery,
        usSupplyChain,
        expSubsidiarySales,
        expConsumerAdv,
        expTradeSpent,
        expPeopleOthers,
        sellPriceDiscountOthers,
        deliverySupplyChainOthers,
        sellingExpensesOthers,
        updatedBy,
        status,
        localTaxVat,
        retailerMarginPercent,
        retailSellPriceUOM,
        broker,
      ];
}
