// To parse this JSON data, do
//
//     final speechToSpeechModel = speechToSpeechModelFromJson(jsonString);

import 'dart:convert';

SpeechToSpeechModel speechToSpeechModelFromJson(String str) =>
    SpeechToSpeechModel.fromJson(json.decode(str));

String speechToSpeechModelToJson(SpeechToSpeechModel data) =>
    json.encode(data.toJson());

class SpeechToSpeechModel {
  String? translatedText;
  String? languageText;

  SpeechToSpeechModel({
    this.translatedText,
    this.languageText,
  });

  factory SpeechToSpeechModel.fromJson(Map<String, dynamic> json) =>
      SpeechToSpeechModel(
        translatedText: json["translated_text"],
        languageText: json["language_text"],
      );

  Map<String, dynamic> toJson() => {
        "translated_text": translatedText,
        "language_text": languageText,
      };
}
