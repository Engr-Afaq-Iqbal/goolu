// To parse this JSON data, do
//
//     final questionAnswerModel = questionAnswerModelFromJson(jsonString);

import 'dart:convert';

QuestionAnswerModel questionAnswerModelFromJson(String str) =>
    QuestionAnswerModel.fromJson(json.decode(str));

String questionAnswerModelToJson(QuestionAnswerModel data) =>
    json.encode(data.toJson());

class QuestionAnswerModel {
  String? question1;
  String? question2;
  String? question3;
  String? question4;
  String? question5;
  String? question6;
  String? question7;
  String? question8;
  String? question9;
  String? question10;
  String? answer1;
  String? answer2;
  String? answer3;
  String? answer4;
  String? answer5;
  String? answer6;
  String? answer7;
  String? answer8;
  String? answer9;
  String? answer10;
  String? answer11;
  String? answer21;
  String? answer31;
  String? answer41;
  String? answer51;
  String? answer61;
  String? answer71;
  String? answer81;
  String? answer91;
  String? answer101;

  QuestionAnswerModel({
    this.question1,
    this.question2,
    this.question3,
    this.question4,
    this.question5,
    this.question6,
    this.question7,
    this.question8,
    this.question9,
    this.question10,
    this.answer1,
    this.answer2,
    this.answer3,
    this.answer4,
    this.answer5,
    this.answer6,
    this.answer7,
    this.answer8,
    this.answer9,
    this.answer10,
    this.answer11,
    this.answer21,
    this.answer31,
    this.answer41,
    this.answer51,
    this.answer61,
    this.answer71,
    this.answer81,
    this.answer91,
    this.answer101,
  });

  factory QuestionAnswerModel.fromJson(Map<String, dynamic> json) =>
      QuestionAnswerModel(
        question1: json["question1"],
        question2: json["question2"],
        question3: json["question3"],
        question4: json["question4"],
        question5: json["question5"],
        question6: json["question6"],
        question7: json["question7"],
        question8: json["question8"],
        question9: json["question9"],
        question10: json["question10"],
        answer1: json["answer1"],
        answer2: json["answer2"],
        answer3: json["answer3"],
        answer4: json["answer4"],
        answer5: json["answer5"],
        answer6: json["answer6"],
        answer7: json["answer7"],
        answer8: json["answer8"],
        answer9: json["answer9"],
        answer10: json["answer10"],
        answer11: json["answer1_1"],
        answer21: json["answer2_1"],
        answer31: json["answer3_1"],
        answer41: json["answer4_1"],
        answer51: json["answer5_1"],
        answer61: json["answer6_1"],
        answer71: json["answer7_1"],
        answer81: json["answer8_1"],
        answer91: json["answer9_1"],
        answer101: json["answer10_1"],
      );

  Map<String, dynamic> toJson() => {
        "question1": question1,
        "question2": question2,
        "question3": question3,
        "question4": question4,
        "question5": question5,
        "question6": question6,
        "question7": question7,
        "question8": question8,
        "question9": question9,
        "question10": question10,
        "answer1": answer1,
        "answer2": answer2,
        "answer3": answer3,
        "answer4": answer4,
        "answer5": answer5,
        "answer6": answer6,
        "answer7": answer7,
        "answer8": answer8,
        "answer9": answer9,
        "answer10": answer10,
        "answer1_1": answer11,
        "answer2_1": answer21,
        "answer3_1": answer31,
        "answer4_1": answer41,
        "answer5_1": answer51,
        "answer6_1": answer61,
        "answer7_1": answer71,
        "answer8_1": answer81,
        "answer9_1": answer91,
        "answer10_1": answer101,
      };
}
