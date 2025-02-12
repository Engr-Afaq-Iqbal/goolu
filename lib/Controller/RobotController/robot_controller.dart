// import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'package:flutter_tts/flutter_tts.dart';
// import 'package:flutter_sound/public/flutter_sound_recorder.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';
import 'package:goolu/Model/generate_answers_model.dart';
import 'package:goolu/Model/question_and_answer_model.dart';
import 'package:goolu/Services/storage_sevices.dart';
import 'package:goolu/View/RobotPage/GeneralFeature/robot_general.dart';
import 'package:goolu/View/RobotPage/SituationFeature/robot_situation.dart';
import 'package:goolu/View/RobotPage/TopicFeature/robot_topic.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../Model/NavBarModel/nav_bar_model.dart';
import '../../Model/check_grammer_model.dart';
import '../../Model/situation_model.dart';
import '../../Services/api_services.dart';
import '../../Services/api_urls.dart';
import '../../Utils/enums.dart';
import '../../Utils/utils.dart';
import '../../View/RobotPage/SituationFeature/widgets/bot_question_widget.dart';
import '../../View/RobotPage/SituationFeature/widgets/bot_user_answer_widget.dart';
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
  TextEditingController customQuestionCtrl = TextEditingController();

  bool feature3Speak = false;
  // bool playButton = false;
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
  // List<String> displayItems = [];
  List<Widget> displayItems = [];

  SituationModel? situationModel;
  Future<bool> fetchSituation({String? situation}) async {
    Map<String, String> field = {
      "situation": '$situation',
    };
    // showProgress();
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

      // displayItems.add(BotQuestionWidget(
      //   question: situationModel!.data![currentQuestionIndex].question,
      // ));
      // displayItems.add(situationModel!.data![currentQuestionIndex].question!);
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

  // void handleAnswer() {
  //   final currentData = situationModel!.data![currentQuestionIndex];
  //   if (wordsSpoken.toLowerCase() == currentData.answer!.toLowerCase()) {
  //     displayItems.add("User Answer: $wordsSpoken");
  //     currentQuestionIndex++;
  //     if (currentQuestionIndex < situationModel!.data!.length) {
  //       displayItems.add(situationModel!.data![currentQuestionIndex].question!);
  //     }
  //     update();
  //   } else {
  //     displayItems.add("Didn't understand what you said. Kindly speak again.");
  //     update();
  //   }
  //   // stopListening();
  // }

  void handleAnswer() {
    final currentData = situationModel!.data![currentQuestionIndex];
    // Clean user response and correct answer
    String cleanedUserAnswer =
        wordsSpoken.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
    String cleanedCorrectAnswer =
        currentData.answer!.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();

    logger.i('Question -->> $currentData');
    logger.i('Cleaned user answer: $cleanedUserAnswer');
    logger.i('Cleaned correct answer: $cleanedCorrectAnswer');

    // Add user response to the display items
    displayItems.add(BotUserAnswerWidget(answer: wordsSpoken));
    update();

    if (cleanedUserAnswer == cleanedCorrectAnswer) {
      // Move to the next question
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
    } else {
      // If answer doesn't match
      displayItems.add(const BotQuestionWidget(
        question: "Sorry, that's not correct. Please try again.",
      ));
    }
    update();
  }

  // void handleAnswer() {
  //   final currentData = situationModel!.data![currentQuestionIndex];
  //   // Clean both user response and expected answer
  //
  //   String cleanedUserAnswer =
  //       wordsSpoken.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
  //   String cleanedCorrectAnswer =
  //       currentData.answer!.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
  //   // Add user response to the list
  //   logger.i('Question -->> $currentData');
  //   logger.i('Cleaned user answer $cleanedUserAnswer');
  //   logger.i('Cleaned correct answer $cleanedCorrectAnswer');
  //   displayItems.add(BotUserAnswerWidget(answer: wordsSpoken));
  //   update();
  //
  //   if (cleanedUserAnswer == cleanedCorrectAnswer) {
  //     // If answer matches, move to the next question
  //     currentQuestionIndex++;
  //     if (currentQuestionIndex < situationModel!.data!.length) {
  //       displayItems.add(BotQuestionWidget(
  //         question: situationModel!.data![currentQuestionIndex].question,
  //       ));
  //       update();
  //     } else {
  //       // All questions completed
  //
  //       displayItems.add(const BotQuestionWidget(
  //         question: "Great job! You've completed.",
  //       ));
  //       update();
  //     }
  //   } else {
  //     // If answer doesn't match, display a message
  //
  //     displayItems.add(const BotQuestionWidget(
  //       question: "Sorry, that's not correct. Please try again.",
  //     ));
  //     update();
  //   }
  //   // stopListening();
  //   // feature3Speak = false;
  // }

  void resetData() {
    displayItems.clear(); // Clear displayed items
    currentQuestionIndex = 0; // Reset question index
    wordsSpoken = ''; // Clear the spoken words
    feature3Speak = false; // Reset the speech feature
    stopListening(); // Ensure speech is stopped// Update the UI
  }

  void handleUserQuestion() {
    // Ensure situationModel and data are valid
    if (situationModel == null || situationModel!.data == null) {
      displayItems.add(const BotQuestionWidget(
        question: "No questions available. Please try again later.",
      ));
      update();
      return;
    }

    // Clean the user's spoken words
    String cleanedUserQuestion =
        wordsSpoken.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();

    // Variable to track if a match is found
    bool questionMatched = false;

    for (var data in situationModel!.data!) {
      // Ensure the question is non-null
      if (data.question == null || data.answer == null) continue;

      // Clean the predefined question for comparison
      String cleanedPredefinedQuestion =
          data.question!.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();

      if (cleanedUserQuestion == cleanedPredefinedQuestion) {
        // Match found: Add user's question and bot's answer to display
        displayItems
            .add(BotUserAnswerWidget(answer: wordsSpoken)); // User's question
        displayItems
            .add(BotQuestionWidget(question: data.answer!)); // Bot's answer

        questionMatched = true;
        break;
      }
    }

    if (!questionMatched) {
      // No match found: Ask the user to repeat the question
      displayItems
          .add(BotUserAnswerWidget(answer: wordsSpoken)); // User's question
      displayItems.add(const BotQuestionWidget(
        question: "I didn't understand that. Could you please repeat it?",
      ));
    }

    // Update UI after processing
    update();
  }

  // void handleUserQuestion() {
  //   // Clean the user question and compare with predefined questions
  //   String cleanedUserQuestion =
  //       wordsSpoken.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
  //   bool questionMatched = false;
  //
  //   for (var data in situationModel!.data!) {
  //     String cleanedPredefinedQuestion =
  //         data.question!.replaceAll(RegExp(r'[^\w\s]'), '').toLowerCase();
  //
  //     if (cleanedUserQuestion == cleanedPredefinedQuestion) {
  //       // Match found: Show the answer
  //       displayItems
  //           .add(BotUserAnswerWidget(answer: wordsSpoken)); // User's question
  //       displayItems
  //           .add(BotQuestionWidget(question: data.answer)); // Bot's answer
  //       questionMatched = true;
  //       update();
  //       break;
  //     }
  //   }
  //
  //   if (!questionMatched) {
  //     // No match found: Ask the user to repeat the question
  //     displayItems
  //         .add(BotUserAnswerWidget(answer: wordsSpoken)); // User's question
  //     displayItems.add(const BotQuestionWidget(
  //       question: "Didn't understand what you said. Kindly say again.",
  //     ));
  //     update();
  //   }
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

  final SpeechToText speechToText = SpeechToText();

  bool speechEnabled = false;
  String wordsSpoken = "";

  // void initSpeech() async {
  //   speechEnabled = await speechToText.initialize();
  //   update();
  // }

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
      await speechToText.listen(
        onResult: onSpeechResult,
        listenMode: ListenMode.dictation,
        cancelOnError: true,
      );
    }
    update();
  }

  // void startListening() async {
  //   if (speechEnabled && !speechToText.isListening) {
  //     await speechToText.listen(
  //       onResult: onSpeechResult,
  //       listenMode: ListenMode.dictation,
  //       cancelOnError: true,
  //     );
  //   }
  //   update();
  // }

  void stopListening() async {
    if (speechToText.isListening) {
      await speechToText.stop();
    }
    update();
  }

  // onSpeechResult(SpeechRecognitionResult result) {
  //   wordsSpoken = result.recognizedWords;
  //   logger.i("Recognized Words: $wordsSpoken");
  //   handleAnswer();
  //   update();
  //   return wordsSpoken;
  // }

  onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      // Only process final results
      wordsSpoken = result.recognizedWords;
      logger.i("Final Recognized Words: $wordsSpoken");
      handleAnswer();
      update();
    } else {
      logger.i("Interim Result: ${result.recognizedWords}");
    }
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
          answer.replaceAll('.', ''),
          wordsSpoken,
          'Pass',
        );
      } else {
        await addRobotTopicFeature(
          AppStorage.getUserData()?.userId ?? '',
          question,
          answer.replaceAll('.', ''),
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
          answer.replaceAll('.', ''),
          wordsSpoken,
          'Fail',
        );
      } else {
        await addRobotTopicFeature(
          AppStorage.getUserData()?.userId ?? '',
          question,
          answer.replaceAll('.', ''),
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
