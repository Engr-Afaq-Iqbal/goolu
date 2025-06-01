// To parse this JSON data, do
//
//     final comparingAudioModel = comparingAudioModelFromJson(jsonString);

import 'dart:convert';

ComparingAudioModel comparingAudioModelFromJson(String str) =>
    ComparingAudioModel.fromJson(json.decode(str));

String comparingAudioModelToJson(ComparingAudioModel data) =>
    json.encode(data.toJson());

class ComparingAudioModel {
  String? transcribedText;
  String? comparisonText;
  bool? exactMatch;
  dynamic similarityRatio;
  Details? details;

  ComparingAudioModel({
    this.transcribedText,
    this.comparisonText,
    this.exactMatch,
    this.similarityRatio,
    this.details,
  });

  factory ComparingAudioModel.fromJson(Map<String, dynamic> json) =>
      ComparingAudioModel(
        transcribedText: json["transcribed_text"],
        comparisonText: json["comparison_text"],
        exactMatch: json["exact_match"],
        similarityRatio: json["similarity_ratio"],
        details:
            json["details"] == null ? null : Details.fromJson(json["details"]),
      );

  Map<String, dynamic> toJson() => {
        "transcribed_text": transcribedText,
        "comparison_text": comparisonText,
        "exact_match": exactMatch,
        "similarity_ratio": similarityRatio,
        "details": details?.toJson(),
      };
}

class Details {
  String? normalizedTranscribed;
  String? normalizedComparison;

  Details({
    this.normalizedTranscribed,
    this.normalizedComparison,
  });

  factory Details.fromJson(Map<String, dynamic> json) => Details(
        normalizedTranscribed: json["normalized_transcribed"],
        normalizedComparison: json["normalized_comparison"],
      );

  Map<String, dynamic> toJson() => {
        "normalized_transcribed": normalizedTranscribed,
        "normalized_comparison": normalizedComparison,
      };
}
