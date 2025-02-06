// To parse this JSON data, do
//
//     final deliveryToRespModel = deliveryToRespModelFromJson(jsonString);

import 'dart:convert';

DeliveryToRespModel deliveryToRespModelFromJson(String str) =>
    DeliveryToRespModel.fromJson(json.decode(str));

class DeliveryToRespModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<DeliveryCountry>? deliveryCountries;

  DeliveryToRespModel({
    this.isSuccess,
    this.errorOnFailure,
    this.deliveryCountries,
  });

  factory DeliveryToRespModel.fromJson(Map<String, dynamic> json) =>
      DeliveryToRespModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        deliveryCountries: json["deliverycountries"] == null
            ? []
            : List<DeliveryCountry>.from(json["deliverycountries"]!
                .map((x) => DeliveryCountry.fromJson(x))),
      );
}

class DeliveryCountry {
  String? deliveryCountryId;
  String? deliveryCountryName;

  DeliveryCountry({
    this.deliveryCountryId,
    this.deliveryCountryName,
  });

  factory DeliveryCountry.fromJson(Map<String, dynamic> json) =>
      DeliveryCountry(
        deliveryCountryId: json["deliveryCountryID"],
        deliveryCountryName: json["deliveryCountryName"],
      );
}
