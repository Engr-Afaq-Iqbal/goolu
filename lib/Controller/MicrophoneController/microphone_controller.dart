import 'dart:io';

import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../Utils/utils.dart';

class MicrophoneController extends GetxController {
  FlutterSoundRecorder? recorder;
  bool isRecording = false;
  String? filePath;
  bool isRecorderInitialized = false;
  File? audioFile;

  Future<void> initializeRecorder() async {
    try {
      var status = await Permission.microphone.request();
      if (status.isGranted) {
        await recorder!.openRecorder();

        isRecorderInitialized = true;
        update();
      } else {
        logger.e('Microphone permission denied');

        isRecorderInitialized = false;
        update();
      }
    } catch (e) {
      logger.e('Error initializing recorder: $e');

      isRecorderInitialized = false;
      update();
    }
  }

  Future<void> startRecording() async {
    if (!isRecorderInitialized) {
      logger.e('Recorder is not initialized');
      return;
    }
    try {
      final directory = await getApplicationDocumentsDirectory();
      filePath = p.join(
          directory.path, 'audio_${DateTime.now().millisecondsSinceEpoch}.m4a');

      await recorder!.startRecorder(
        toFile: filePath,
        codec: Codec.aacMP4,
      );

      isRecording = true;
      update();
    } catch (e) {
      logger.e('Error starting recording: $e');
    }
  }

  Future<void> stopRecording() async {
    if (!isRecorderInitialized) {
      logger.e('Recorder is not initialized');
      return;
    }
    try {
      await recorder!.stopRecorder();

      isRecording = false;
      update();
    } catch (e) {
      logger.e('Error stopping recording: $e');
    }
  }

  final FlutterTts flutterTts = FlutterTts();
  Future<void> speak() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.5);
    await flutterTts.speak("note book");
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
