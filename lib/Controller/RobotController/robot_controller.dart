// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';
import 'package:goolu/Model/generate_answers_model.dart';
import 'package:goolu/Model/question_and_answer_model.dart';
import 'package:goolu/Services/storage_sevices.dart';
import 'package:goolu/View/RobotPage/GeneralFeature/robot_general.dart';
import 'package:goolu/View/RobotPage/SituationFeature/robot_situation.dart';
import 'package:goolu/View/RobotPage/TopicFeature/robot_topic.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../Model/NavBarModel/nav_bar_model.dart';
import '../../Model/check_grammer_model.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Utils/enums.dart';
import '../../Utils/utils.dart';
import '../ExceptionalController/exceptional_controller.dart';

class RobotController extends GetxController {
  TextEditingController questionCtrl = TextEditingController();
  TextEditingController answerCtrl = TextEditingController();
  List<String> questionsList = [];
  List<String> answerList = [];
  int questionAnswer = -1;
  bool isSend = false;
  bool showAnswers = false;
  bool micButton = true;
  bool micSubButton = true;
  bool showResult = false;
  // bool playButton = false;
  bool playSubButton = false;
  static List<NavBarModel> get viewSingleRobotTabsList => [
        NavBarModel(
          identifier: ViewSingleItemEnums.feature1,
          label: 'Generic'.tr,
          page: const RobotGeneral(),
        ),
        NavBarModel(
          identifier: ViewSingleItemEnums.feature2,
          label: 'Advanced'.tr,
          page: const RobotTopic(),
        ),
        NavBarModel(
          identifier: ViewSingleItemEnums.feature3,
          label: 'Situation'.tr,
          page: const RobotSituation(),
        ),
      ];

  CheckGrammerModel? checkGrammerModel;
  Future<bool> checkGrammarFunction() async {
    Map<String, String> field = {
      "grammartext": questionCtrl.text,
    };
    showProgress();
    return await ApiServices.postMethod(
      feedUrl: ApiUrls.grammerCheckApi,
      fields: field,
    ).then((res) async {
      if (res == null) {
        stopProgress();
        return false;
      }
      checkGrammerModel = checkGrammerModelFromJson(res);
      if (checkGrammerModel?.grammar == false) {
        showToast('Grammar is correct');
      } else {
        showToast('Grammar is fixed');
        questionCtrl.text = checkGrammerModel?.result ?? questionCtrl.text;
      }
      bool isAnswers = await generateAnswersFunction();
      if (isAnswers == true) {
        stopProgress();
        logger.i('is send = true');
        isSend = true;
      }
      update();
      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.grammerCheckApi, error, stackTrace),
      );
      throw '$error';
    });
  }

  GenerateAnswersModel? generateAnswersModel;
  Future<bool> generateAnswersFunction() async {
    Map<String, String> field = {
      "question": questionCtrl.text,
    };
    return await ApiServices.postMethod(
      feedUrl: ApiUrls.generateAnswers,
      fields: field,
    ).then((res) async {
      if (res == null) {
        stopProgress();
        return false;
      }
      generateAnswersModel = generateAnswersModelFromJson(res);
      showAnswers = true;
      update();
      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.generateAnswers, error, stackTrace),
      );
      // showToast('Try Again!');
      throw '$error';
    });
  }

  TextEditingController topicCtrl = TextEditingController();
  QuestionAnswerModel? questionAnswerModel;

  Future<bool> generateQuestionAndAnswersFunction() async {
    Map<String, String> field = {
      "topic": topicCtrl.text.trim(),
    };
    showProgress();
    return await ApiServices.postMethod(
      feedUrl: ApiUrls.generateQuestionAndAnswers,
      fields: field,
    ).then((res) async {
      if (res == null) {
        stopProgress();
        return false;
      }

      questionAnswerModel = questionAnswerModelFromJson(res);
      stopProgress();
      showAnswers = true;
      update();
      return true;
    }).onError((error, stackTrace) async {
      debugPrint('Error => $error');
      logger.e('StackTrace => $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: '$error',
        exceptionFormat: ApiServices.methodExceptionFormat(
            'POST', ApiUrls.generateQuestionAndAnswers, error, stackTrace),
      );
      // showToast('Try Again!');
      throw '$error';
    });
  }

  bool isRecorderInitialized1 = false;
  bool isRecorderInitialized = false;
  String? filePath;
  FlutterSoundRecorder? recorder;
  bool isRecording = false;
  // stt.SpeechToText _speechToText = stt.SpeechToText();
  bool isListening = false;
  String recordedText = '';

  // Future<void> initializeRecorder() async {
  //   try {
  //     var status = await Permission.microphone.request();
  //     if (status.isGranted) {
  //       await recorder!.openRecorder();
  //
  //       isRecorderInitialized = true;
  //       // isRecorderInitialized = await _speechToText.initialize();
  //       update();
  //     } else {
  //       debugPrint('Microphone permission denied');
  //
  //       isRecorderInitialized = false;
  //       update();
  //     }
  //   } catch (e) {
  //     debugPrint('Error initializing recorder: $e');
  //
  //     isRecorderInitialized = false;
  //     update();
  //   }
  // }

  // Future<void> initializeRecorder() async {
  //   try {
  //     var status = await Permission.microphone.request();
  //     if (status.isGranted) {
  //       await recorder!.openRecorder();
  //       isRecorderInitialized = true;
  //       update();
  //       debugPrint('Recorder initialized successfully');
  //     } else if (status.isDenied) {
  //       debugPrint('Microphone permission denied');
  //       isRecorderInitialized = false;
  //       update();
  //     } else if (status.isPermanentlyDenied) {
  //       debugPrint(
  //           'Microphone permission is permanently denied. Please enable it from settings.');
  //       isRecorderInitialized = false;
  //       update();
  //       // Optionally, you can open app settings:
  //       await openAppSettings();
  //     }
  //   } catch (e) {
  //     debugPrint('Error initializing recorder: $e');
  //     isRecorderInitialized = false;
  //     update();
  //   }
  // }

  // Future<void> initializeRecorder() async {
  //   try {
  //     var status = await Permission.microphone.request();
  //     if (status.isGranted) {
  //       await recorder?.openRecorder();
  //       // await _speechToText.initialize();
  //       isRecorderInitialized = true;
  //       update();
  //     } else {
  //       debugPrint('Microphone permission denied');
  //
  //       isRecorderInitialized = false;
  //       update();
  //     }
  //   } catch (e) {
  //     debugPrint('Error initializing recorder: $e');
  //
  //     isRecorderInitialized = false;
  //     update();
  //   }
  // }

  // Future<void> initializeSpeechToText() async {
  //   try {
  //     bool available = await _speechToText.initialize(
  //       onStatus: (status) => logger.i('Speech status: $status'),
  //       onError: (error) => logger.e('Speech recognition error: $error'),
  //     );
  //     if (available) {
  //       logger.i('SpeechToText initialized successfully.');
  //     } else {
  //       logger.e('SpeechToText initialization failed.');
  //     }
  //   } catch (e) {
  //     logger.e('Error during SpeechToText initialization: $e');
  //   }
  // }

  // Future<void> initializeRecorder() async {
  //   try {
  //     var status = await Permission.microphone.request();
  //     if (status.isGranted) {
  //       await recorder!.openRecorder();
  //       isRecorderInitialized = true;
  //       update();
  //       debugPrint('Recorder initialized successfully');
  //     } else if (status.isDenied) {
  //       debugPrint('Microphone permission denied');
  //       isRecorderInitialized = false;
  //       update();
  //     } else if (status.isPermanentlyDenied) {
  //       debugPrint(
  //           'Microphone permission is permanently denied. Please enable it from settings.');
  //       isRecorderInitialized = false;
  //       update();
  //       await openAppSettings();
  //     }
  //   } catch (e) {
  //     debugPrint('Error initializing recorder: $e');
  //     isRecorderInitialized = false;
  //     update();
  //   }
  // }

  // Future<void> startRecording() async {
  //   if (!isRecorderInitialized) {
  //     debugPrint('Recorder is not initialized');
  //     return;
  //   }
  //   try {
  //     final directory = await getApplicationDocumentsDirectory();
  //     filePath = p.join(
  //         directory.path, 'audio_${DateTime.now().millisecondsSinceEpoch}.wav');
  //
  //     await recorder?.startRecorder(
  //         toFile: filePath,
  //         codec: Codec.pcm16WAV,
  //         // codec: Codec.aacADTS, // Use AAC codec for smaller file size
  //         numChannels: 1, // Record in mono
  //         bitRate: 4000);
  //
  //     isRecording = true;
  //     update();
  //   } catch (e) {
  //     logger.e('Error starting recording: $e');
  //   }
  // }

  // Future<void> stopRecording() async {
  //   if (!isRecorderInitialized) {
  //     debugPrint('Recorder is not initialized');
  //     return;
  //   }
  //   try {
  //     // sendSpeech();
  //     await recorder?.stopRecorder();
  //
  //     await transcribeAudioToText();
  //     isRecording = false;
  //     update();
  //   } catch (e) {
  //     logger.e('Error stopping recording: $e');
  //   }
  // }

  // Future<void> startRecording() async {
  //   if (!isRecorderInitialized) {
  //     debugPrint('Recorder is not initialized');
  //     return;
  //   }
  //   try {
  //     final directory = await getApplicationDocumentsDirectory();
  //     filePath = p.join(
  //         directory.path, 'audio_${DateTime.now().millisecondsSinceEpoch}.wav');
  //
  //     await recorder!.startRecorder(
  //         toFile: filePath,
  //         codec: Codec.pcm16WAV,
  //         numChannels: 1, // Record in mono
  //         bitRate: 4000);
  //
  //     isRecording = true;
  //     update();
  //   } catch (e) {
  //     logger.e('Error starting recording: $e');
  //   }
  // }

  // Future<void> stopRecording() async {
  //   if (!isRecorderInitialized) {
  //     debugPrint('Recorder is not initialized');
  //     return;
  //   }
  //   try {
  //     await recorder!.stopRecorder();
  //     isRecording = false;
  //     update();
  //
  //     // After stopping the recording, convert the audio to text
  //     await transcribeAudioToText();
  //   } catch (e) {
  //     logger.e('Error stopping recording: $e');
  //   }
  // }

  // Future<void> transcribeAudioToText() async {
  //   try {
  //     await initializeRecorder(); // Ensure microphone permission
  //     await initializeSpeechToText(); // Initialize speech-to-text
  //
  //     if (_speechToText.isAvailable && await _speechToText.hasPermission) {
  //       isListening = await _speechToText.listen(
  //             onResult: (result) {
  //               try {
  //                 recordedText = result.recognizedWords;
  //                 _speechToText.stop();
  //
  //                 // Compare the recorded text with your target string
  //                 String targetString = "your target text here";
  //                 if (recordedText.trim().toLowerCase() ==
  //                     targetString.trim().toLowerCase()) {
  //                   logger.i(
  //                       'Success: The recorded text matches the target string.');
  //                 } else {
  //                   logger.e(
  //                       'Fail: The recorded text does not match the target string.');
  //                 }
  //               } catch (e) {
  //                 logger.e('Error processing transcription result: $e');
  //               }
  //             },
  //             localeId: 'en_US',
  //             partialResults: true, // If you want partial results.
  //             pauseFor: Duration(seconds: 5), // Adjust the pause time.
  //             cancelOnError: true,
  //             // localeId: 'en_US', // Specify your locale if needed
  //             // cancelOnError: true,
  //           ) ??
  //           false; // Default to false if the listen method returns null.
  //
  //       logger.i('Listening status: $isListening');
  //     } else {
  //       logger.e('Speech recognition not available or permission not granted.');
  //     }
  //   } catch (e) {
  //     logger.e('Error during transcription: $e');
  //   }
  // }

  // Future<void> transcribeAudioToText() async {
  //   try {
  //     // Reinitialize SpeechToText if necessary.
  //     if (!_speechToText.isAvailable) {
  //       await _speechToText.initialize(
  //         onStatus: (status) => debugPrint('Speech status: $status'),
  //         onError: (error) => logger.e('Speech recognition error: $error'),
  //       );
  //     }
  //
  //     if (await _speechToText.hasPermission && _speechToText.isAvailable) {
  //       isListening = await _speechToText.listen(
  //             onResult: (result) {
  //               try {
  //                 recordedText = result.recognizedWords;
  //                 _speechToText.stop();
  //
  //                 // Compare the recorded text with your target string
  //                 String targetString = "your target text here";
  //                 if (recordedText.trim().toLowerCase() ==
  //                     targetString.trim().toLowerCase()) {
  //                   logger.i(
  //                       'Success: The recorded text matches the target string.');
  //                 } else {
  //                   logger.e(
  //                       'Fail: The recorded text does not match the target string.');
  //                 }
  //               } catch (e) {
  //                 logger.e('Error processing transcription result: $e');
  //               }
  //             },
  //             cancelOnError: true,
  //           ) ??
  //           false; // Default to false if the listen method returns null.
  //
  //       debugPrint('Listening status: $isListening');
  //     } else {
  //       debugPrint(
  //           'Microphone permission not granted or speech recognition is not available.');
  //     }
  //   } catch (e) {
  //     logger.e('Error during transcription: $e');
  //   }
  // }

  // Future<void> transcribeAudioToText() async {
  //   try {
  //     if (await _speechToText.hasPermission) {
  //       isListening = await _speechToText.listen(
  //             onResult: (result) {
  //               try {
  //                 recordedText = result.recognizedWords;
  //                 _speechToText.stop();
  //
  //                 // Compare the recorded text with your target string
  //                 String targetString = "your target text here";
  //                 if (recordedText.trim().toLowerCase() ==
  //                     targetString.trim().toLowerCase()) {
  //                   logger.i(
  //                       'Success: The recorded text matches the target string.');
  //                 } else {
  //                   logger.e(
  //                       'Fail: The recorded text does not match the target string.');
  //                 }
  //               } catch (e) {
  //                 logger.e('Error processing transcription result: $e');
  //               }
  //             },
  //             cancelOnError: true,
  //           ) ??
  //           false; // Default to false if the listen method returns null.
  //
  //       debugPrint('Listening status: $isListening');
  //     } else {
  //       debugPrint('Microphone permission not granted.');
  //     }
  //   } catch (e) {
  //     logger.e('Error during transcription: $e');
  //   }
  // }

  final SpeechToText speechToText = SpeechToText();

  bool speechEnabled = false;
  String wordsSpoken = "";

  void initSpeech() async {
    speechEnabled = await speechToText.initialize();
    update();
  }

  void startListening() async {
    await speechToText.listen(onResult: onSpeechResult);
    update();
  }

  void stopListening() async {
    await speechToText.stop();
    update();
  }

  void onSpeechResult(result) {
    wordsSpoken = "${result.recognizedWords}";
    update();
  }

  bool isPassed = false;

  playRecordedText() {
    Get.find<MicrophoneController>().speak(wordsSpoken);
  }

  matchSpokenAndAnswerText(String answer, String question, String route) async {
    logger.i('Answer = ${answer.replaceAll('.', '')}');
    logger.i('Spoken words = $wordsSpoken');
    if (wordsSpoken == answer.replaceAll('.', '')) {
      if (route == '/general') {
        await addRobotGeneralFeature(
          AppStorage.getUserData()?.userId ?? '',
          question,
          '${answer.replaceAll('.', '')}',
          wordsSpoken,
          'Pass',
        );
      } else {
        await addRobotTopicFeature(
          AppStorage.getUserData()?.userId ?? '',
          question,
          '${answer.replaceAll('.', '')}',
          wordsSpoken,
          'Fail',
        );
      }

      isPassed = true;
      logger.i('Answer matched');
    } else {
      if (route == '/general') {
        await addRobotGeneralFeature(
          AppStorage.getUserData()?.userId ?? '',
          question,
          '${answer.replaceAll('.', '')}',
          wordsSpoken,
          'Fail',
        );
      } else {
        await addRobotTopicFeature(
          AppStorage.getUserData()?.userId ?? '',
          question,
          '${answer.replaceAll('.', '')}',
          wordsSpoken,
          'Fail',
        );
      }

      isPassed = false;

      logger.i('Answer did not matched');
    }
    stopProgress();
    showResult = true;
    update();
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> addRobotGeneralFeature(String userId, String question,
      String selectedAnswer, String wordsSpoken, String status) async {
    // Create the feature map that will be added to the list
    Map<String, dynamic> featureData = {
      'question': question,
      'selectedAnswer': selectedAnswer,
      'spokenAnswer': wordsSpoken,
      'status': status,
      'createdAt': DateTime.now(),
    };

    try {
      // Use 'update' with FieldValue.arrayUnion to append the feature to the array
      await _firestore
          .collection('robotGeneralFeature')
          .doc(userId) // Each userId has its own document
          .set(
              {
            'features': FieldValue.arrayUnion(
                [featureData]) // Add the new feature to the 'features' array
          },
              SetOptions(
                  merge:
                      true)); // Use merge to update the document without overwriting it

      logger.i('Feature added successfully!');
    } catch (e) {
      logger.e('Error adding feature: $e');
    }
  }

  Future<void> addRobotTopicFeature(String userId, String question,
      String selectedAnswer, String wordsSpoken, String status) async {
    // Create the feature map that will be added to the list
    Map<String, dynamic> featureData = {
      'question': question,
      'selectedAnswer': selectedAnswer,
      'spokenAnswer': wordsSpoken,
      'status': status,
      'createdAt': DateTime.now(),
      'topic': topicCtrl.text
    };

    try {
      // Use 'update' with FieldValue.arrayUnion to append the feature to the array
      await _firestore
          .collection('robotTopicFeature')
          .doc(userId) // Each userId has its own document
          .set(
              {
            'features': FieldValue.arrayUnion(
                [featureData]) // Add the new feature to the 'features' array
          },
              SetOptions(
                  merge:
                      true)); // Use merge to update the document without overwriting it

      logger.i('Topic Feature added successfully!');
    } catch (e) {
      logger.e('Error adding feature: $e');
    }
  }
}
