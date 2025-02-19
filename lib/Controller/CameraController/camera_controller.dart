import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:goolu/View/CameraPage/camera_image_recognition.dart';
import 'package:goolu/View/CameraPage/camera_image_to_text.dart';
import 'package:image_picker/image_picker.dart';

import '../../Model/NavBarModel/nav_bar_model.dart';
import '../../Model/camer_page_feature_2_model.dart';
import '../../Model/image_detection_model.dart';
import '../../Model/text_to_translation_model.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Utils/enums.dart';
import '../../Utils/utils.dart';
import '../ExceptionalController/exceptional_controller.dart';

class CameraController extends GetxController {
  String selectedLanguage = 'Arabic';
  String selectedLanguageCode = 'ar-SA';
  static List<NavBarModel> get viewSingleRobotTabsList => [
        NavBarModel(
          identifier: CameraPageItemEnum.tab1,
          label: 'Image'.tr,
          page: const CameraImageRecognition(),
        ),
        NavBarModel(
          identifier: CameraPageItemEnum.tab2,
          label: 'Text'.tr,
          page: const CameraImageToText(),
        ),
      ];

  final FlutterTts flutterTts = FlutterTts();
  Future<void> speak(String txt) async {
    await flutterTts.setLanguage(selectedLanguageCode);
    logger.i(selectedLanguageCode);
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.speak(txt);
  }

  TextToTranslationModel? textToTranslationModel;
  Future<bool> fetchTranslation({String? text}) async {
    Map<String, String> field = {
      "text": '$text',
      "selected_language": selectedLanguage,
    };
    // showProgress();
    return await ApiServices.postMethod(
      feedUrl:
          "https://feature-1b-text-detection-1028825189557.us-central1.run.app/text-translation",
      fields: field,
    ).then((res) async {
      if (res == null) {
        stopProgress();
        return false;
      }
      textToTranslationModel = textToTranslationModelFromJson(res);
      stopProgress();
      update();
      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST',
            "https://feature3-1028825189557.us-central1.run.app/generate-scenario/",
            error,
            stackTrace),
      );
      throw '$error';
    });
  }

  String? fileName;
  File? file;
  String filePath = 'addFile';
  Future<bool> uploadImageFromGallery() async {
    try {
      //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final imageTemporary = File(image.path);
        filePath = image.name;

        file = imageTemporary;
        fileName = image.name;
        update();
        return true;
      } else {
        showToast('no_image_picked'.tr);
        return false;
      }
    } on PlatformException catch (ex) {
      await ExceptionController().errorAlert(
        errorMsg: '$ex',
        exceptionFormat:
            ApiServices.methodExceptionFormat('Image Picker', '', ex, ''),
      );
      logger.e('Failed to pick Image: $ex');
      return false;
    }
  }

  Future<bool> uploadImageFromCamera() async {
    try {
      //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        final imageTemporary = File(image.path);
        filePath = image.name;

        file = imageTemporary;
        fileName = image.name;
        update();
        return true;
      } else {
        showToast('no_image_picked'.tr);
        return false;
      }
    } on PlatformException catch (ex) {
      await ExceptionController().errorAlert(
        errorMsg: '$ex',
        exceptionFormat:
            ApiServices.methodExceptionFormat('Image Picker', '', ex, ''),
      );
      logger.e('Failed to pick Image: $ex');
      return false;
    }
  }

  String? fileName2;
  File? file2;
  String filePath2 = 'addFile';
  Future<bool> uploadImageFromGallery2() async {
    try {
      //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      XFile? image = await ImagePicker().pickImage(source: ImageSource.gallery);
      if (image != null) {
        final imageTemporary = File(image.path);
        filePath2 = image.name;

        file2 = imageTemporary;
        fileName2 = image.name;
        update();
        return true;
      } else {
        showToast('no_image_picked'.tr);
        return false;
      }
    } on PlatformException catch (ex) {
      await ExceptionController().errorAlert(
        errorMsg: '$ex',
        exceptionFormat:
            ApiServices.methodExceptionFormat('Image Picker', '', ex, ''),
      );
      logger.e('Failed to pick Image: $ex');
      return false;
    }
  }

  Future<bool> uploadImageFromCamera2() async {
    try {
      //final XFile? image = await _picker.pickImage(source: ImageSource.gallery);
      XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
      if (image != null) {
        final imageTemporary = File(image.path);
        filePath2 = image.name;

        file2 = imageTemporary;
        fileName2 = image.name;
        update();
        return true;
      } else {
        showToast('no_image_picked'.tr);
        return false;
      }
    } on PlatformException catch (ex) {
      await ExceptionController().errorAlert(
        errorMsg: '$ex',
        exceptionFormat:
            ApiServices.methodExceptionFormat('Image Picker', '', ex, ''),
      );
      logger.e('Failed to pick Image: $ex');
      return false;
    }
  }

  ImageDetectionModel? imageDetectionModel;
  Future<bool> sendImageFeature1() async {
    Map<String, String> files = {};
    files['file'] = '${file?.path}';

    showProgress();
    return await ApiServices.postMultiPartQuery(
            feedUrl: ApiUrls.imageToTextApi, files: files)
        .then((res) {
      if (res == null) {
        stopProgress();
        return false;
      }
      imageDetectionModel = imageDetectionModelFromJson(res);
      stopProgress();
      update();
      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.imageToTextApi, error, stackTrace),
      );
      throw '$error';
    });
  }

  CameraPageFeature2Model? cameraPageFeature2Model;
  Future<bool> sendImageFeature2() async {
    Map<String, String> files = {};
    files['file'] = '${file2?.path}';

    showProgress();
    return await ApiServices.postMultiPartQuery(
            feedUrl: ApiUrls.detectTextFromImageApi, files: files)
        .then((res) {
      if (res == null) {
        stopProgress();
        return false;
      }
      cameraPageFeature2Model = cameraPageFeature2ModelFromJson(res);
      fetchTranslation(text: cameraPageFeature2Model?.detectedText);
      // stopProgress();
      update();
      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
          'POST',
          ApiUrls.detectTextFromImageApi,
          error,
          stackTrace,
        ),
      );
      throw '$error';
    });
  }
}
