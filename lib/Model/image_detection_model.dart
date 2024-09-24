// To parse this JSON data, do
//
//     final imageDetectionModel = imageDetectionModelFromJson(jsonString);

import 'dart:convert';

ImageDetectionModel imageDetectionModelFromJson(String str) =>
    ImageDetectionModel.fromJson(json.decode(str));

String imageDetectionModelToJson(ImageDetectionModel data) =>
    json.encode(data.toJson());

class ImageDetectionModel {
  String? word;
  String? definition;

  ImageDetectionModel({
    this.word,
    this.definition,
  });

  factory ImageDetectionModel.fromJson(Map<String, dynamic> json) =>
      ImageDetectionModel(
        word: json["word"],
        definition: json["definition"],
      );

  Map<String, dynamic> toJson() => {
        "word": word,
        "definition": definition,
      };
}
