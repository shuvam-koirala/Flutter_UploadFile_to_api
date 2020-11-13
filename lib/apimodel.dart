import 'package:flutter/material.dart';

// To parse this JSON data, do
//     final filterModel = filterModelFromJson(jsonString);

import 'dart:convert';

List<FilterModel> filterModelFromJson(String str) => List<FilterModel>.from(
    json.decode(str).map((x) => FilterModel.fromJson(x)));

String filterModelToJson(List<FilterModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilterModel {
  FilterModel({
    this.file,
    this.action,
    this.timestamp,
    this.processedImage,
  });

  String file;
  Action action;
  DateTime timestamp;
  String processedImage;

  factory FilterModel.fromJson(Map<String, dynamic> json) => FilterModel(
        file: json["file"],
        action: actionValues.map[json["action"]],
        timestamp: DateTime.parse(json["timestamp"]),
        processedImage: json["processed_image"],
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "action": actionValues.reverse[action],
        "timestamp": timestamp.toIso8601String(),
        "processed_image": processedImage,
      };
}

enum Action { FILTER, FILTER_MOTIVATION }

final actionValues = EnumValues(
    {"FILTER": Action.FILTER, "FILTER_MOTIVATION": Action.FILTER_MOTIVATION});

class EnumValues<T> {
  Map<String, T> map;
  Map<T, String> reverseMap;

  EnumValues(this.map);

  Map<T, String> get reverse {
    if (reverseMap == null) {
      reverseMap = map.map((k, v) => new MapEntry(v, k));
    }
    return reverseMap;
  }
}
