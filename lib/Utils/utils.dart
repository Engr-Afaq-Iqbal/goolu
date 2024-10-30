import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:logger/logger.dart';

import '../Theme/colors.dart';

Logger logger = Logger();

showProgress() {
  Get.defaultDialog(
    backgroundColor: Colors.transparent,
    title: "",
    content: Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(10)),
      child: progressIndicator(),
    ),
    barrierDismissible: false,
  );
}

progressIndicator({double? height, double? width}) =>
    Builder(builder: (context) {
      return Center(
        child: SizedBox(
          height: height,
          width: width,
          child: CircularProgressIndicator(
            backgroundColor: Colors.grey,
            color: primaryColor,
            strokeWidth: 2.5,
          ),
        ),
      );
    });

stopProgress() {
  if (Get.isDialogOpen!) Get.back();
}

showToast(String msg, {BuildContext? context}) async {
  await Fluttertoast.showToast(
    msg: msg,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 1,
    backgroundColor: secBorderColor,
    textColor: secDarkGreyIconColor,
    fontSize: 12.0,
  );
}

void hideKeyboard(BuildContext context) {
  FocusScope.of(context).requestFocus(FocusNode());
}

bool isValidEmail(String? email) {
  if (email == null) return false;
  // Regex pattern for email validation
  final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
      caseSensitive: false, multiLine: false);
  return regex.hasMatch(email);
}

copyToClipboard(String text) {
  Clipboard.setData(ClipboardData(
    text: text,
  ));
  // showToast('copied'.tr);
}
