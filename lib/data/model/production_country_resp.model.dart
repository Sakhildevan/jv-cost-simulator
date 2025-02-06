// To parse this JSON data, do
//
//     final productionCountryRespModel = productionCountryRespModelFromJson(jsonString);

import 'dart:convert';

ProductionCountryRespModel productionCountryRespModelFromJson(String str) =>
    ProductionCountryRespModel.fromJson(json.decode(str));

class ProductionCountryRespModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<ProductionCountry>? productionCountries;

  ProductionCountryRespModel({
    this.isSuccess,
    this.errorOnFailure,
    this.productionCountries,
  });

  factory ProductionCountryRespModel.fromJson(Map<String, dynamic> json) =>
      ProductionCountryRespModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        productionCountries: json["productionCountries"] == null
            ? []
            : List<ProductionCountry>.from(json["productionCountries"]!
                .map((x) => ProductionCountry.fromJson(x))),
      );
}

class ProductionCountry {
  String? countryId;
  String? countryCode;
  String? countryName;

  ProductionCountry({
    this.countryId,
    this.countryCode,
    this.countryName,
  });

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(
        countryId: json["countryID"],
        countryCode: json["countryCode"],
        countryName: json["countryName"],
      );
}
