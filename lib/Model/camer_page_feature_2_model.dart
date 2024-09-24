// To parse this JSON data, do
//
//     final cameraPageFeature2Model = cameraPageFeature2ModelFromJson(jsonString);

import 'dart:convert';

CameraPageFeature2Model cameraPageFeature2ModelFromJson(String str) =>
    CameraPageFeature2Model.fromJson(json.decode(str));

String cameraPageFeature2ModelToJson(CameraPageFeature2Model data) =>
    json.encode(data.toJson());

class CameraPageFeature2Model {
  String? detectedText;

  CameraPageFeature2Model({
    this.detectedText,
  });

  factory CameraPageFeature2Model.fromJson(Map<String, dynamic> json) =>
      CameraPageFeature2Model(
        detectedText: json["detected_text"],
      );

  Map<String, dynamic> toJson() => {
        "detected_text": detectedText,
      };
}
