// To parse this JSON data, do
//
//     final fxLineModel = fxLineModelFromJson(jsonString);

import 'dart:convert';

FxLineModel fxLineModelFromJson(String str) =>
    FxLineModel.fromJson(json.decode(str));

class FxLineModel {
  bool? isSuccess;
  String? errorOnFailure;
  List<Overview>? overviews;
  List<Datum>? data;

  FxLineModel({
    this.isSuccess,
    this.errorOnFailure,
    this.overviews,
    this.data,
  });

  factory FxLineModel.fromJson(Map<String, dynamic> json) => FxLineModel(
        isSuccess: json["isSuccess"],
        errorOnFailure: json["errorOnFailure"],
        overviews: json["overviews"] == null
            ? []
            : List<Overview>.from(
                json["overviews"]!.map(
                  (x) => Overview.fromJson(x),
                ),
              ),
        data: json["data"] == null
            ? []
            : List<Datum>.from(
                json["data"]!.map(
                  (x) => Datum.fromJson(x),
                ),
              ),
      );
}

class Datum {
  List<double>? current;
  List<int>? baseline;

  Datum({
    this.current,
    this.baseline,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        current: json["current"] == null
            ? []
            : List<double>.from(json["current"]!.map((x) => x?.toDouble())),
        baseline: json["baseline"] == null
            ? []
            : List<int>.from(
                json["baseline"]!.map(
                  (x) => x,
                ),
              ),
      );

  Map<String, dynamic> toJson() => {
        "current": current == null
            ? []
            : List<dynamic>.from(
                current!.map(
                  (x) => x,
                ),
              ),
        "baseline": baseline == null
            ? []
            : List<dynamic>.from(
                baseline!.map(
                  (x) => x,
                ),
              ),
      };
}

class Overview {
  String? title;
  String? current;
  String? target;
  XAxis? xAxis;
  YAxis? yAxis;
  CostSimulatorFxCompareTo? costSimulatorFxCompareTo;

  Overview({
    this.title,
    this.current,
    this.target,
    this.xAxis,
    this.yAxis,
    this.costSimulatorFxCompareTo,
  });

  factory Overview.fromJson(Map<String, dynamic> json) => Overview(
        title: json["title"],
        current: json["current"],
        target: json["target"],
        xAxis: json["xAxis"] == null ? null : XAxis.fromJson(json["xAxis"]),
        yAxis: json["yAxis"] == null ? null : YAxis.fromJson(json["yAxis"]),
        costSimulatorFxCompareTo: json["costsimulatorFxcompareTo"] == null
            ? null
            : CostSimulatorFxCompareTo.fromJson(
                json["costsimulatorFxcompareTo"]),
      );
}

class CostSimulatorFxCompareTo {
  String? current;
  String? previous;

  CostSimulatorFxCompareTo({
    this.current,
    this.previous,
  });

  factory CostSimulatorFxCompareTo.fromJson(Map<String, dynamic> json) =>
      CostSimulatorFxCompareTo(
        current: json["current"],
        previous: json["previous"],
      );
}

class XAxis {
  List<String>? label;

  XAxis({
    this.label,
  });

  factory XAxis.fromJson(Map<String, dynamic> json) => XAxis(
        label: json["label"] == null
            ? []
            : List<String>.from(json["label"]!.map((x) => x)),
      );
}

class YAxis {
  String? label;

  YAxis({
    this.label,
  });

  factory YAxis.fromJson(Map<String, dynamic> json) => YAxis(
        label: json["label"],
      );
}
