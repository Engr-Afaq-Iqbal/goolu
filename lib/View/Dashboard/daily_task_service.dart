import 'package:cloud_firestore/cloud_firestore.dart';

import '../../Utils/utils.dart';
import 'daily_task_model.dart';

class DailyTaskService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Function to check if DailyTask exists for a user
  Future<bool> checkIfDailyTaskExists(String userId) async {
    try {
      final docSnapshot =
          await _firestore.collection('DailyTask').doc(userId).get();

      return docSnapshot.exists;
    } catch (e) {
      logger.e("Error checking DailyTask existence: $e");
      return false;
    }
  }

  /// Function to create DailyTask for a user if not exists
  Future<void> createDailyTask(String userId) async {
    try {
      // Check if the document already exists
      bool exists = await checkIfDailyTaskExists(userId);

      if (!exists) {
        // Create the DailyTask document with the required tasks
        await _firestore.collection('DailyTask').doc(userId).set({
          'sentence_building': {
            'completed': false,
            'description': 'Complete sentence building exercises',
          },
          'situation_practice': {
            'completed': false,
            'description': 'Practice different situations',
          },
          'image_description': {
            'completed': false,
            'description': 'Describe the image provided',
          },
          'created_at': FieldValue.serverTimestamp(),
        });

        logger.i("DailyTask created successfully for user $userId.");
      } else {
        logger.i("DailyTask already exists for user $userId.");
      }
    } catch (e) {
      logger.e("Error creating DailyTask: $e");
    }
  }

  /// Fetch DailyTask for a user and map it to the model
  Future<DailyTask?> fetchDailyTask(String userId) async {
    try {
      final docSnapshot =
          await _firestore.collection('DailyTask').doc(userId).get();

      if (docSnapshot.exists) {
        // Map Firestore data to DailyTask model
        return DailyTask.fromMap(docSnapshot.data() as Map<String, dynamic>);
      } else {
        logger.e("DailyTask not found for user $userId.");
        return null;
      }
    } catch (e) {
      logger.e("Error fetching DailyTask: $e");
      return null;
    }
  }

  /// Update the status of a specific task
  Future<void> updateTaskStatus(
      String userId, String taskKey, bool status) async {
    try {
      await _firestore.collection('DailyTask').doc(userId).update({
        '$taskKey.completed': status,
      });
      logger.i("$taskKey updated successfully for user $userId.");
    } catch (e) {
      logger.e("Error updating $taskKey: $e");
    }
  }

  Future<DailyTask?> fetchAndResetDailyTask(String userId) async {
    try {
      final docRef = _firestore.collection('DailyTask').doc(userId);
      final docSnapshot = await docRef.get();

      if (docSnapshot.exists) {
        // Get data and last updated date
        final data = docSnapshot.data() as Map<String, dynamic>;
        final Timestamp? lastUpdated = data['last_updated'] as Timestamp?;
        final DateTime now = DateTime.now();

        // If the last_updated date is null or less than today's date, reset tasks
        if (lastUpdated == null || !isSameDay(lastUpdated.toDate(), now)) {
          await docRef.update({
            'sentence_building.completed': false,
            'situation_practice.completed': false,
            'image_description.completed': false,
            'last_updated': now,
          });
          logger.i("DailyTask reset for user $userId.");
        }

        // Return the updated DailyTask
        return DailyTask.fromMap(data);
      } else {
        logger.e("DailyTask not found for user $userId.");
        return null;
      }
    } catch (e) {
      logger.e("Error resetting DailyTask: $e");
      return null;
    }
  }

  /// Utility to check if two dates are the same day
  bool isSameDay(DateTime date1, DateTime date2) {
    return date1.year == date2.year &&
        date1.month == date2.month &&
        date1.day == date2.day;
  }
}
