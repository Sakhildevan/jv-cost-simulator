// To parse this JSON data, do
//
//     final filterMasterModel = filterMasterModelFromJson(jsonString);

import 'dart:convert';

FilterMasterModel filterMasterModelFromJson(String str) =>
    FilterMasterModel.fromJson(json.decode(str));

String filterMasterModelToJson(FilterMasterModel data) =>
    json.encode(data.toJson());

class FilterMasterModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<Date>? dates;

  FilterMasterModel({
    this.isSuccess,
    this.errorOnFailure,
    this.dates,
  });

  FilterMasterModel copyWith({
    bool? isSuccess,
    String? errorOnFailure,
    List<Date>? dates,
  }) =>
      FilterMasterModel(
        isSuccess: isSuccess ?? this.isSuccess,
        errorOnFailure: errorOnFailure ?? this.errorOnFailure,
        dates: dates ?? this.dates,
      );

  factory FilterMasterModel.fromJson(Map<String, dynamic> json) =>
      FilterMasterModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        dates: json["dates"] == null
            ? []
            : List<Date>.from(json["dates"]!.map((x) => Date.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "isSuccess": isSuccess,
        "errorOnFailure": errorOnFailure,
        "dates": dates == null
            ? []
            : List<dynamic>.from(dates!.map((x) => x.toJson())),
      };
}

class Date {
  End? start;
  End? end;

  Date({
    this.start,
    this.end,
  });

  Date copyWith({
    End? start,
    End? end,
  }) =>
      Date(
        start: start ?? this.start,
        end: end ?? this.end,
      );

  factory Date.fromJson(Map<String, dynamic> json) => Date(
        start: json["start"] == null ? null : End.fromJson(json["start"]),
        end: json["end"] == null ? null : End.fromJson(json["end"]),
      );

  Map<String, dynamic> toJson() => {
        "start": start?.toJson(),
        "end": end?.toJson(),
      };
}

class End {
  String? day;
  String? month;
  String? year;

  End({
    this.day,
    this.month,
    this.year,
  });

  End copyWith({
    String? day,
    String? month,
    String? year,
  }) =>
      End(
        day: day ?? this.day,
        month: month ?? this.month,
        year: year ?? this.year,
      );

  factory End.fromJson(Map<String, dynamic> json) => End(
        day: json["day"],
        month: json["month"],
        year: json["year"],
      );

  Map<String, dynamic> toJson() => {
        "day": day,
        "month": month,
        "year": year,
      };
}
