// To parse this JSON data, do
//
//     final currencyListModel = currencyListModelFromJson(jsonString);

import 'dart:convert';

CurrencyListModel currencyListModelFromJson(String str) =>
    CurrencyListModel.fromJson(json.decode(str));

class CurrencyListModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<Currency>? currencies;

  CurrencyListModel({
    this.isSuccess,
    this.errorOnFailure,
    this.currencies,
  });

  factory CurrencyListModel.fromJson(Map<String, dynamic> json) =>
      CurrencyListModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        currencies: json["currencies"] == null
            ? []
            : List<Currency>.from(
                json["currencies"]!.map((x) => Currency.fromJson(x))),
      );
}

class Currency {
  String? currencyCode;
  String? currencyName;

  Currency({
    this.currencyCode,
    this.currencyName,
  });

  factory Currency.fromJson(Map<String, dynamic> json) => Currency(
        currencyCode: json["currencyCode"],
        currencyName: json["currencyName"],
      );
}
