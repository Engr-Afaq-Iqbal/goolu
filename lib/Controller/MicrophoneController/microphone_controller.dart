import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Model/speechToSpeechModel.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Utils/utils.dart';
import '../ExceptionalController/exceptional_controller.dart';

class MicrophoneController extends GetxController {
  String selectedLanguage = 'English';
  String selectedLanguage2 = 'Arabic';
  FlutterSoundRecorder? recorder;
  bool isRecording = false;
  String? filePath;
  bool isRecorderInitialized = false;
  File? audioFile;
  // MicrophoneController micController = Get.find<MicrophoneController>();

  Future<void> initializeRecorder() async {
    try {
      var status = await Permission.microphone.request();
      if (status.isGranted) {
        await recorder!.openRecorder();

        isRecorderInitialized = true;
        update();
      } else {
        debugPrint('Microphone permission denied');

        isRecorderInitialized = false;
        update();
      }
    } catch (e) {
      debugPrint('Error initializing recorder: $e');

      isRecorderInitialized = false;
      update();
    }
  }

  Future<void> startRecording() async {
    if (!isRecorderInitialized) {
      debugPrint('Recorder is not initialized');
      return;
    }
    try {
      final directory = await getApplicationDocumentsDirectory();
      filePath = p.join(
          directory.path, 'audio_${DateTime.now().millisecondsSinceEpoch}.wav');

      await recorder!.startRecorder(
          toFile: filePath,
          codec: Codec.pcm16WAV,
          // codec: Codec.aacADTS, // Use AAC codec for smaller file size
          numChannels: 1, // Record in mono
          bitRate: 4000);

      isRecording = true;
      update();
    } catch (e) {
      logger.e('Error starting recording: $e');
    }
  }

  Future<void> stopRecording() async {
    if (!isRecorderInitialized) {
      debugPrint('Recorder is not initialized');
      return;
    }
    try {
      sendSpeech();
      await recorder!.stopRecorder();

      isRecording = false;
      update();
    } catch (e) {
      logger.e('Error stopping recording: $e');
    }
  }

  final FlutterTts flutterTts = FlutterTts();
  Future<void> speak(String txt) async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak(txt);
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
  }

  SpeechToSpeechModel? speechToSpeechModel;
  Future<bool> sendSpeech() async {
    Map<String, String> files = {};
    files['file'] = '$filePath';

    Map<String, String> field = {
      "language_src": selectedLanguage,
      "language_dst": selectedLanguage2,
    };

    showProgress();
    return await ApiServices.postMultiPartQuery(
            feedUrl: ApiUrls.speechToSpeechApi, fields: field, files: files)
        .then((res) {
      if (res == null) {
        stopProgress();
        return false;
      }
      speechToSpeechModel = speechToSpeechModelFromJson(res);
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
            ApiUrls.speechToSpeechApi,
            'An unknown error occurred, please try again later!',
            stackTrace),
      );
      throw '$error';
    });
  }

  // Future<void> pickAudio() async {
  //   var status = await Permission.microphone.request();
  //   if (status.isGranted) {
  //     FilePickerResult? result = await FilePicker.platform.pickFiles(
  //       type: FileType.audio,
  //     );
  //
  //     if (result != null) {
  //
  //         audioFile = File(result.files.single.path!);
  //     update();
  //     }
  //   } else {
  //     logger.e('Microphone permission denied');
  //   }
  // }
}
