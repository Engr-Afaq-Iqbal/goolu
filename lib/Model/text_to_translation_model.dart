// To parse this JSON data, do
//
//     final textToTranslationModel = textToTranslationModelFromJson(jsonString);

import 'dart:convert';

TextToTranslationModel textToTranslationModelFromJson(String str) =>
    TextToTranslationModel.fromJson(json.decode(str));

String textToTranslationModelToJson(TextToTranslationModel data) =>
    json.encode(data.toJson());

class TextToTranslationModel {
  String? result;

  TextToTranslationModel({
    this.result,
  });

  factory TextToTranslationModel.fromJson(Map<String, dynamic> json) =>
      TextToTranslationModel(
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
      };
}
