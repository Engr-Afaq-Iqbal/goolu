import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:csv/csv.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:goolu/Services/storage_sevices.dart';
import 'package:intl/intl.dart';

import '../../Utils/utils.dart';

class DashboardController extends GetxController {
  // List of words
  List<String> words = [];

  int showResult = 0;

  // Track selected words in the correct order
  List<String> selectedWordList = [];

  // Track whether the word is selected or not
  List<bool> isSelected = List.generate(5, (index) => false);
  // Update the selected word when tapping on the container
  void toggleWordSelection(int index) {
    if (isSelected[index]) {
      // If the word is already selected, remove it from the list
      selectedWordList.remove(words[index]);
      isSelected[index] = false;
    } else {
      // If the word is not selected, add it to the end of the list
      selectedWordList.add(words[index]);
      isSelected[index] = true;
    }

    update();
  }

  // Reset the isSelected list
  void resetSelection() {
    for (int i = 0; i < isSelected.length; i++) {
      isSelected[i] = false;
    }

    // Clear the selectedWordList if needed
    selectedWordList.clear();

    // Update the state
    update();
  }

  checkLists() async {
    bool result = areListsEqual(correctSentence, selectedWordList);
    if (result == true) {
      logger.i('True');
      await storeWordResult(result: 'Pass');
      showResult = 1;
      stopProgress();
    } else {
      logger.i('False');
      await storeWordResult(result: 'Fail');
      showResult = 2;
      stopProgress();
    }
    update();
  }

  bool areListsEqual(List<String> list1, List<String> list2) {
    // Check if both lists have the same length
    if (list1.length != list2.length) {
      return false;
    }

    // Compare elements at each index
    for (int i = 0; i < list1.length; i++) {
      if (list1[i] != list2[i]) {
        return false;
      }
    }

    // If no mismatch found, the lists are equal
    return true;
  }

  ///logic to uplaod the file
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  bool isUploading = false;

  Future<void> uploadWordsToFirestore() async {
    isUploading = true;
    update();

    // Load CSV data from assets
    final rawData = await rootBundle.loadString("assets/word.csv");
    List<List<dynamic>> rows = const CsvToListConverter().convert(rawData);

    for (int i = 1; i < rows.length; i++) {
      String day = (i).toString(); // Use the row number as the document ID
      String word = rows[i][0];
      String sentence = rows[i][1];
      String jumbledSentence = rows[i][2];

      // Upload each row to Firestore
      await firestore.collection("dailyWords").doc(day).set({
        "word": word,
        "sentence": sentence,
        "jumbledSentence": jumbledSentence,
      });
    }

    isUploading = false;
    update();

    showToast('Data uploaded successfully!');
  }

  String? word;
  String? sentence;
  String? jumpedSentence;
  bool isLoading2 = true;
  List<String> correctSentence = [];

  Future<void> fetchDailyWord() async {
    isLoading2 = true;
    update(); // Notify listeners about loading state

    // Get the current day of the year (1 to 365)
    final int dayOfYear = int.parse(DateFormat("D").format(DateTime.now()));
    logger.i('Day of the Year $dayOfYear');

    try {
      // Retrieve the document with the ID equal to the current day of the year
      DocumentSnapshot doc =
          await firestore.collection("dailyWords").doc('$dayOfYear').get();

      if (doc.exists) {
        word = doc['word'];
        sentence = doc['sentence'];
        jumpedSentence = doc['jumbledSentence'];
        logger.i(word);
        logger.i(sentence);
        logger.i(jumpedSentence);
        correctSentence = sentence?.split(" ") ?? [];
        List<String> wordsList = jumpedSentence?.split(" ") ?? [];
        words = wordsList;
      } else {
        word = "No word found";
        sentence = "No sentence available for today.";
      }
    } catch (e) {
      word = "Error";
      sentence = "Could not fetch the word and sentence.";
      logger.e(e.toString());
    } finally {
      isLoading2 = false;
      update(); // Notify listeners that loading has finished
    }
  }

  Future<void> storeWordResult({
    required String result,
  }) async {
    try {
      final int dayOfYear = int.parse(DateFormat("D").format(DateTime.now()));
      // Reference to the specific day's document within the user's dashboardResult collection
      DocumentReference dayResultRef = firestore
          .collection('dashboardResult')
          .doc(AppStorage.getUserData()?.userId)
          .collection('dayResults')
          .doc(dayOfYear.toString());

      // Check if the document for this day already exists
      DocumentSnapshot doc = await dayResultRef.get();

      if (!doc.exists) {
        // If it does not exist, create it with the word and result
        await dayResultRef.set({
          'word': word,
          'sentence': sentence,
          'selectedSentence': selectedWordList.join(" "),
          'result': result,
          'date': DateTime.now(), // Optional: stores the date of the result
        });
        logger.i("Result stored successfully for day $dayOfYear.");
      } else if (doc.exists) {
        await dayResultRef.update({
          'result': result,
        });
      } else {
        logger.i("Result for day $dayOfYear already exists.");
      }
    } catch (e) {
      logger.e("Error storing result: $e");
    }
  }
}
