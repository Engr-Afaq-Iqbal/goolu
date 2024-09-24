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
      };

  String? getQuestion(int index) {
    switch (index) {
      case 0:
        return question1;
      case 1:
        return question2;
      case 2:
        return question3;
      case 3:
        return question4;
      case 4:
        return question5;
      case 5:
        return question6;
      case 6:
        return question7;
      case 7:
        return question8;
      case 8:
        return question9;
      case 9:
        return question10;
      default:
        return null;
    }
  }

  String? getAnswer(int index) {
    switch (index) {
      case 0:
        return answer1;
      case 1:
        return answer2;
      case 2:
        return answer3;
      case 3:
        return answer4;
      case 4:
        return answer5;
      case 5:
        return answer6;
      case 6:
        return answer7;
      case 7:
        return answer8;
      case 8:
        return answer9;
      case 9:
        return answer10;
      default:
        return null;
    }
  }
}
