// import 'dart:io';

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';
import 'package:goolu/Model/generate_answers_model.dart';
import 'package:goolu/Model/question_and_answer_model.dart';
import 'package:goolu/Services/storage_sevices.dart';
import 'package:goolu/View/RobotPage/GeneralFeature/robot_general.dart';
import 'package:goolu/View/RobotPage/SituationFeature/robot_situation.dart';
import 'package:goolu/View/RobotPage/TopicFeature/robot_topic.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:path_provider/path_provider.dart';
import 'package:record/record.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../Model/NavBarModel/nav_bar_model.dart';
import '../../Model/check_grammer_model.dart';
import '../../Model/compairing_audio_model.dart';
import '../../Model/situation_model.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Utils/enums.dart';
import '../../Utils/utils.dart';
import '../../View/RobotPage/SituationFeature/widgets/bot_question_widget.dart';
import '../../View/RobotPage/SituationFeature/widgets/bot_user_answer_widget.dart';
import '../ExceptionalController/exceptional_controller.dart';

class RobotController extends GetxController {
  bool completedSituation = false;
  bool isQuestion = false;
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
  TextEditingController customQuestionCtrl = TextEditingController();

  bool feature3Speak = false;
  bool playSubButton = false;
  var isSpeaking = false.obs;

  final FlutterTts flutterTts = FlutterTts();
  Future<void> speak(String txt) async {
    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(1.0);
    await flutterTts.setSpeechRate(0.4);

    flutterTts.startHandler = () {
      isSpeaking.value = true;
    };

    flutterTts.completionHandler = () {
      isSpeaking.value = false;
    };

    flutterTts.errorHandler = (msg) {
      isSpeaking.value = false;
    };

    await flutterTts.speak(txt);
  }

  bool isStopped = false;
  Future<void> speakDialogue() async {
    if (situationModel?.data == null || situationModel!.data!.isEmpty) {
      return;
    }

    isStopped = false; // Reset stop flag before speaking
    isSpeaking.value = true; // Ensure UI updates correctly

    for (int i = 0; i < situationModel!.data!.length; i++) {
      var datum = situationModel!.data![i];
      if (isStopped) break;

      if (datum.question != null) {
        await speakWithVoice(datum.question!, isMale: true);
        if (isStopped) break;
      }

      if (datum.answer != null) {
        await speakWithVoice(datum.answer!, isMale: false);
        if (isStopped) break;
      }
    }
  }

  Future<void> speakWithVoice(String text, {required bool isMale}) async {
    if (isStopped) return; // Stop immediately if requested

    await flutterTts.setLanguage('en-US');
    await flutterTts.setPitch(isMale ? 1.0 : 1.2);
    await flutterTts.setSpeechRate(0.4);
    await flutterTts.setVoice(
        {'name': isMale ? 'en-us-twm' : 'en-us-wfm', 'locale': 'en-US'});

    await flutterTts.speak(text);

    int estimatedDuration =
        (text.split(' ').length ~/ 2).clamp(1, 10); // Max 10 sec
    for (int i = 0; i < estimatedDuration; i++) {
      await Future.delayed(const Duration(seconds: 1));
      if (isStopped) {
        await flutterTts.stop();
        isSpeaking.value = false;
        return;
      }
    }

    if (!isStopped) {
      isSpeaking.value = false; // Set only after the last dialogue
    }
  }

  void stopSpeakingSituation() async {
    isStopped = true; // Set stop flag
    await flutterTts.stop(); // Stop TTS immediately
    isSpeaking.value = false;
  }

  Future<void> stopSpeaking() async {
    await flutterTts.stop();
    isSpeaking.value = false;
  }

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

  int currentQuestionIndex = 0;
  bool isCustomer = false;
  List<Widget> displayItems = [];

  SituationModel? situationModel;
  Future<bool> fetchSituation({String? situation}) async {
    Map<String, String> field = {
      "situation": '$situation',
    };

    return await ApiServices.postMethod(
      feedUrl:
          "https://feature3-1028825189557.us-central1.run.app/generate-scenario/",
      fields: field,
    ).then((res) async {
      if (res == null) {
        stopProgress();
        Get.back();
        return false;
      }
      situationModel = situationModelFromJson(res);
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

  ///Manually checking the data
  // void handleAnswer() {
  //   final currentData = situationModel!.data![currentQuestionIndex];
  //   // Clean user response and correct answer
  //   String cleanedUserAnswer =
  //       wordsSpoken.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
  //   String cleanedCorrectAnswer =
  //       currentData.answer!.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
  //
  //   logger.i('Question -->> $currentData');
  //   logger.i('Cleaned user answer: $cleanedUserAnswer');
  //   logger.i('Cleaned correct answer: $cleanedCorrectAnswer');
  //
  //   // Add user response to the display items
  //   displayItems.add(BotUserAnswerWidget(answer: wordsSpoken));
  //   update();
  //
  //   if (cleanedUserAnswer == cleanedCorrectAnswer) {
  //     // Move to the next question
  //     currentQuestionIndex++;
  //     if (currentQuestionIndex < situationModel!.data!.length) {
  //       displayItems.add(BotQuestionWidget(
  //         question: situationModel!.data![currentQuestionIndex].question,
  //       ));
  //     } else {
  //       // All questions completed
  //       displayItems.add(const BotQuestionWidget(
  //         question: "Great job! You've completed.",
  //       ));
  //     }
  //   } else {
  //     // If answer doesn't match
  //     displayItems.add(const BotQuestionWidget(
  //       question: "Sorry, that's not correct. Please try again.",
  //     ));
  //   }
  //   update();
  // }

  Future<void> handleAnswer() async {
    await sendVoiceFileForAnswer(recordedFilePath!);
  }

  void resetData() {
    displayItems.clear(); // Clear displayed items
    currentQuestionIndex = 0; // Reset question index
    wordsSpoken = ''; // Clear the spoken words
    feature3Speak = false; // Reset the speech feature
    stopListening(); // Ensure speech is stopped
  }

  Future<void> handleUserQuestion() async {
    await sendVoiceFileForQuestion(recordedFilePath!);
  }
  // void handleUserQuestion() {
  //   // Ensure situationModel and data are valid
  //   if (situationModel == null || situationModel!.data == null) {
  //     displayItems.add(const BotQuestionWidget(
  //       question: "No questions available. Please try again later.",
  //     ));
  //     update();
  //     return;
  //   }
  //
  //   // Clean the user's spoken words
  //   String cleanedUserQuestion =
  //       wordsSpoken.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
  //
  //   // Variable to track if a match is found
  //   bool questionMatched = false;
  //
  //   for (var data in situationModel!.data!) {
  //     // Ensure the question is non-null
  //     if (data.question == null || data.answer == null) continue;
  //
  //     // Clean the predefined question for comparison
  //     String cleanedPredefinedQuestion =
  //         data.question!.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
  //
  //     if (cleanedUserQuestion == cleanedPredefinedQuestion) {
  //       // Match found: Add user's question and bot's answer to display
  //       displayItems.add(BotUserAnswerWidget(answer: wordsSpoken));
  //       displayItems.add(BotQuestionWidget(question: data.answer!));
  //       questionMatched = true;
  //       break;
  //     }
  //   }
  //
  //   if (!questionMatched) {
  //     // No match found: Ask the user to repeat the question
  //     displayItems.add(BotUserAnswerWidget(answer: wordsSpoken));
  //     displayItems.add(const BotQuestionWidget(
  //       question: "I didn't understand that. Could you please repeat it?",
  //     ));
  //   }
  //   update();
  // }

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
      throw '$error';
    });
  }

  bool isRecorderInitialized1 = false;
  bool isRecorderInitialized = false;
  String? filePath;
  FlutterSoundRecorder? recorder;
  bool isRecording = false;
  bool isListening = false;
  String recordedText = '';

  final SpeechToText speechToText = SpeechToText();
  bool speechEnabled = false;
  String wordsSpoken = "";

  void initSpeech() async {
    try {
      speechEnabled = await speechToText.initialize(
        onError: (error) {
          logger.e("Speech Init Error: ${error.errorMsg}");
        },
        onStatus: (status) {
          logger.i("Speech Status: $status");
        },
      );
      update();
    } catch (e) {
      logger.e("Error initializing speech: $e");
    }
  }

  void startListening() async {
    if (speechEnabled && !speechToText.isListening) {
      wordsSpoken = ""; // Reset previous sentence
      await speechToText.listen(
        onResult: onSpeechResult, // Use only final speech result
        listenMode: ListenMode.dictation,
        cancelOnError: true,
      );
    }
    update();
  }

  void stopListening() async {
    if (speechToText.isListening) {
      await speechToText.stop();
    }
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult && result.recognizedWords.isNotEmpty) {
      wordsSpoken = result.recognizedWords
          .toLowerCase()
          .trim(); // Store complete sentence
      logger.i("Final Recognized Sentence: $wordsSpoken");

      if (wordsSpoken.isNotEmpty) {
        // handleAnswer(); // Only process if not empty
        if (isCustomer == true) {
          handleAnswer();
        } else {
          handleUserQuestion();
        }
        update();
      }
    } else {
      logger.i("Interim Words: ${result.recognizedWords}");
    }
  }

  final record = Record();
  String? recordedFilePath;

  Future<void> startRecording() async {
    if (await record.hasPermission()) {
      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/recorded_audio.m4a'; // or .mp4 if supported
      await record.start(path: path);
      recordedFilePath = path;
      logger.i("Recording started...");
    }
  }

  Future<void> stopRecording() async {
    await record.stop();
    logger.i("Recording stopped. File saved at: $recordedFilePath");

    if (recordedFilePath != null) {
      if (isCustomer == true) {
        handleAnswer();
      } else {
        handleUserQuestion();
      }
    }
  }

  ComparingAudioModel? comparingAudioModel;

  Future<void> sendVoiceFileForAnswer(String filePath) async {
    showProgress();
    final uri = Uri.parse(ApiUrls.compareAudioWithTextApi);
    final request = http.MultipartRequest('POST', uri);

    request.fields['comparison_text'] =
        situationModel!.data![currentQuestionIndex].answer ?? '';

    request.files.add(
      await http.MultipartFile.fromPath(
        'audio_file',
        filePath,
        contentType: MediaType('audio', 'mp4'), // or audio/mp4 or audio/m4a
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        stopProgress();
        comparingAudioModel = comparingAudioModelFromJson(response.body);

        logger.i(response.body);

        if (comparingAudioModel?.exactMatch == true) {
          // Add user response to the display items
          displayItems.add(BotUserAnswerWidget(
              answer: comparingAudioModel?.transcribedText ?? ''));
          update();
          currentQuestionIndex++;
          if (currentQuestionIndex < situationModel!.data!.length) {
            displayItems.add(BotQuestionWidget(
              question: situationModel!.data![currentQuestionIndex].question,
            ));
          } else {
            // All questions completed
            displayItems.add(const BotQuestionWidget(
              question: "Great job! You've completed.",
            ));
          }
          update();
        } else {
          displayItems.add(BotUserAnswerWidget(
              answer: comparingAudioModel?.transcribedText ?? ''));
          // If answer doesn't match
          displayItems.add(const BotQuestionWidget(
            question: "Sorry, that's not correct. Please try again.",
          ));
          logger.e("API Error: ${response.body}");
        }
      } else {
        // showToast('API error: ${response.statusCode}');
      }
    } catch (e) {
      logger.e("Sending file failed: $e");
      showToast('Something went wrong');
    } finally {
      // isRecordPressed = false;
      update();
    }
  }

  Future<void> sendVoiceFileForQuestion(String filePath) async {
    if (situationModel == null || situationModel!.data == null) {
      displayItems.add(const BotQuestionWidget(
        question: "No questions available. Please try again later.",
      ));
      update();
      return;
    }
    // bool questionMatched = false;
    showProgress();
    final uri = Uri.parse(ApiUrls.compareAudioWithTextApi);
    final request = http.MultipartRequest('POST', uri);

    request.fields['comparison_text'] =
        situationModel!.data![currentQuestionIndex].question ?? '';

    request.files.add(
      await http.MultipartFile.fromPath(
        'audio_file',
        filePath,
        contentType: MediaType('audio', 'mp4'), // or audio/mp4 or audio/m4a
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      // Variable to track if a match is found

      if (response.statusCode == 200) {
        stopProgress();
        comparingAudioModel = comparingAudioModelFromJson(response.body);
        logger.i(response.body);
        if (comparingAudioModel?.exactMatch == true) {
          displayItems.add(BotQuestionWidget(
              question: comparingAudioModel?.transcribedText));
          // displayItems.add(BotUserAnswerWidget(
          //     answer: comparingAudioModel?.transcribedText));
          //
          //
          //
          // // Add user response to the display items
          // displayItems.add(BotUserAnswerWidget(answer: wordsSpoken));
          // questionMatched = true;
          update();
          currentQuestionIndex++;
          if (currentQuestionIndex < situationModel!.data!.length) {
            displayItems.add(BotUserAnswerWidget(
              answer: situationModel!.data![currentQuestionIndex - 1].answer,
            ));
          } else {
            // All questions completed
            displayItems.add(const BotQuestionWidget(
              question: "Great job! You've completed.",
            ));
          }
          update();
        } else {
          // If answer doesn't match

          // No match found: Ask the user to repeat the question
          displayItems.add(BotQuestionWidget(
              question: comparingAudioModel?.transcribedText ?? ''));
          displayItems.add(const BotUserAnswerWidget(
              answer: "I didn't understand that. Could you please repeat it?"));
        }
      } else {
        stopProgress();

        logger.e("API Error: ${response.body}");
        // showToast('API error: ${response.statusCode}');
      }
    } catch (e) {
      logger.e("Sending file failed: $e");
      showToast('Something went wrong');
    } finally {
      // isRecordPressed = false;
      update();
    }
  }

  // void onSpeechResult(SpeechRecognitionResult result) {
  //   if (result.finalResult) {
  //     wordsSpoken =
  //         result.recognizedWords.toLowerCase(); // Store complete sentence
  //     logger.i("Final Recognized Sentence: $wordsSpoken");
  //
  //     handleAnswer(); // Process final result
  //     update();
  //   } else {
  //     logger.i("Interim Words: ${result.recognizedWords}");
  //   }
  // }
  // void startListening() async {
  //   if (speechEnabled && !speechToText.isListening) {
  //     await speechToText.listen(
  //       onResult: (result) {
  //         wordsSpoken = result.recognizedWords.toLowerCase();
  //         update();
  //       },
  //       listenMode: ListenMode.dictation,
  //       cancelOnError: true,
  //     );
  //   }
  //   update();
  // }
  //
  // void stopListening() async {
  //   if (speechToText.isListening) {
  //     await speechToText.stop();
  //   }
  //   // update();
  // }
  //
  // onSpeechResult(SpeechRecognitionResult result) {
  //   if (result.finalResult) {
  //     wordsSpoken = result.recognizedWords;
  //     logger.i("Final Recognized Words: $wordsSpoken");
  //     handleAnswer();
  //     update();
  //   } else {
  //     logger.i("Interim Result: ${result.recognizedWords}");
  //   }
  // }

  bool isPassed = false;

  playRecordedText() {
    Get.find<MicrophoneController>().selectedLanguageCode = 'en-Us';
    Get.find<MicrophoneController>().update();
    Get.find<MicrophoneController>().speak(wordsSpoken);
  }

  final record2 = Record();
  String? recordedFilePath2;

  Future<void> startRecording2() async {
    if (await record2.hasPermission()) {
      final dir = await getTemporaryDirectory();
      final path = '${dir.path}/recorded_audio.m4a'; // or .mp4 if supported
      await record2.start(path: path);
      recordedFilePath2 = path;
      logger.i("Recording started...");
    }
  }

  Future<void> stopRecording2(
      // String answer, String question, String route
      ) async {
    await record2.stop();
    logger.i("Recording stopped. File saved at: $recordedFilePath2");

    // if (recordedFilePath2 != null) {
    //   await sendVoiceFileToApi(recordedFilePath2!, answer, question, route);
    // }
  }

  /// ------------------------ String Similarity Matching ------------------------ ///
  Future<void> matchSpokenAndAnswerText(
      String answer, String question, String route) async {
    sendVoiceFileToApi(recordedFilePath2 ?? '', answer, question, route);
    // Clean up input strings: Convert to lowercase and remove unnecessary characters
    // String cleanedAnswer =
    //     answer.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
    // String cleanedSpokenWords =
    //     wordsSpoken.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
    //
    // logger.i('Cleaned Answer = $cleanedAnswer');
    // logger.i('Cleaned Spoken Words = $cleanedSpokenWords');
    //
    // // Calculate similarity using Jaro-Winkler algorithm
    // double similarityScore = cleanedSpokenWords.similarityTo(cleanedAnswer);
    // logger.i('Similarity Score: $similarityScore');
    //
    // // Define a threshold (e.g., 0.7 means 70% similarity is required)
    // bool isMatched = similarityScore > 0.7;
    //
    // if (isMatched) {
    //   if (route == '/general') {
    //     await addRobotGeneralFeature(
    //       AppStorage.getUserData()?.userId ?? '',
    //       question,
    //       cleanedAnswer,
    //       cleanedSpokenWords,
    //       'Pass',
    //     );
    //   } else {
    //     await addRobotTopicFeature(
    //       AppStorage.getUserData()?.userId ?? '',
    //       question,
    //       cleanedAnswer,
    //       cleanedSpokenWords,
    //       'Pass',
    //     );
    //   }
    //   isPassed = true;
    //   logger.i('Answer Matched!');
    // } else {
    //   if (route == '/general') {
    //     await addRobotGeneralFeature(
    //       AppStorage.getUserData()?.userId ?? '',
    //       question,
    //       cleanedAnswer,
    //       cleanedSpokenWords,
    //       'Fail',
    //     );
    //   } else {
    //     await addRobotTopicFeature(
    //       AppStorage.getUserData()?.userId ?? '',
    //       question,
    //       cleanedAnswer,
    //       cleanedSpokenWords,
    //       'Fail',
    //     );
    //   }
    //   isPassed = false;
    //   logger.i('Answer Did Not Match!');
    // }
    // stopProgress();
    // showResult = true;
    // update();
  }

  // ComparingAudioModel? comparingAudioModel;
  Future<void> sendVoiceFileToApi(
      String filePath, String answer, String question, String route) async {
    showProgress();
    final uri = Uri.parse(ApiUrls.compareAudioWithTextApi);
    final request = http.MultipartRequest('POST', uri);

    request.fields['comparison_text'] = answer ?? '';

    request.files.add(
      await http.MultipartFile.fromPath(
        'audio_file',
        filePath,
        contentType: MediaType('audio', 'mp4'), // or audio/mp4 or audio/m4a
      ),
    );

    try {
      final streamedResponse = await request.send();
      final response = await http.Response.fromStream(streamedResponse);

      if (response.statusCode == 200) {
        comparingAudioModel = comparingAudioModelFromJson(response.body);
        final data = jsonDecode(response.body);
        logger.i(response.body);

        if (comparingAudioModel?.exactMatch == true) {
          if (route == '/general') {
            await addRobotGeneralFeature(
              AppStorage.getUserData()?.userId ?? '',
              question,
              comparingAudioModel?.details?.normalizedTranscribed ?? '',
              comparingAudioModel?.details?.normalizedTranscribed ?? '',
              'Pass',
            );
          } else {
            await addRobotTopicFeature(
              AppStorage.getUserData()?.userId ?? '',
              question,
              comparingAudioModel?.details?.normalizedTranscribed ?? '',
              comparingAudioModel?.details?.normalizedTranscribed ?? '',
              'Pass',
            );
          }
          isPassed = true;
          logger.i('Answer Matched!');
          update();
        } else {
          if (route == '/general') {
            await addRobotGeneralFeature(
              AppStorage.getUserData()?.userId ?? '',
              question,
              comparingAudioModel?.details?.normalizedTranscribed ?? '',
              comparingAudioModel?.details?.normalizedTranscribed ?? '',
              'Fail',
            );
          } else {
            await addRobotTopicFeature(
              AppStorage.getUserData()?.userId ?? '',
              question,
              comparingAudioModel?.details?.normalizedTranscribed ?? '',
              comparingAudioModel?.details?.normalizedTranscribed ?? '',
              'Fail',
            );
          }
          isPassed = false;
          logger.i('Answer Did Not Match!');
          update();
        }
        stopProgress();
        showResult = true;
        update();
      } else {
        stopProgress();
        logger.e("API Error: ${response.body}");
        showToast('API error: ${response.statusCode}');
      }
    } catch (e) {
      logger.e("Sending file failed: $e");
      showToast('Something went wrong');
    } finally {
      // isRecordPressed = false;
      update();
    }
  }

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<void> addRobotGeneralFeature(String userId, String question,
      String selectedAnswer, String wordsSpoken, String status) async {
    Map<String, dynamic> featureData = {
      'question': question,
      'selectedAnswer': selectedAnswer,
      'spokenAnswer': wordsSpoken,
      'status': status,
      'createdAt': DateTime.now(),
    };

    try {
      await _firestore.collection('robotGeneralFeature').doc(userId).set({
        'features': FieldValue.arrayUnion([featureData])
      }, SetOptions(merge: true));

      logger.i('Feature added successfully!');
    } catch (e) {
      logger.e('Error adding feature: $e');
    }
  }

  Future<void> addRobotTopicFeature(String userId, String question,
      String selectedAnswer, String wordsSpoken, String status) async {
    Map<String, dynamic> featureData = {
      'question': question,
      'selectedAnswer': selectedAnswer,
      'spokenAnswer': wordsSpoken,
      'status': status,
      'createdAt': DateTime.now(),
      'topic': topicCtrl.text
    };

    try {
      await _firestore.collection('robotTopicFeature').doc(userId).set({
        'features': FieldValue.arrayUnion([featureData])
      }, SetOptions(merge: true));

      logger.i('Topic Feature added successfully!');
    } catch (e) {
      logger.e('Error adding feature: $e');
    }
  }
}
