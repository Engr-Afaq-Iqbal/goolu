import 'package:flutter/material.dart';
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
    barrierDismissible: true,
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
            color: primaryBlueColor,
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

// bottomLogo() {
//   return Positioned(
//     left: 0,
//     bottom: -SizesDimensions.height(3.0),
//     child: SvgPicture.asset(
//       '${gooluLogoUrl}bigB.svg',
//       width: SizesDimensions.width(60.0),
//     ),
//   );
// }
