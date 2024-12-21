import 'package:flutter/material.dart';

import '../Utils/font_styles.dart';

class TimestampConverter extends StatelessWidget {
  final int timestamp;

  const TimestampConverter({super.key, required this.timestamp});

  @override
  Widget build(BuildContext context) {
    DateTime date = DateTime.fromMillisecondsSinceEpoch(timestamp);
    String formattedDate =
        "${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}";

    return customText(
      text: formattedDate,
      textStyle: bold14NavyBlue,
    );
  }
}
