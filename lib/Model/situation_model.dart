// To parse this JSON data, do
//
//     final situationModel = situationModelFromJson(jsonString);

import 'dart:convert';

SituationModel situationModelFromJson(String str) =>
    SituationModel.fromJson(json.decode(str));

String situationModelToJson(SituationModel data) => json.encode(data.toJson());

class SituationModel {
  List<Datum>? data;
  String? questions;
  String? dialogue;
  String? titleBot;
  String? titleUser;

  SituationModel({
    this.data,
    this.questions,
    this.dialogue,
    this.titleBot,
    this.titleUser,
  });

  factory SituationModel.fromJson(Map<String, dynamic> json) => SituationModel(
        data: json["data"] == null
            ? []
            : List<Datum>.from(json["data"]!.map((x) => Datum.fromJson(x))),
        questions: json["questions"],
        dialogue: json["dialogue"],
        titleBot: json["title_bot"],
        titleUser: json["title_user"],
      );

  Map<String, dynamic> toJson() => {
        "data": data == null
            ? []
            : List<dynamic>.from(data!.map((x) => x.toJson())),
        "questions": questions,
        "dialogue": dialogue,
        "title_bot": titleBot,
        "title_user": titleUser,
      };
}

class Datum {
  String? question;
  String? answer;

  Datum({
    this.question,
    this.answer,
  });

  factory Datum.fromJson(Map<String, dynamic> json) => Datum(
        question: json["question"],
        answer: json["answer"],
      );

  Map<String, dynamic> toJson() => {
        "question": question,
        "answer": answer,
      };
}
