// To parse this JSON data, do
//
//     final generateAnswersModel = generateAnswersModelFromJson(jsonString);

import 'dart:convert';

GenerateAnswersModel generateAnswersModelFromJson(String str) =>
    GenerateAnswersModel.fromJson(json.decode(str));

String generateAnswersModelToJson(GenerateAnswersModel data) =>
    json.encode(data.toJson());

class GenerateAnswersModel {
  String? option1;
  String? option2;
  String? option3;
  String? option4;
  String? option5;

  GenerateAnswersModel({
    this.option1,
    this.option2,
    this.option3,
    this.option4,
    this.option5,
  });

  factory GenerateAnswersModel.fromJson(Map<String, dynamic> json) =>
      GenerateAnswersModel(
        option1: json["option1"],
        option2: json["option2"],
        option3: json["option3"],
        option4: json["option4"],
        option5: json["option5"],
      );

  Map<String, dynamic> toJson() => {
        "option1": option1,
        "option2": option2,
        "option3": option3,
        "option4": option4,
        "option5": option5,
      };
}
