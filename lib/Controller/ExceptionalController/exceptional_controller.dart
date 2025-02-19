import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:goolu/Utils/font_styles.dart';

import '../../Components/app_custom_button.dart';
import '../../Components/app_dialog_box.dart';
import '../../Utils/utils.dart';

class ExceptionController extends GetxController {
  Future exceptionAlert(
      {String? errorMsg, String? resBody, String? exceptionFormat}) async {
    String alertDesc = '';
    if (resBody != null) {
      try {
        alertDesc = json.decode(resBody)['message'] +
            (json.decode(resBody)['errors'] != null
                ? '\n${json.decode(resBody)['errors']}'
                : null);
      } catch (e) {
        try {
          alertDesc = json.decode(resBody)['message'] ??
              json.decode(resBody)['errors'].toString();
        } catch (e) {
          try {
            alertDesc = json.decode(resBody).toString();
          } catch (err) {
            alertDesc = resBody.toString();
          }
        }
      }
    } else if (errorMsg != null) {
      alertDesc = errorMsg;
    }

    // // if (isNeedResponse) {
    // //   AppAlert.warning(desc: alertDesc);
    // // } else {

    // showAppOverlayPre(overlayTxtTitle: 'Error', overlayTxtMsg: alertDesc);
    // // }
    // else
    debugPrint(Get.currentRoute);
    await appDialogBox(
      Get.context!,
      dialogTitle: 'Sorry for inconvenience'.tr,
      contentPage: Stack(
        children: [
          SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                customText(
                  text: alertDesc,
                  textStyle: regular12NavyBlue,
                ),
                const SizedBox(height: 50),
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            right: 15,
            child: AppCustomButton(
              onTap: () {
                Get.back();
              },
              btnTxtAxisSize: MainAxisSize.min,
              padding: const EdgeInsets.symmetric(
                horizontal: 15,
                vertical: 10,
              ),
              btnTxt: 'ok'.tr,
              // isOutLinedButton: true,
              // enableToolTip: false,
            ),
          ),
        ],
      ),
    );
  }

  Future errorAlert(
      {String? errorMsg, String? resBody, String? exceptionFormat}) async {
    String alertDesc = '';

    if (resBody != null) {
      try {
        alertDesc = json.decode(resBody)['data']['message']
            // + (json.decode('$resBody')['errors'] != null
            //     ? '\n${json.decode('$resBody')['errors']['email']}'
            //     : null)
            ;
      } catch (e) {
        try {
          alertDesc = json.decode(resBody)['data']['message'] ??
              json.decode(resBody)['data']['message'].toString();
        } catch (e) {
          try {
            alertDesc = json.decode(resBody).toString();
          } catch (err) {
            alertDesc = resBody.toString();
          }
        }
      }
    } else if (errorMsg != null) {
      alertDesc = errorMsg;
    }

    // // if (isNeedResponse) {
    // //   AppAlert.warning(desc: alertDesc);
    // // } else {

    // showAppOverlayPre(overlayTxtTitle: 'Error', overlayTxtMsg: alertDesc);
    // // }
    // else
    debugPrint(Get.currentRoute);
    showToast(alertDesc);
    // await appDialogBox(
    //   Get.context!,
    //   dialogTitle: 'error'.tr,
    //   contentPage: Stack(
    //     children: [
    //       SingleChildScrollView(
    //         child: Column(
    //           mainAxisSize: MainAxisSize.min,
    //           children: [
    //             Text(alertDesc),
    //             const SizedBox(height: 50),
    //           ],
    //         ),
    //       ),
    //       Positioned(
    //         bottom: 0,
    //         right: 15,
    //         child: AppCustomButton(
    //           onTap: () {
    //             // if (Get.currentRoute != '/LoginPage')
    //             //   submitException(
    //             //     errMsg: alertDesc,
    //             //     compError: exceptionFormat ?? resBody,
    //             //   );
    //             Get.back();
    //           },
    //           btnTxtAxisSize: MainAxisSize.min,
    //           padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 15),
    //           btnTxt: (Get.currentRoute == '/SignInScreen')
    //               ? 'ok'.tr
    //               : 'submit_report'.tr,
    //           // isOutLinedButton: true,
    //           // enableToolTip: false,
    //         ),
    //       ),
    //     ],
    //   ),
    // );
  }

  // /// Send Email on address with exception details
  // Future submitException({String? errMsg, compError}) async {
  //   // Configure the SMTP server settings
  //   String email = 'app@bizmodo.ae';
  //   final smtpServer = SmtpServer(
  //     'mail.bizmodo.ae',
  //     username: email,
  //     password: '%MUg1vhv*,2p',
  //     port: 465,
  //     ssl: true,
  //   );
  //
  //   // Create the email message
  //   final message = Message()
  //     ..from = Address(
  //       '${AppStorage.getLoggedUserData()?.staffUser.email ?? email}',
  //       '${AppStorage.getLoggedUserData()?.staffUser.username}',
  //     )
  //     ..recipients.add(email)
  //     ..subject = 'Error Report:'
  //         '${AppConfig.appName}'
  //         ' - ${AppStorage.getBusinessDetailsData()?.businessData?.name}'
  //         ' - $errMsg'
  //     ..text = '$compError';
  //
  //   try {
  //     // Send the email
  //     final sendReport = await send(message, smtpServer);
  //     print('Email sent! Message ID: ${sendReport.toString()}');
  //   } catch (e) {
  //     print('Error sending email: $e');
  //   }
  // }
}
