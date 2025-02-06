// To parse this JSON data, do
//
//     final productionPlantRespModel = productionPlantRespModelFromJson(jsonString);

import 'dart:convert';

ProductionPlantRespModel productionPlantRespModelFromJson(String str) =>
    ProductionPlantRespModel.fromJson(json.decode(str));

class ProductionPlantRespModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<ProductionPlant>? productionPlants;

  ProductionPlantRespModel({
    this.isSuccess,
    this.errorOnFailure,
    this.productionPlants,
  });

  factory ProductionPlantRespModel.fromJson(Map<String, dynamic> json) =>
      ProductionPlantRespModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        productionPlants: json["productionPlants"] == null
            ? []
            : List<ProductionPlant>.from(json["productionPlants"]!
                .map((x) => ProductionPlant.fromJson(x))),
      );
}

class ProductionPlant {
  String? productionPlantId;
  String? productionPlantName;
  String? countryId;

  ProductionPlant({
    this.productionPlantId,
    this.productionPlantName,
    this.countryId,
  });

  factory ProductionPlant.fromJson(Map<String, dynamic> json) =>
      ProductionPlant(
        productionPlantId: json["productionPlantID"],
        productionPlantName: json["productionPlantName"],
        countryId: json["countryID"],
      );
}
