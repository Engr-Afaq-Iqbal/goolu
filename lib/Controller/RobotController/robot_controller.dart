import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:goolu/Model/generate_answers_model.dart';
import 'package:goolu/Model/question_and_answer_model.dart';
import 'package:goolu/View/RobotPage/GeneralFeature/robot_general.dart';
import 'package:goolu/View/RobotPage/SituationFeature/robot_situation.dart';
import 'package:goolu/View/RobotPage/TopicFeature/robot_topic.dart';

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
}
