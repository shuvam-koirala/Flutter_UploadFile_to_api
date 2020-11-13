// To parse this JSON data, do
//
//     final filterPostModel = filterPostModelFromJson(jsonString);

import 'dart:convert';

List<FilterPostModel> filterPostModelFromJson(String str) =>
    List<FilterPostModel>.from(
        json.decode(str).map((x) => FilterPostModel.fromJson(x)));

String filterPostModelToJson(List<FilterPostModel> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FilterPostModel {
  FilterPostModel({
    this.model,
    this.pk,
    this.fields,
  });

  String model;
  int pk;
  Fields fields;

  factory FilterPostModel.fromJson(Map<String, dynamic> json) =>
      FilterPostModel(
        model: json["model"],
        pk: json["pk"],
        fields: Fields.fromJson(json["fields"]),
      );

  Map<String, dynamic> toJson() => {
        "model": model,
        "pk": pk,
        "fields": fields.toJson(),
      };
}

class Fields {
  Fields({
    this.file,
    this.action,
    this.timestamp,
    this.processedImage,
  });

  String file;
  String action;
  DateTime timestamp;
  String processedImage;

  factory Fields.fromJson(Map<String, dynamic> json) => Fields(
        file: json["file"],
        action: json["action"],
        timestamp: DateTime.parse(json["timestamp"]),
        processedImage: json["processed_image"],
      );

  Map<String, dynamic> toJson() => {
        "file": file,
        "action": action,
        "timestamp": timestamp.toIso8601String(),
        "processed_image": processedImage,
      };
}
