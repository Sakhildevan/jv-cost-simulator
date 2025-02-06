// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

String createSimRequestModelToJson(CreateSimRequestModel data) =>
    json.encode(data.toJson());

class CreateSimRequestModel {
  String? itemName;
  String? itemDescription;
  String? sellVolume;
  String? productionLocationId;
  String? deliveredTo;
  String? packSize;
  String? packUom;
  String? sellVolumeUnit;
  String? linksPerPack;
  String? packsPerCase;
  String? itemCurrencyId;
  String? sellCurrencyId;
  String? consumerCurrencyId;
  String? plannedExchangeRate;
  String? jvlSubsidiarySale;
  String? customerName;
  String? createdBy;
  String? costSimulatorId;
  String? estSellVolComment;
  String? plannedExchangeRateComment;
  String? businessUnit;
  String? productionCountryId;
  String? productionPlantId;
  String? subsidiaryId;

  CreateSimRequestModel({
    this.itemName,
    this.itemDescription,
    this.sellVolume,
    this.productionLocationId,
    this.deliveredTo,
    this.packSize,
    this.packUom,
    this.sellVolumeUnit,
    this.linksPerPack,
    this.packsPerCase,
    this.itemCurrencyId,
    this.sellCurrencyId,
    this.consumerCurrencyId,
    this.plannedExchangeRate,
    this.jvlSubsidiarySale,
    this.customerName,
    this.createdBy,
    this.costSimulatorId,
    this.estSellVolComment,
    this.plannedExchangeRateComment,
    this.businessUnit,
    this.productionCountryId,
    this.productionPlantId,
    this.subsidiaryId,
  });

  Map<String, dynamic> toJson() => {
        "ItemName": itemName,
        "ItemDescription": itemDescription,
        "SellVolume": sellVolume,
        "ProductionLocationID": productionLocationId,
        "DeliveredTo": deliveredTo,
        "PackSize": packSize,
        "PackUOM": packUom,
        "sellVolumeUnit": sellVolumeUnit,
        "LinksPerPack": linksPerPack,
        "PacksPerCase": packsPerCase,
        "ItemCurrencyID": itemCurrencyId,
        "SellCurrencyID": sellCurrencyId,
        "ConsumerCurrencyID": consumerCurrencyId,
        "PlannedExchangeRate": plannedExchangeRate,
        "JVLSubsidiarySale": jvlSubsidiarySale,
        "CustomerName": customerName,
        "BusinessUnit": businessUnit,
        "CreatedBy": createdBy,
        "CostSimulatorID": costSimulatorId,
        "EstSellVolComment": estSellVolComment,
        "PlannedExchangeRateComment": plannedExchangeRateComment,
        "ProductionCountryID": productionCountryId,
        "ProductionPlantID": productionPlantId,
        "SubsidiaryID": subsidiaryId,
      };

  @override
  String toString() {
    return 'CreateSimRequestModel(itemName: $itemName, itemDescription: $itemDescription, sellVolume: $sellVolume, productionLocationId: $productionLocationId, deliveredTo: $deliveredTo, packSize: $packSize, packUom: $packUom, sellVolumeUnit: $sellVolumeUnit, linksPerPack: $linksPerPack, packsPerCase: $packsPerCase, itemCurrencyId: $itemCurrencyId, sellCurrencyId: $sellCurrencyId, consumerCurrencyId: $consumerCurrencyId, plannedExchangeRate: $plannedExchangeRate, jvlSubsidiarySale: $jvlSubsidiarySale, customerName: $customerName, createdBy: $createdBy, costSimulatorId: $costSimulatorId, estSellVolComment: $estSellVolComment, plannedExchangeRateComment: $plannedExchangeRateComment, businessUnit: $businessUnit, productionCountryId: $productionCountryId, productionPlantId: $productionPlantId, subsidiaryId: $subsidiaryId)';
  }
}
