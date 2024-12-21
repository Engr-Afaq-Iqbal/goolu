import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/DashboardController/dashboard_controller.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../Services/storage_sevices.dart';
import '../../Utils/utils.dart';
import '../../View/Dashboard/daily_task_service.dart';

class CameraSpeechController extends GetxController {
  File? file2;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? firebaseImageUrl;
  String? firebaseImageAnswer;

  /// Function to fetch only the first "false" document in sequence

  int documentIndex = 0;
  int answerIndex = 0;
  int docId = 0;

  ///logic updated
  void fetchAndDisplayData({bool isCollectionPositive = true}) async {
    Map<String, dynamic>? data;
    if (isCollectionPositive == true) {
      data = await fetchNextFalseData('feature1CUsersPositive');
    } else {
      data = await fetchNextFalseData('feature1CUsersNegative');
    }

    if (data != null) {
      logger.i('Image URL: ${data['url']}');
      firebaseImageUrl = '${data['url']}';
      logger.i('First false answer: ${data['answerText']}');
      firebaseImageAnswer = '${data['answerText']}';
      documentIndex = data['documentIndex'];
      answerIndex = data['answerIndex'];
      docId = int.parse('${data['documentId']}');
      logger.i('Document Index = ${data['documentIndex']}');
      logger.i('Answer Index = ${data['answerIndex']}');
      logger.i('Doc Id = ${data['documentId']}');
      update();
    } else {
      logger.e('No data with mainResult as false or no false answer found.');
    }
  }

  /// Function to fetch the first document with mainResult as "false"
  /// and the first answer with result as "false"
  ///in working

  Future<Map<String, dynamic>?> fetchNextFalseData(
      String collectionName) async {
    try {
      var featureRef = _firestore
          .collection(collectionName) //'feature1CUsersPositive'
          .doc(AppStorage.getUserData()?.userId);

      int documentIndex = 0; // Track document index

      while (true) {
        // Access the nested collection dynamically based on documentIndex
        var docRef = featureRef.collection(documentIndex.toString());

        // Get documents in the nested collection
        var snapshot = await docRef.get();

        if (snapshot.docs.isEmpty) {
          // If no document exists for the current index, break the loop
          break;
        }

        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data();

          // If mainResult is 'false', check answers
          if (data['mainResult'] == 'false') {
            List<dynamic> answers = data['answers'];
            String imageUrl = data['url'];

            // Iterate over answers to find the first answer with result 'false'
            for (int answerIndex = 0;
                answerIndex < answers.length;
                answerIndex++) {
              var answer = answers[answerIndex];
              if (answer['result'] == 'false') {
                // Return the document data, answer text, and indexes
                return {
                  'url': imageUrl,
                  'answerText': answer['text'],
                  'documentIndex': documentIndex,
                  'documentId': doc.id,
                  'answerIndex': answerIndex,
                };
              }
            }
          }
        }

        // Move to the next document index if current document's mainResult is 'true'
        documentIndex++;
      }
    } catch (e) {
      logger.e('Error fetching data: $e');
    }

    update();
    return null; // Return null if no "false" document or answer is found
  }

  Future<void> uploadImageDataNegative(String userId, String imageUrl,
      List<Map<String, dynamic>> answers, int index) async {
    try {
      // Reference to Firestore
      final firestore = FirebaseFirestore.instance;

      // Path: feature1C -> userId -> positive -> index
      await firestore
          .collection('feature1CDataNegative')
          .doc('negative')
          .collection('0') // Sub-collection named with the index as a string
          .doc('$index')
          .set({
        'url': imageUrl,
        'answers': answers,
        'mainResult': 'false',
      });

      logger.i("Data uploaded successfully!");
    } catch (e) {
      logger.e("Error uploading data: $e");
    }
    update();
  }

  Future<void> uploadImageData(String userId, String imageUrl,
      List<Map<String, dynamic>> answers, int index) async {
    try {
      // Reference to Firestore
      final firestore = FirebaseFirestore.instance;

      // Path: feature1C -> userId -> positive -> index
      await firestore
          .collection('feature1CDataPositive')
          .doc('positive')
          .collection('0') // Sub-collection named with the index as a string
          .doc('$index')
          .set({
        'url': imageUrl,
        'answers': answers,
        'mainResult': 'false',
      });

      logger.i("Data uploaded successfully!");
    } catch (e) {
      logger.e("Error uploading data: $e");
    }
    update();
  }

  void uploadSampleDataPositive() {
    String userId = '${AppStorage.getUserData()?.userId}';
    //https://drive.google.com/file/d/1HXoGjw-ed0eE5-21LAJb5i0-U3wyejMB/view?usp=sharing
    String imageUrl =
        'https://drive.google.com/file/d/19Wbw2wWUm1D8mJXQHY5p-_SXjCksXCTC';
    int index =
        4; // This is the index for the document in the 'positive' sub-collection

    List<Map<String, dynamic>> answers = [
      {
        'text':
            'There is a family playing a board game together at the airport. They are making the most of their waiting time with fun',
        'result': 'false',
      },
      {
        'text':
            'There are parents and their kids gathered around a game at an airport table. This family knows how to turn waiting into a joyful experience.',
        'result': 'false',
      },
      {
        'text':
            'There is a family happily playing a game while waiting at the airport. Their laughter suggests they are having a great time together',
        'result': 'false',
      },
    ];

    uploadImageData(userId, imageUrl, answers, index);
    update();
  }

  void uploadSampleDataNegative() {
    String userId = '${AppStorage.getUserData()?.userId}';
    //https://drive.google.com/file/d/1HXoGjw-ed0eE5-21LAJb5i0-U3wyejMB/view?usp=sharing
    String imageUrl =
        'https://drive.google.com/file/d/1u8R1ckOF4krzN9UvgdVbkDbkayVvzlg2'; //https://drive.google.com/uc?id=1HXoGjw-ed0eE5-21LAJb5i0-U3wyejMB
    int index =
        4; // This is the index for the document in the 'positive' sub-collection

    List<Map<String, dynamic>> answers = [
      {
        'text':
            'There is a toddler crying loudly in a shopping area. It looks like they are upset about something',
        'result': 'false',
      },
      {
        'text':
            'There is a toddler crying loudly in a shopping area. It looks like they are upset about something.',
        'result': 'false',
      },
      {
        'text':
            'There is a young child standing and crying in the mall. It looks like they are having a bad day',
        'result': 'false',
      },
    ];

    uploadImageDataNegative(userId, imageUrl, answers, index);
    update();
  }

  final SpeechToText speechToText = SpeechToText();
  TextEditingController wordsSpoken = TextEditingController();
  bool speechEnabled = false;
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
    wordsSpoken.text = "${result.recognizedWords}";
    update();
  }

  bool isRecordPressed = false;
  bool isResult = false;

  matchSpokenAndAnswerText() async {
    logger.i('Answer = ${firebaseImageAnswer?.replaceAll('.', '')}');
    logger.i('Spoken words = ${wordsSpoken.text}');
    String replacedDot =
        firebaseImageAnswer?.replaceAll('.', '').toLowerCase() ?? '';
    String replacedComma = replacedDot.replaceAll(',', '').toLowerCase();
    if (wordsSpoken.text.toLowerCase() == replacedComma) {
      // await addRobotGeneralFeature(
      //   AppStorage.getUserData()?.userId ?? '',
      //   question,
      //   '${answer.replaceAll('.', '')}',
      //   wordsSpoken,
      //   'Pass',
      // );
      updateAnswerResultToTrue();
      logger.i('Answer matched');
      DailyTaskService taskService = DailyTaskService();

      // Update the "image_description" task to true
      await taskService.updateTaskStatus(
          AppStorage.getUserData()?.userId ?? '', 'image_description', true);
      isResult = true;
      update();
      Get.find<DashboardController>().fetchDailyTasks();
    } else {
      showToast('Try Again! Recording did not matched');

      isResult = false;
      isRecordPressed = false;
      update();
    }

    // stopProgress();
    update();
  }

  Future<void> updateAnswerResultToTrue() async {
    try {
      var docRef = _firestore
          .collection('feature1CUsersPositive')
          .doc(AppStorage.getUserData()?.userId)
          .collection(documentIndex.toString())
          .doc('$docId'); // Replace with actual document ID if needed

      var snapshot = await docRef.get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        List<dynamic> answers = data['answers'];

        if (answerIndex < answers.length) {
          answers[answerIndex]['result'] = 'true';

          // Update the answer's result in Firestore
          await docRef.update({
            'answers': answers,
          });

          logger.i('Answer result updated to true.');
        }
      }
    } catch (e) {
      logger.e('Error updating answer result: $e');
    }
    checkAndUpdateMainResult();
  }

  /// Function to check if all answers' results are "true" and update mainResult
  Future<void> checkAndUpdateMainResult() async {
    try {
      var docRef = _firestore
          .collection('feature1CUsersPositive')
          .doc(AppStorage.getUserData()?.userId)
          .collection(documentIndex.toString())
          .doc('$docId'); // Replace with actual document ID if needed

      var snapshot = await docRef.get();
      if (snapshot.exists) {
        Map<String, dynamic> data = snapshot.data()!;
        List<dynamic> answers = data['answers'];

        // Check if all answers have 'result' set to 'true'
        bool allTrue = answers.every((answer) => answer['result'] == 'true');

        // If all answers are 'true', update mainResult to 'true'
        if (allTrue) {
          await docRef.update({
            'mainResult': 'true',
          });

          logger.i('mainResult updated to true.');
        }
      }
    } catch (e) {
      logger.e('Error checking and updating mainResult: $e');
    }
  }

  ///Logic to store each users positive and negative record with there id separately

  ///initially store the data for each user Positive
  Future<void> copyFeature1CDataForUserPositive() async {
    final firestore = FirebaseFirestore.instance;
    final currentUser = AppStorage.getUserData()?.userId;

    if (currentUser == null) {
      logger.i("User is not signed in");
      return;
    }

    final userId = currentUser;

    try {
      // Reference to the original data collection
      final feature1CDataRef =
          firestore.collection('feature1CDataPositive').doc('positive');
      // Reference to the user's data in the new collection
      final userFeature1CRef =
          firestore.collection('feature1CUsersPositive').doc(userId);

      // Fetch each sub-collection in `feature1CDataPositive/positive`
      final subCollections = await feature1CDataRef.collection('0').get();

      // Loop through each sub-collection and document to copy data
      for (var subDoc in subCollections.docs) {
        // Fetch data in the sub-collection document
        final docData = subDoc.data();

        // Write data to the user's document in the new collection
        await userFeature1CRef.collection('0').doc(subDoc.id).set(docData);
      }

      logger.i("Data copied successfully to feature1CUsersPositive/$userId");
    } catch (e) {
      logger.i("Error copying data: $e");
    }
  }

  Future<void> copyFeature1CDataForUserNegative() async {
    final firestore = FirebaseFirestore.instance;
    final currentUser = AppStorage.getUserData()?.userId;

    if (currentUser == null) {
      logger.i("User is not signed in");
      return;
    }

    final userId = currentUser;

    try {
      // Reference to the original data collection
      final feature1CDataRef =
          firestore.collection('feature1CDataNegative').doc('negative');
      // Reference to the user's data in the new collection
      final userFeature1CRef =
          firestore.collection('feature1CUsersNegative').doc(userId);

      // Fetch each sub-collection in `feature1CData/positive`
      final subCollections = await feature1CDataRef.collection('0').get();

      // Loop through each sub-collection and document to copy data
      for (var subDoc in subCollections.docs) {
        // Fetch data in the sub-collection document
        final docData = subDoc.data();

        // Write data to the user's document in the new collection
        await userFeature1CRef.collection('0').doc(subDoc.id).set(docData);
      }

      logger.i("Data copied successfully to feature1CUsersNegative/$userId");
    } catch (e) {
      logger.i("Error copying data: $e");
    }
  }
}
