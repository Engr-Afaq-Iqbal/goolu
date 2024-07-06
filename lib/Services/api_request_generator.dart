import 'package:uuid/uuid.dart';

class ApiRequestGenerator {
  String _generateUniqueRequestId() {
    var uuid = const Uuid();
    return uuid.v4();
  }

  String get xRequestId => _generateUniqueRequestId();

  // String generateUniqueRequestId() {
  //   const uuidPattern = 'xxxxxxxx-xxxx-4xxx-yxxx-xxxxxxxxxxxx';
  //   var rng = Random();
  //
  //   String replaceChar(String c) {
  //     var r = rng.nextInt(16);
  //     var v = c == 'x' ? r : (r & 0x3 | 0x8);
  //     return v.toRadixString(16);
  //   }
  //
  //   return uuidPattern.replaceAllMapped(
  //       RegExp('[xy]'), (match) => replaceChar(match.group(0)!));
  // }

  String _generateTimeStamp() {
    // Generate current timestamp in seconds
    var timestamp = DateTime.now().millisecondsSinceEpoch ~/ 1000;
    return timestamp.toString();
  }

  String get xRequestTimeStamp => _generateTimeStamp();
}
