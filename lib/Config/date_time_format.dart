import 'package:intl/intl.dart';

class AppFormatDate {
  static String ddMMM12h(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('dd MMM, hh:mm a').format(dateTime);
  }

  static String ddMMYYYY(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat('MM/dd/yyyy').format(dateTime);
  }

  static String hhmmDifference(DateTime? dateTime) {
    if (dateTime == null) return '';
    return "${DateTime.now().difference(dateTime).inHours}:${DateTime.now().difference(dateTime).inMinutes.remainder(60)}";
  }

  static String? doubleToStringUpTo2(String? number) {
    if (number == null) return null;
    return double.tryParse(number)?.toStringAsFixed(2);
  }
}
