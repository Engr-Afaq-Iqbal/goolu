import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/DashboardController/dashboard_controller.dart';
import 'package:speech_to_text/speech_recognition_result.dart';
import 'package:speech_to_text/speech_to_text.dart';

import '../../Services/storage_sevices.dart';
import '../../Utils/utils.dart';
import '../../View/Dashboard/daily_task_service.dart';

class CameraSpeechController extends GetxController {
  File? file2;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  String? firebaseImageUrl;
  String? firebaseImageAnswer;
  bool isAnswerMatched = false;

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
  ///
  /// logic to shuffle

  Future<Map<String, dynamic>?> fetchNextFalseData(
      String collectionName) async {
    try {
      var featureRef = _firestore
          .collection(collectionName)
          .doc(AppStorage.getUserData()?.userId);

      int documentIndex = 0;
      List<Map<String, dynamic>> eligibleData = []; // Store eligible documents

      while (true) {
        var docRef = featureRef.collection(documentIndex.toString());
        var snapshot = await docRef.get();

        if (snapshot.docs.isEmpty) break;

        for (var doc in snapshot.docs) {
          Map<String, dynamic> data = doc.data();

          if (data['mainResult'] == 'false') {
            List<dynamic> answers = data['answers'];
            String imageUrl = data['url'];

            for (int answerIndex = 0;
                answerIndex < answers.length;
                answerIndex++) {
              var answer = answers[answerIndex];
              if (answer['result'] == 'false') {
                eligibleData.add({
                  'url': imageUrl,
                  'answerText': answer['text'],
                  'documentIndex': documentIndex,
                  'documentId': doc.id,
                  'answerIndex': answerIndex,
                });
              }
            }
          }
        }

        documentIndex++;
      }

      // Shuffle the eligible data to get a random result
      if (eligibleData.isNotEmpty) {
        eligibleData.shuffle();
        return eligibleData.first;
      }
    } catch (e) {
      logger.e('Error fetching data: $e');
    }

    update();
    return null;
  }

  ///in working
  // Future<Map<String, dynamic>?> fetchNextFalseData(
  //     String collectionName) async {
  //   try {
  //     var featureRef = _firestore
  //         .collection(collectionName) //'feature1CUsersPositive'
  //         .doc(AppStorage.getUserData()?.userId);
  //
  //     int documentIndex = 0; // Track document index
  //
  //     while (true) {
  //       // Access the nested collection dynamically based on documentIndex
  //       var docRef = featureRef.collection(documentIndex.toString());
  //
  //       // Get documents in the nested collection
  //       var snapshot = await docRef.get();
  //
  //       if (snapshot.docs.isEmpty) {
  //         // If no document exists for the current index, break the loop
  //         break;
  //       }
  //
  //       for (var doc in snapshot.docs) {
  //         Map<String, dynamic> data = doc.data();
  //
  //         // If mainResult is 'false', check answers
  //         if (data['mainResult'] == 'false') {
  //           List<dynamic> answers = data['answers'];
  //           String imageUrl = data['url'];
  //
  //           // Iterate over answers to find the first answer with result 'false'
  //           for (int answerIndex = 0;
  //               answerIndex < answers.length;
  //               answerIndex++) {
  //             var answer = answers[answerIndex];
  //             if (answer['result'] == 'false') {
  //               // Return the document data, answer text, and indexes
  //               return {
  //                 'url': imageUrl,
  //                 'answerText': answer['text'],
  //                 'documentIndex': documentIndex,
  //                 'documentId': doc.id,
  //                 'answerIndex': answerIndex,
  //               };
  //             }
  //           }
  //         }
  //       }
  //
  //       // Move to the next document index if current document's mainResult is 'true'
  //       documentIndex++;
  //     }
  //   } catch (e) {
  //     logger.e('Error fetching data: $e');
  //   }
  //
  //   update();
  //   return null; // Return null if no "false" document or answer is found
  // }

  // Future<void> uploadImageDataNegative(String userId, String imageUrl,
  //     List<Map<String, dynamic>> answers, int index) async {
  //   try {
  //     // Reference to Firestore
  //     final firestore = FirebaseFirestore.instance;
  //
  //     // Path: feature1C -> userId -> positive -> index
  //     await firestore
  //         .collection('feature1CDataNegative')
  //         .doc('negative')
  //         .collection('0') // Sub-collection named with the index as a string
  //         .doc('$index')
  //         .set({
  //       'url': imageUrl,
  //       'answers': answers,
  //       'mainResult': 'false',
  //     });
  //
  //     logger.i("Data uploaded successfully!");
  //   } catch (e) {
  //     logger.e("Error uploading data: $e");
  //   }
  //   update();
  // }

  void uploadSampleDataPositive() {
    String userId = '${AppStorage.getUserData()?.userId}';

    List<Map<String, dynamic>> dataList = [
      {
        'imageUrl':
            'https://drive.google.com/file/d/13C-OAYal9lMz_G92FHrsMQ96Tq0oO1yf',
        'index': 7,
        'answers': [
          {
            'text':
                'There is a teenager reading a book by the window, wrapped in a cozy blanket. He is making the most of a rainy day indoors.',
            'result': 'false'
          },
          {
            'text':
                'There is a boy sitting comfortably and reading while it rains outside. He is enjoying the peaceful moment.',
            'result': 'false'
          },
          {
            'text':
                'There is a young person reading a book with full focus. The rainy weather outside adds to the cozy atmosphere.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/11_fyXOrmK7WlT2gbxcMNiS_xOPd3hwrY',
        'index': 8,
        'answers': [
          {
            'text':
                'There is a girl riding her bike with a big smile. She seems to be enjoying the fresh air on her way to school.',
            'result': 'false'
          },
          {
            'text':
                'There is a teenager cycling down the street, looking happy. She is having a great start to her day.',
            'result': 'false'
          },
          {
            'text':
                'There is a young girl on a bike, wearing a helmet and smiling. She is enjoying the freedom of her ride.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1qgLFhNL52STOFBWqSczKyAGso6c3Couw',
        'index': 9,
        'answers': [
          {
            'text':
                'There is a family laughing together while sharing food at the table. The joyful moment is filled with love and happiness.',
            'result': 'false'
          },
          {
            'text':
                'There are parents and children enjoying a meal, all smiling and having a great time. Their laughter fills the room with warmth.',
            'result': 'false'
          },
          {
            'text':
                'There is a family gathered around the table, sharing stories and food with big smiles. Their bond is evident in this cheerful moment.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1DAa_aaXzskZmU29EQYx82nL88a8vhPsD',
        'index': 10,
        'answers': [
          {
            'text':
                'There is a young man smiling and holding papers during a lively meeting. He seems to be enjoying the productive discussion with his team.',
            'result': 'false'
          },
          {
            'text':
                'There is a person happily engaging in a meeting, surrounded by colleagues who are sharing ideas. The positive energy in the room is inspiring.',
            'result': 'false'
          },
          {
            'text':
                'There is a team member who is actively participating and smiling in the meeting. It’s clear that the collaboration is going well.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1ZoSIfrSphC2L6xoJImlkYPXcn8FtixlG',
        'index': 11,
        'answers': [
          {
            'text':
                'There is a waiter serving a delicious meal to a couple, who are smiling in appreciation. The interaction is warm and welcoming.',
            'result': 'false'
          },
          {
            'text':
                'There is a server presenting a dish with a big smile, while the diners express their gratitude. This makes the dining experience more special.',
            'result': 'false'
          },
          {
            'text':
                'There is a waiter delivering a meal with care, and the customers are clearly pleased. This moment adds to the pleasant atmosphere of the restaurant.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1zAZtxl-UG83j4WDIhKtxImbJF-rKMgEH',
        'index': 12,
        'answers': [
          {
            'text':
                'There are two friends sitting at a restaurant, smiling and enjoying appetizers. They are having a great time together.',
            'result': 'false'
          },
          {
            'text':
                'There are two women chatting at a cozy table, with delicious snacks in front of them. They seem to be enjoying their time out.',
            'result': 'false'
          },
          {
            'text':
                'There are friends sharing a light moment over some appetizers. They are waiting for others to join them and having fun.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/15g8vhMdttz-8GRpQwc3MdKUYc4dXLmtx',
        'index': 13,
        'answers': [
          {
            'text':
                'There is a man sitting on a sofa, working on his laptop in a warmly lit room. He is focused and comfortable in his cozy space.',
            'result': 'false'
          },
          {
            'text':
                'There is a young man typing on his laptop in a relaxed setting. He is enjoying a productive evening at home.',
            'result': 'false'
          },
          {
            'text':
                'There is someone working on a laptop, surrounded by a calming atmosphere. The setting is perfect for focused work.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1k6nUzxPHNl2H1BWMtoHV9QfTcGRkJvbW',
        'index': 14,
        'answers': [
          {
            'text':
                'There is a woman walking outdoors, dressed smartly in a suit. She is enjoying a refreshing break from her busy day.',
            'result': 'false'
          },
          {
            'text':
                'There is a professional taking a stroll through a green park. She seems to be recharging her energy during a break.',
            'result': 'false'
          },
          {
            'text':
                'There is a young woman walking confidently in a business suit. She is making the most of her break in a serene setting.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1HrnHlvaPeBtpApSH9F8o2Qe-h0DTRSVf',
        'index': 15,
        'answers': [
          {
            'text':
                'There are three friends sitting on a bench, working together on their notes. They are enjoying studying outside on a sunny day.',
            'result': 'false'
          },
          {
            'text':
                'There are students collaborating on a project in the park. They seem to be focused and making the most of their study time.',
            'result': 'false'
          },
          {
            'text':
                'There are three young people writing in their notebooks, sharing ideas and learning together. It looks like they are having a productive study session outdoors.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1RUMCW9hMptLKz5pzfbvebCZnP_FLAOLL',
        'index': 16,
        'answers': [
          {
            'text':
                'They are sitting at a table, writing notes from open books. They seem to be preparing for a project.',
            'result': 'false'
          },
          {
            'text':
                'The group is working together, focusing on their studies with concentration. It appears they are collaborating on an assignment.',
            'result': 'false'
          },
          {
            'text':
                'They are studying in a quiet office, sharing ideas and writing down important points. A sense of teamwork is evident.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/19pJTJELYoRg4RlFh_7Q8EELdRxhd-az3',
        'index': 17,
        'answers': [
          {
            'text':
                'She is sitting on the floor, typing on her laptop with books spread around her. The room is cozy with warm lighting.',
            'result': 'false'
          },
          {
            'text':
                'She is deeply focused on her screen, surrounded by study materials. It feels like she is preparing for an exam.',
            'result': 'false'
          },
          {
            'text':
                'The woman is studying in her room, using her laptop while notes and books are scattered nearby. Her concentration is evident.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1Lt7USf2G6hg1BBwPipFw4B38BweQXcnx',
        'index': 18,
        'answers': [
          {
            'text':
                ' The cat is comfortably sleeping on a soft sofa, looking peaceful. The room feels calm and inviting.',
            'result': 'false'
          },
          {
            'text':
                'The fluffy cat is curled up on the couch, enjoying a quiet nap. The space around is neat and cozy.',
            'result': 'false'
          },
          {
            'text':
                'It is a lazy day for the cat, napping on the sofa in a serene and warm living room. The scene radiates tranquility.',
            'result': 'false'
          },
        ],
      },
    ];

    for (var data in dataList) {
      uploadImageData(userId, data['imageUrl'], data['answers'], data['index']);
    }
  }

  Future<void> uploadImageData(String userId, String imageUrl,
      List<Map<String, dynamic>> answers, int index) async {
    try {
      final firestore = FirebaseFirestore.instance;

      await firestore
          .collection('feature1CDataPositive')
          .doc('positive')
          .collection('0') // Using index as a string
          .doc('$index')
          .set({
        'url': imageUrl,
        'answers': answers,
        'mainResult': 'false',
      });

      logger.i("Data uploaded successfully for index $index!");
    } catch (e) {
      logger.e("Error uploading data for index $index: $e");
    }
  }

  // Future<void> uploadImageData(String userId, String imageUrl,
  //     List<Map<String, dynamic>> answers, int index) async {
  //   try {
  //     // Reference to Firestore
  //     final firestore = FirebaseFirestore.instance;
  //
  //     // Path: feature1C -> userId -> positive -> index
  //     await firestore
  //         .collection('feature1CDataPositive')
  //         .doc('positive')
  //         .collection('0') // Sub-collection named with the index as a string
  //         .doc('$index')
  //         .set({
  //       'url': imageUrl,
  //       'answers': answers,
  //       'mainResult': 'false',
  //     });
  //
  //     logger.i("Data uploaded successfully!");
  //   } catch (e) {
  //     logger.e("Error uploading data: $e");
  //   }
  //   update();
  // }

  // void uploadSampleDataPositive() {
  //   String userId = '${AppStorage.getUserData()?.userId}';
  //   //https://drive.google.com/file/d/1HXoGjw-ed0eE5-21LAJb5i0-U3wyejMB/view?usp=sharing
  //   String imageUrl =
  //       'https://drive.google.com/file/d/19Wbw2wWUm1D8mJXQHY5p-_SXjCksXCTC';
  //   int index =
  //       4; // This is the index for the document in the 'positive' sub-collection
  //
  //   List<Map<String, dynamic>> answers = [
  //     {
  //       'text':
  //           'There is a family playing a board game together at the airport. They are making the most of their waiting time with fun',
  //       'result': 'false',
  //     },
  //     {
  //       'text':
  //           'There are parents and their kids gathered around a game at an airport table. This family knows how to turn waiting into a joyful experience.',
  //       'result': 'false',
  //     },
  //     {
  //       'text':
  //           'There is a family happily playing a game while waiting at the airport. Their laughter suggests they are having a great time together',
  //       'result': 'false',
  //     },
  //   ];
  //
  //   uploadImageData(userId, imageUrl, answers, index);
  //   update();
  // }

  // void uploadSampleDataNegative() {
  //   String userId = '${AppStorage.getUserData()?.userId}';
  //   String imageUrl =
  //       'https://drive.google.com/file/d/1u8R1ckOF4krzN9UvgdVbkDbkayVvzlg2';
  //   int index =
  //       4; // This is the index for the document in the 'positive' sub-collection
  //
  //   List<Map<String, dynamic>> answers = [
  //     {
  //       'text':
  //           'There is a toddler crying loudly in a shopping area. It looks like they are upset about something',
  //       'result': 'false',
  //     },
  //     {
  //       'text':
  //           'There is a toddler crying loudly in a shopping area. It looks like they are upset about something.',
  //       'result': 'false',
  //     },
  //     {
  //       'text':
  //           'There is a young child standing and crying in the mall. It looks like they are having a bad day',
  //       'result': 'false',
  //     },
  //   ];
  //
  //   uploadImageDataNegative(userId, imageUrl, answers, index);
  //   update();
  // }

  void uploadAllSampleDataNegative() {
    String userId = '${AppStorage.getUserData()?.userId}';

    List<Map<String, dynamic>> dataList = [
      {
        'imageUrl':
            'https://drive.google.com/file/d/1ioxXKzMKrHqG8es95X8bcOzuF2q6tWND',
        'index': 0,
        'answers': [
          {
            'text':
                'There is a doctor helping a young girl with her medicine. It looks like the girl is not sure but might take it.',
            'result': 'false'
          },
          {
            'text':
                'There is a child sitting on a bed, holding a cup. It seems like the doctor is helping her take the medicine.',
            'result': 'false'
          },
          {
            'text':
                'There is a doctor with a child, giving her medicine. It looks like they are in a busy hospital.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1PZiiMyS4X0lJGPmQjrEBeTCbwPQcXxwe',
        'index': 1,
        'answers': [
          {
            'text':
                'There is a family sitting on a couch. They are all using their phones and a laptop.',
            'result': 'false'
          },
          {
            'text':
                'There is a boy looking at a phone, sitting with two adults. It looks like they are busy with their screens.',
            'result': 'false'
          },
          {
            'text':
                'There are three people sitting close together. It seems like they are all focused on their phones or laptop.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1TQEp_LJIqVXrtVeR4WDCa8g8iEvRerL5',
        'index': 2,
        'answers': [
          {
            'text':
                'There is a student holding a paper with grades. It looks like she is not happy with her results.',
            'result': 'false'
          },
          {
            'text':
                'There is a girl sitting in a classroom, showing her test. It seems like she did not get the marks she wanted.',
            'result': 'false'
          },
          {
            'text':
                'There is a student with a sad face, holding her report. It looks like she is worried about her grades.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1JncxzxSTQ1olYw6kS9gIJ3lScd-RAf4T',
        'index': 3,
        'answers': [
          {
            'text':
                'There is a boy standing by a window. It looks like he is watching the rain outside',
            'result': 'false'
          },
          {
            'text':
                'There is a teenager looking out of the window. It seems like he is waiting for the rain to stop.',
            'result': 'false'
          },
          {
            'text':
                'There is a boy with wet hair standing near a window. It looks like he wants to go outside but it is raining',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1u8R1ckOF4krzN9UvgdVbkDbkayVvzlg2',
        'index': 4,
        'answers': [
          {
            'text':
                'There is a toddler crying loudly in a shopping area. It looks like they are upset about something.',
            'result': 'false'
          },
          {
            'text':
                'There is a little child wearing a yellow shirt, having a tantrum. It seems like they do not want to be there.',
            'result': 'false'
          },
          {
            'text':
                'There is a young child standing and crying in the mall. It looks like they are having a bad day.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1c7xD2tsxzJw6pZazUqK5H72kYEF6CVz1',
        'index': 5,
        'answers': [
          {
            'text':
                'There is a young boy sitting at the table, looking sad. It seems like he does not want to eat his food.',
            'result': 'false'
          },
          {
            'text':
                'There is a child sitting with a plate of food in front of him. It looks like he is not happy with his meal.',
            'result': 'false'
          },
          {
            'text':
                'There is a boy at the table while people are busy in the kitchen. It seems like he feels left out or upset.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1ZXI7HraFzNJ1aKlUQooElrtmdOc68Dpk',
        'index': 6,
        'answers': [
          {
            'text':
                'There is a girl holding a stuffed toy while looking at a boy. It seems like they are having a disagreement over the toy',
            'result': 'false'
          },
          {
            'text':
                'There is a boy and a girl standing close, both looking serious. It looks like they are talking about sharing the toy.',
            'result': 'false'
          },
          {
            'text':
                'There are two kids in a room filled with toys. It seems like they are trying to decide who gets to play with the stuffed animal.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1B8N5MnX1PeKlZ3TKlh0e2DOV0ZT4Ljga',
        'index': 7,
        'answers': [
          {
            'text':
                'There are people sitting around a table, looking stressed and tired. It seems like they are having a difficult meeting.',
            'result': 'false'
          },
          {
            'text':
                'There is a group of colleagues with their heads down, focused on papers. It looks like they are working hard to solve a problem.',
            'result': 'false'
          },
          {
            'text':
                'There is a team gathered around a laptop with worried faces. It seems like they are discussing something important and challenging',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/17RMaHOKv5Y5wbd3U8jvoLMdwLqU6v7l3',
        'index': 8,
        'answers': [
          {
            'text':
                'There is a family standing at the airport, looking down. It seems like they are disappointed about something',
            'result': 'false'
          },
          {
            'text':
                'There is a boy with his parents at the airport. It looks like they are waiting for their flight.',
            'result': 'false'
          },
          {
            'text':
                'There are three people standing together, holding bags. It seems like their flight might be delayed',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1OdZ9DBabHyLk6c2ipXxMG1TO2YTsk3yB',
        'index': 9,
        'answers': [
          {
            'text':
                'There is a family sitting at the dinner table, eating together. It looks like they are having a quiet meal',
            'result': 'false'
          },
          {
            'text':
                'There is a boy sitting at the table with his family. It seems like they are focused on their food.',
            'result': 'false'
          },
          {
            'text':
                'There are two children and two adults at the table, eating dinner. It looks like they are enjoying a family meal despite the mess on the floor.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1xO4nu2B2FpJzB2FyjpheBj_BCuNEkYPL',
        'index': 10,
        'answers': [
          {
            'text':
                'There are four friends sitting at a restaurant table, talking to each other. It looks like they are waiting for more people to join them.',
            'result': 'false'
          },
          {
            'text':
                'There is a group of young men sitting together at a dining table. It seems like they are enjoying their time before the meal arrives.',
            'result': 'false'
          },
          {
            'text':
                'There are four people sitting at a table in a cozy restaurant. It looks like they are waiting for their food or guests to arrive',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1AMGpPH0q874yi1JP-E4-6iuO2_UWMyS2',
        'index': 11,
        'answers': [
          {
            'text':
                'There is a man sitting at his desk, looking very tired. It seems like he is stressed about his work.',
            'result': 'false'
          },
          {
            'text':
                'There is a man in an office, resting his arms on the table. It looks like he is having a difficult day.',
            'result': 'false'
          },
          {
            'text':
                'There is a person sitting alone at his desk, with a serious expression. It seems like he is thinking about a problem.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1AjYmZhY_BeqUiI1gMqWscIhQySXuLPCZ',
        'index': 12,
        'answers': [
          {
            'text':
                'There is a man standing with his shopping cart in a long queue. It looks like he is waiting to pay at the grocery store.',
            'result': 'false'
          },
          {
            'text':
                'There is a woman behind the counter, looking at the man with the cart. It seems like the line is moving slowly.',
            'result': 'false'
          },
          {
            'text':
                'There is a person at the grocery checkout, waiting with a full cart. It looks like he is ready to check out but the queue is long.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1peuTSSZr2E87RVhJyblWs56PAqs8njox',
        'index': 13,
        'answers': [
          {
            'text':
                'There is a man standing by the road next to his car, looking concerned. It seems like he is waiting for help.',
            'result': 'false'
          },
          {
            'text':
                'There is a person with his hands on his hips, standing near a car on the roadside. It looks like he has a problem with his car.',
            'result': 'false'
          },
          {
            'text':
                'There is a man standing beside his car on a long empty road. It seems like he might have a flat tire and needs assistance',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1W48-q5MxXPtDnVMOB84RQhAeJIBNc6Vz',
        'index': 14,
        'answers': [
          {
            'text':
                'There is a boy standing on the sidewalk, looking at the school bus driving away. It seems like he missed his bus.',
            'result': 'false'
          },
          {
            'text':
                'There is a child with a backpack, standing near the road. It looks like he is disappointed because the bus left without him.',
            'result': 'false'
          },
          {
            'text':
                'There is a school bus in the distance, and a boy watching it leave. It seems like he will need another way to get to school.',
            'result': 'false'
          },
        ],
      },
      {
        'imageUrl':
            'https://drive.google.com/file/d/1TsT3nITiTN6s8yKR8FlAnoAbBr-oT9LN',
        'index': 15,
        'answers': [
          {
            'text':
                'There is a fluffy cat sitting on the floor, surrounded by scattered food. It seems like the cat has knocked over the snack bag.',
            'result': 'false'
          },
          {
            'text':
                'There is a cat looking directly at the camera with a serious expression. It looks like it might have caused the mess around it',
            'result': 'false'
          },
          {
            'text':
                'There is a cat sitting near an open bag of treats and some scattered toys. It seems like it is not happy about the situation',
            'result': 'false'
          },
        ],
      }
    ];

    for (var data in dataList) {
      uploadImageDataNegative(
          userId, data['imageUrl'], data['answers'], data['index']);
    }
  }

  Future<void> uploadImageDataNegative(String userId, String imageUrl,
      List<Map<String, dynamic>> answers, int index) async {
    try {
      final firestore = FirebaseFirestore.instance;

      await firestore
          .collection('feature1CDataNegative')
          .doc('negative')
          .collection('0') // Using index as a string
          .doc('$index')
          .set({
        'url': imageUrl,
        'answers': answers,
        'mainResult': 'false',
      });

      logger.i("Data uploaded successfully for index $index!");
    } catch (e) {
      logger.e("Error uploading data for index $index: $e");
    }
  }

  final SpeechToText speechToText = SpeechToText();
  String wordsSpoken = '';
  bool speechEnabled = false;

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
      logger.i("Speech Enabled: $speechEnabled");
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
        localeId: 'en-US',
      );
      logger.i("Listening started...");
    }
    update();
  }

  void stopListening() async {
    if (speechToText.isListening) {
      await speechToText.stop();
      logger.i("Listening stopped.");
    }
    update();
  }

  void onSpeechResult(SpeechRecognitionResult result) {
    if (result.finalResult) {
      wordsSpoken = result.recognizedWords.trim();
      logger.i("Final Recognized Words: $wordsSpoken");
      matchSpokenAndAnswerText(wordsSpoken);
      update();
    } else {
      logger.i("Interim Result: ${result.recognizedWords}");
    }
  }

  void matchSpokenAndAnswerText(String spokenWords) async {
    logger.i(
        'Expected Answer: ${firebaseImageAnswer?.replaceAll('.', '').toLowerCase()}');
    logger.i('Spoken Words: $wordsSpoken');

    String normalizedExpectedAnswer =
        firebaseImageAnswer?.replaceAll(RegExp(r'[.,\s]+'), '').toLowerCase() ??
            '';
    String normalizedSpokenWords =
        spokenWords.replaceAll(RegExp(r'[.,\s]+'), '').toLowerCase();
    logger.i('normalizedSpokenWords -->> $normalizedSpokenWords');
    logger.i('normalizedExpectedAnswer -->> $normalizedExpectedAnswer');

    if (normalizedSpokenWords == normalizedExpectedAnswer) {
      updateAnswerResultToTrue();
      logger.i('Answer matched');
      DailyTaskService taskService = DailyTaskService();

      // Update the "image_description" task to true
      await taskService.updateTaskStatus(
          AppStorage.getUserData()?.userId ?? '', 'image_description', true);

      isResult = true;
      isAnswerMatched = true;
      update();
      Get.find<DashboardController>().fetchDailyTasks();
    } else {
      showToast('Try Again! Recording did not match');
      isResult = false;
      isRecordPressed = false;
      update();
    }

    update();
  }
  // matchSpokenAndAnswerText() async {
  //   logger.i('Answer = ${firebaseImageAnswer?.replaceAll('.', '')}');
  //   logger.i('Spoken words = $wordsSpoken');
  //   String replacedDot =
  //       firebaseImageAnswer?.replaceAll('.', '').toLowerCase() ?? '';
  //   String replacedComma = replacedDot.replaceAll(',', '').toLowerCase();
  //   if (wordsSpoken.toLowerCase() == replacedComma) {
  //     // await addRobotGeneralFeature(
  //     //   AppStorage.getUserData()?.userId ?? '',
  //     //   question,
  //     //   '${answer.replaceAll('.', '')}',
  //     //   wordsSpoken,
  //     //   'Pass',
  //     // );
  //     updateAnswerResultToTrue();
  //     logger.i('Answer matched');
  //     DailyTaskService taskService = DailyTaskService();
  //
  //     // Update the "image_description" task to true
  //     await taskService.updateTaskStatus(
  //         AppStorage.getUserData()?.userId ?? '', 'image_description', true);
  //     isResult = true;
  //     update();
  //     Get.find<DashboardController>().fetchDailyTasks();
  //   } else {
  //     showToast('Try Again! Recording did not matched');
  //
  //     isResult = false;
  //     isRecordPressed = false;
  //     update();
  //   }
  //
  //   // stopProgress();
  //   update();
  // }

  bool isRecordPressed = false;
  bool isResult = false;

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
    final userFeature1CRef =
        firestore.collection('feature1CUsersPositive').doc(userId);

    try {
      // Check if data already exists for the user
      final existingData = await userFeature1CRef.collection('0').get();

      if (existingData.docs.isNotEmpty) {
        logger.i("Data already exists for feature1CUsersPositive/$userId");
        return;
      }

      // Reference to the original data collection
      final feature1CDataRef =
          firestore.collection('feature1CDataPositive').doc('positive');
      final subCollections = await feature1CDataRef.collection('0').get();

      for (var subDoc in subCollections.docs) {
        final docData = subDoc.data();
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
    final userFeature1CRef =
        firestore.collection('feature1CUsersNegative').doc(userId);

    try {
      // Check if data already exists for the user
      final existingData = await userFeature1CRef.collection('0').get();

      if (existingData.docs.isNotEmpty) {
        logger.i("Data already exists for feature1CUsersNegative/$userId");
        return;
      }

      // Reference to the original data collection
      final feature1CDataRef =
          firestore.collection('feature1CDataNegative').doc('negative');
      final subCollections = await feature1CDataRef.collection('0').get();

      for (var subDoc in subCollections.docs) {
        final docData = subDoc.data();
        await userFeature1CRef.collection('0').doc(subDoc.id).set(docData);
      }

      logger.i("Data copied successfully to feature1CUsersNegative/$userId");
    } catch (e) {
      logger.i("Error copying data: $e");
    }
  }
}
