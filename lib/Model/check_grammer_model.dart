// To parse this JSON data, do
//
//     final checkGrammerModel = checkGrammerModelFromJson(jsonString);

import 'dart:convert';

CheckGrammerModel checkGrammerModelFromJson(String str) =>
    CheckGrammerModel.fromJson(json.decode(str));

String checkGrammerModelToJson(CheckGrammerModel data) =>
    json.encode(data.toJson());

class CheckGrammerModel {
  bool? grammar;
  String? result;

  CheckGrammerModel({
    this.grammar,
    this.result,
  });

  factory CheckGrammerModel.fromJson(Map<String, dynamic> json) =>
      CheckGrammerModel(
        grammar: json["grammar"],
        result: json["result"],
      );

  Map<String, dynamic> toJson() => {
        "grammar": grammar,
        "result": result,
      };
}
