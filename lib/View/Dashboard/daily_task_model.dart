class DailyTask {
  final bool sentenceBuilding;
  final bool situationPractice;
  final bool imageDescription;

  DailyTask({
    required this.sentenceBuilding,
    required this.situationPractice,
    required this.imageDescription,
  });

  /// Factory constructor to create a DailyTask object from Firestore data
  factory DailyTask.fromMap(Map<String, dynamic> data) {
    return DailyTask(
      sentenceBuilding: data['sentence_building']['completed'] ?? false,
      situationPractice: data['situation_practice']['completed'] ?? false,
      imageDescription: data['image_description']['completed'] ?? false,
    );
  }

  /// Convert a DailyTask object to a map (if needed for updates)
  Map<String, dynamic> toMap() {
    return {
      'sentence_building': {'completed': sentenceBuilding},
      'situation_practice': {'completed': situationPractice},
      'image_description': {'completed': imageDescription},
    };
  }
}
