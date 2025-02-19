import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';

import '../Components/app_confirmation_page.dart';
import '../Controller/ExceptionalController/exceptional_controller.dart';
import '../Utils/utils.dart';
import '../View/Auth/sign_in.dart';
import 'api_request_generator.dart';

class ApiServices {
  static String apiExceptionFormat(method, url, code, res) =>
      '$method, EndPoint => $url\nStatus Code => $code\nResponse => $res';
  static String methodExceptionFormat(method, url, error, stackTrace) =>
      '$method, EndPoint: $url\nError: $error\nStackTrace: $stackTrace';

  static Future<String?> getMethod({
    required String feedUrl,
    bool notLogin = false,
  }) async {
    var headers = {
      'accept': 'application/json',
      'Accept-Language': 'en',
      'X-Client-Referrer': 'swagger',
      'X-Request-Id': ApiRequestGenerator().xRequestId,
      'X-Request-Timestamp': ApiRequestGenerator().xRequestTimeStamp,
    };
    var request = http.Request('GET', Uri.parse(feedUrl));

    request.headers.addAll(headers);

    return await request.send().then((http.StreamedResponse response) async {
      String result = await response.stream.bytesToString();
      var decodedBody = json.decode(result);
      var data = decodedBody['data'];
      var success = decodedBody['success'];

      logger.i(headers);
      logger.i(apiExceptionFormat('GET', feedUrl, response.statusCode, result));
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          success == 'true') {
        debugPrint('-->> in status code 200 & success = true');
        return result;
      } else if (response.statusCode == 401 ||
          response.reasonPhrase == 'Unauthorized') {
        showToast('tokenIsExpired'.tr);
        // AppController().logoutFunc();
        logger.i('tokenIsExpired'.tr);
        return null;
      } else if (response.statusCode == 403 ||
          response.reasonPhrase == 'Forbidden') {
        showToast('youAreNotAllowedToPerformThisAction'.tr);
        // AppController().logoutFunc();
        logger.i('youAreNotAllowedToPerformThisAction'.tr);
        return null;
      } else if (success == 'false') {
        if (data is List && data.isEmpty) {
          logger.i('-->>in empty data list');
          await ExceptionController().errorAlert(
            errorMsg: 'theGivenDataWasInvalid'.tr,
            resBody: 'theGivenDataWasInvalid'.tr,
            exceptionFormat: apiExceptionFormat('POST', feedUrl,
                response.statusCode, 'theGivenDataWasInvalid'.tr),
          );
          return null;
        }
      } else {
        await ExceptionController().errorAlert(
          resBody: result,
          exceptionFormat:
              apiExceptionFormat('GET', feedUrl, response.statusCode, result),
        );
        return null;
      }
    }).onError((error, stackTrace) async {
      logger.e('StackTrace $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: 'Something went wrong\n Please try again later', //$error
        exceptionFormat:
            // 'Error: ApiService -> postMultiPartMethod -> API Do = $feedUrl, Error => Something went wrong, Try again later',
            'Error => Something went wrong, Try again later',
      );
      return null;
    });
  }

  static Future<String?> postMethod({
    required feedUrl,
    Map<String, String>? fields,
    bool notLogin = false,
  }) async {
    Map<String, String> headers = {
      // 'Content-Type': 'application/x-www-form-urlencoded',
      // 'Connection': 'keep-alive',
      'accept': 'application/json',
      'X-Request-Id': ApiRequestGenerator().xRequestId,
      'X-Request-Timestamp': ApiRequestGenerator().xRequestTimeStamp,
      'X-Client-Referrer': 'swagger',
      'Accept-Language': 'en',
    };
    var request = http.MultipartRequest('POST', Uri.parse('$feedUrl'));
    if (fields != null) {
      request.fields.addAll(fields);
      logger.i(request.fields);
    }

    request.headers.addAll(headers);

    ///for testing
    // var decodedBody = json.decode(
    //     '{"success":false,"status":449,"data":{"message":"Two factor authentication required","two_fa_driver":"sms","resend_allowed":true}}');
    // var data = decodedBody['data'];
    // if (data != null && data.containsKey('two_fa_driver')) {
    //   return 'two_fa_driver';
    // }

    return await request.send().then((http.StreamedResponse response) async {
      String result = await response.stream.bytesToString();
      logger
          .i(apiExceptionFormat('POST', feedUrl, response.statusCode, result));
      var decodedBody = json.decode(result);
      var data = decodedBody['data'];
      var success = decodedBody['success'];

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          success == 'true') {
        debugPrint('-->> in status code 200 & success = true');
        return result;
      } else if (response.statusCode == 401 ||
          response.reasonPhrase == 'Unauthorized') {
        showToast('tokenIsExpired'.tr);
        Get.offAll(const SignInScreen());
        logger.i('Token Expire');
      } else if (response.statusCode == 403 ||
          response.reasonPhrase == 'Forbidden') {
        showToast('youAreNotAllowedToPerformThisAction'.tr);
        // AppController().logoutFunc();
        logger.i('youAreNotAllowedToPerformThisAction'.tr);
        return null;
      } else if (response.statusCode == 400 ||
          response.reasonPhrase == 'Bad Request') {
        Get.offAll(() => AppConfirmationPage(
              title: 'error'.tr,
              txt: 'someIssueOccurredInProceedingWithYourRequest'.tr,
              btnTxt: 'goToDashBoard'.tr,
            ));
      } else if (success == 'false') {
        if (data is List && data.isEmpty) {
          logger.i('-->>in empty data list');
          await ExceptionController().errorAlert(
            resBody: 'theGivenDataWasInvalid'.tr,
            exceptionFormat: apiExceptionFormat('POST', feedUrl,
                response.statusCode, 'theGivenDataWasInvalid'.tr),
          );
          return null;
        }
      } else if (data != null && data.containsKey('two_fa_driver')) {
        logger.i('-->>in two factor driver');
        debugPrint('-->>in two factor driver');
        return 'two_fa_driver';
      } else {
        await ExceptionController().errorAlert(
          resBody: result,
          exceptionFormat:
              apiExceptionFormat('POST', feedUrl, response.statusCode, result),
        );
        return null;
      }
      // if (decodedBody.containsKey('errors')) {
      //   String errorMessage = decodedBody['errors']
      //       .entries
      //       .map((entry) => '${entry.key}: ${entry.value.join(", ")}')
      //       .join('\n');
      //   logger.e('Error Messagr -->> $errorMessage');
      //   // await ExceptionController().errorAlert(
      //   //   resBody: errorMessage,
      //   //   exceptionFormat: apiExceptionFormat('POST', feedUrl, response.statusCode, errorMessage),
      //   // );
      // }
    }).onError((error, stackTrace) async {
      logger.e('StackTrace $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: 'Something went wrong\n Please try again later', //$error
        exceptionFormat:
            // 'Error: ApiService -> postMultiPartMethod -> API Do = $feedUrl, Error => Something went wrong, Try again later',
            'Error => Something went wrong, Try again later',
      );
      return null;
    });
  }

  static Future<String?> postMethodForMedia({
    required String feedUrl,
    required String fields, // JSON-encoded string
  }) async {
    Map<String, String> headers = {
      'accept': 'application/json',
      'Content-Type': 'application/json', // JSON content type
      'X-Request-Id': ApiRequestGenerator().xRequestId,
      'X-Request-Timestamp': ApiRequestGenerator().xRequestTimeStamp,
      'X-Client-Referrer': 'swagger',
      'Accept-Language': 'en',
    };
    logger.i(fields);
    try {
      final response = await http.post(
        Uri.parse(feedUrl),
        headers: headers,
        body: fields, // Directly pass the JSON-encoded string
      );

      logger.i(apiExceptionFormat(
          'POST', feedUrl, response.statusCode, response.body));

      var decodedBody = json.decode(response.body);
      var success = decodedBody['success'];
      var data = decodedBody['data'];

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          success == true) {
        debugPrint('-->> in status code 200 & success = true');
        return response.body;
      } else if (response.statusCode == 401 ||
          response.reasonPhrase == 'Unauthorized') {
        showToast('tokenIsExpired'.tr);
        Get.offAll(const SignInScreen());
        logger.i('Token Expire');
        return null;
      } else if (response.statusCode == 403 ||
          response.reasonPhrase == 'Forbidden') {
        showToast('youAreNotAllowedToPerformThisAction'.tr);
        logger.i('youAreNotAllowedToPerformThisAction'.tr);
        return null;
      } else if (response.statusCode == 400 ||
          response.reasonPhrase == 'Bad Request') {
        Get.offAll(() => AppConfirmationPage(
              title: 'error'.tr,
              txt: 'someIssueOccurredInProceedingWithYourRequest'.tr,
              btnTxt: 'goToDashBoard'.tr,
            ));
        return null;
      } else if (success == false) {
        if (data is List && data.isEmpty) {
          logger.i('-->> in empty data list');
          await ExceptionController().errorAlert(
            resBody: 'theGivenDataWasInvalid'.tr,
            exceptionFormat: apiExceptionFormat('POST', feedUrl,
                response.statusCode, 'theGivenDataWasInvalid'.tr),
          );
          return null;
        } else {
          await ExceptionController().errorAlert(
            resBody: response.body,
            exceptionFormat: apiExceptionFormat(
                'POST', feedUrl, response.statusCode, response.body),
          );
          return null;
        }
      } else if (data != null && data.containsKey('two_fa_driver')) {
        logger.i('-->> in two factor driver');
        return 'two_fa_driver';
      } else {
        await ExceptionController().errorAlert(
          resBody: response.body,
          exceptionFormat: apiExceptionFormat(
              'POST', feedUrl, response.statusCode, response.body),
        );
        return null;
      }
    } catch (error, stackTrace) {
      logger.e('StackTrace $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: 'Something went wrong\n Please try again later', //$error
        exceptionFormat:
            // 'Error: ApiService -> postMultiPartMethod -> API Do = $feedUrl, Error => Something went wrong, Try again later',
            'Error => Something went wrong, Try again later',
      );
      return null;
    }
  }

  static Future<String?> postMultiPartQuery({
    required String feedUrl,
    Map<String, String>? fields,
    Map<String, String>? files,
    bool returnAnyResponse = false,
  }) async {
    try {
      Map<String, String> headers = {
        // 'Content-Type': 'application/x-www-form-urlencoded',
        // 'Connection': 'keep-alive',
        'accept': 'application/json',
        'X-Request-Id': ApiRequestGenerator().xRequestId,
        'X-Request-Timestamp': ApiRequestGenerator().xRequestTimeStamp,
        'X-Client-Referrer': 'swagger',
        'Accept-Language': 'en',
      };
      var request = http.MultipartRequest('POST', Uri.parse(feedUrl));
      if (fields != null) {
        request.fields.addAll(fields);
      }
      if (files != null) {
        files.forEach((key, value) async {
          request.files.add(
            await http.MultipartFile.fromPath(
              key,
              value,
              filename: value.split("/").last,
            ),
          );
        });
      }
      request.headers.addAll(headers);
      http.StreamedResponse response = await request.send();
      String result = await response.stream.bytesToString();

      final jd = json.decode(result);
      logger.i('Decoded Response => $jd');
      if (returnAnyResponse) return result;
      // if (response.statusCode == 200 || response.statusCode == 201) {
      //   return resBody;
      // } else {
      //   await ExceptionController().errorAlert(
      //     resBody: resBody,
      //     exceptionFormat:
      //         apiExceptionFormat('POST', feedUrl, response.statusCode, resBody),
      //   );
      //   return null;
      // }
      var decodedBody = json.decode(result);
      var data = decodedBody['data'];
      var success = decodedBody['success'];
      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          success == 'true') {
        debugPrint('-->> in status code 200 & success = true');
        logger.i(result);
        return result;
      } else if (response.statusCode == 401 ||
          response.reasonPhrase == 'Unauthorized') {
        showToast('tokenIsExpired'.tr);
        Get.offAll(const SignInScreen());
        logger.i('Token Expire');
      } else if (response.statusCode == 403 ||
          response.reasonPhrase == 'Forbidden') {
        showToast('youAreNotAllowedToPerformThisAction'.tr);
        // AppController().logoutFunc();
        logger.i('youAreNotAllowedToPerformThisAction'.tr);
        return null;
      } else if (response.statusCode == 400 ||
          response.reasonPhrase == 'Bad Request') {
        if (decodedBody.containsKey('detail')) {
          String emailErrorMessage = decodedBody['detail'].join(', ');
          showToast(emailErrorMessage);
        }
        logger.i(result);
        return null;
      } else if (success == 'false') {
        if (data is List && data.isEmpty) {
          logger.i('-->>in empty data list');
          await ExceptionController().errorAlert(
            resBody: 'theGivenDataWasInvalid'.tr,
            exceptionFormat: apiExceptionFormat('POST', feedUrl,
                response.statusCode, 'theGivenDataWasInvalid'.tr),
          );
          return null;
        }
      } else if (data != null && data.containsKey('two_fa_driver')) {
        logger.i('-->>in two factor driver');
        debugPrint('-->>in two factor driver');
        return 'two_fa_driver';
      } else {
        await ExceptionController().errorAlert(
          resBody: result,
          exceptionFormat: apiExceptionFormat(
              'PostMultiPartMethod', feedUrl, response.statusCode, result),
        );
        return null;
      }
    } catch (error) {
      logger.e(
          'Error: ApiService -> postMultiPartMethod -> API Do = $feedUrl, Error => $error');
      await ExceptionController().exceptionAlert(
        errorMsg: 'Something went wrong\n Please try again later', //$error
        exceptionFormat:
            // 'Error: ApiService -> postMultiPartMethod -> API Do = $feedUrl, Error => Something went wrong, Try again later',
            'Error => Something went wrong, Try again later',
      );
      //AppConst.errorOccurAlert();
      return null;
    }
    return null;
  }

  Future<void> downloadFileWithDio({String? pdfUrl, String? pdfName}) async {
    String? filePath;
    var url = '$pdfUrl';
    final dio = Dio();

    var time = DateTime.now().millisecondsSinceEpoch;
    try {
      final dir = await getApplicationDocumentsDirectory();
      if (Platform.isAndroid) {
        filePath = '/storage/emulated/0/Download/$pdfName-$time.pdf';
      } else {
        filePath = '${dir.path}/$pdfName-$time.pdf';
      }

      await dio.download(url, filePath, onReceiveProgress: (received, total) {
        if (total != -1) {
          debugPrint(
              'Downloading: ${(received / total * 100).toStringAsFixed(0)}%');
        }
      }).onError((error, stackTrace) async {
        debugPrint('Error => $error');
        logger.e('StackTrace => $stackTrace');
        await ExceptionController().exceptionAlert(
          errorMsg: '$error',
          exceptionFormat:
              methodExceptionFormat('POST', '$pdfUrl', error, stackTrace),
        );
        throw '$error';
      });

      logger.i('File saved at $filePath');
      showToast('fileDownloadedSuccessfully'.tr);
    } catch (e) {
      await ExceptionController().exceptionAlert(
        errorMsg: 'Something went wrong\n Please try again later', //$error
        exceptionFormat:
            // 'Error: ApiService -> postMultiPartMethod -> API Do = $feedUrl, Error => Something went wrong, Try again later',
            'Error => Something went wrong, Try again later',
      );
    }
  }

  static Future<Uint8List?> getMethodForDownloadPdf({
    required String feedUrl,
    bool notLogin = false,
  }) async {
    var headers = {
      'accept': 'application/json',
      'Accept-Language': 'en',
      'X-Client-Referrer': 'swagger',
      'X-Request-Id': ApiRequestGenerator().xRequestId,
      'X-Request-Timestamp': ApiRequestGenerator().xRequestTimeStamp,
    };

    var request = http.Request('GET', Uri.parse(feedUrl));
    request.headers.addAll(headers);

    try {
      var response = await request.send();
      if (response.statusCode == 200 || response.statusCode == 201) {
        // Collect all bytes from the response stream.
        final List<int> bytes = await response.stream.toBytes();
        return Uint8List.fromList(bytes);
      } else if (response.statusCode == 401 ||
          response.reasonPhrase == 'Unauthorized') {
        showToast('tokenIsExpired'.tr);
        logger.i('tokenIsExpired'.tr);
        return null;
      } else if (response.statusCode == 403 ||
          response.reasonPhrase == 'Forbidden') {
        showToast('youAreNotAllowedToPerformThisAction'.tr);
        logger.i('youAreNotAllowedToPerformThisAction'.tr);
        return null;
      } else {
        final result = await response.stream.bytesToString();
        final decodedBody = json.decode(result);
        final success = decodedBody['success'];
        if (success == 'false') {
          final data = decodedBody['data'];
          if (data is List && data.isEmpty) {
            logger.i('-->>in empty data list');
            await ExceptionController().errorAlert(
              errorMsg: 'theGivenDataWasInvalid'.tr,
              resBody: 'theGivenDataWasInvalid'.tr,
              exceptionFormat: apiExceptionFormat('POST', feedUrl,
                  response.statusCode, 'theGivenDataWasInvalid'.tr),
            );
          }
        }
        await ExceptionController().errorAlert(
          resBody: result,
          exceptionFormat:
              apiExceptionFormat('GET', feedUrl, response.statusCode, result),
        );
        return null;
      }
    } catch (error, stackTrace) {
      logger.e('StackTrace $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: 'Something went wrong\n Please try again later', //$error
        exceptionFormat:
            // 'Error: ApiService -> postMultiPartMethod -> API Do = $feedUrl, Error => Something went wrong, Try again later',
            'Error => Something went wrong, Try again later',
      );
      return null;
    }
  }

  static Future<String?> deleteMethod({
    required feedUrl,
    Map<String, String>? fields,
    context,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      // 'Connection': 'keep-alive',
      'accept': 'application/json',
      'X-Request-Id': ApiRequestGenerator().xRequestId,
      'X-Request-Timestamp': ApiRequestGenerator().xRequestTimeStamp,
      'X-Client-Referrer': 'swagger',
      'Accept-Language': 'en',
    };
    var request = http.MultipartRequest('DELETE', Uri.parse('$feedUrl'));
    if (fields != null) {
      request.fields.addAll(fields);
      logger.i(request.fields);
    }

    request.headers.addAll(headers);

    return await request.send().then((http.StreamedResponse response) async {
      String result = await response.stream.bytesToString();
      logger.i(
          apiExceptionFormat('DELETE', feedUrl, response.statusCode, result));

      // if (response.statusCode == 200 ||
      //     response.statusCode == 201 ||
      //     success == 'true') {
      //   debugPrint('-->> in status code 200 & success = true');
      //   return result;
      // } else
      if (response.statusCode == 204 || response.reasonPhrase == 'No Content') {
        logger.i('Bank Account Delete Successfully!');
        // Check current route and pop accordingly
        if (Get.currentRoute == '/AppOtpPage') {
          Get.close(2);
        }
        // Get.find<WalletController>().fetchBankAccountList();
        // showDialog(
        //   context: context,
        //   builder: (context) => const AlertDialog(
        //     clipBehavior: Clip.hardEdge,
        //     contentPadding: EdgeInsets.symmetric(vertical: 15, horizontal: 0),
        //     content: AppRemoveAccountConfirmation(),
        //   ),
        // );
        return 'deleted';
      } else {
        var decodedBody = json.decode(result);
        var data = decodedBody['data'];
        var success = decodedBody['success'];
        if (response.statusCode == 401 ||
            response.reasonPhrase == 'Unauthorized') {
          showToast('tokenIsExpired'.tr);
          Get.offAll(const SignInScreen());
          logger.i('Token Expire');
          return null;
        } else if (response.statusCode == 403 ||
            response.reasonPhrase == 'Forbidden') {
          showToast('youAreNotAllowedToPerformThisAction'.tr);
          // AppController().logoutFunc();
          logger.i('youAreNotAllowedToPerformThisAction'.tr);
          return null;
        } else if (response.statusCode == 400 ||
            response.reasonPhrase == 'Bad Request') {
          Get.offAll(() => AppConfirmationPage(
                title: 'error'.tr,
                txt: 'someIssueOccurredInProceedingWithYourRequest'.tr,
                btnTxt: 'goToDashBoard'.tr,
              ));
        } else if (success == 'false') {
          if (data is List && data.isEmpty) {
            logger.i('-->>in empty data list');
            await ExceptionController().errorAlert(
              resBody: 'theGivenDataWasInvalid'.tr,
              exceptionFormat: apiExceptionFormat('DELETE', feedUrl,
                  response.statusCode, 'theGivenDataWasInvalid'.tr),
            );
            return null;
          }
        } else if (data != null && data.containsKey('two_fa_driver')) {
          logger.i('-->>in two factor driver');
          debugPrint('-->>in two factor driver');
          return 'two_fa_driver';
        } else {
          await ExceptionController().errorAlert(
            resBody: result,
            exceptionFormat: apiExceptionFormat(
                'DELETE', feedUrl, response.statusCode, result),
          );
          return null;
        }
      }
    }).onError((error, stackTrace) async {
      logger.e('StackTrace $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: 'Something went wrong\n Please try again later', //$error
        exceptionFormat:
            // 'Error: ApiService -> postMultiPartMethod -> API Do = $feedUrl, Error => Something went wrong, Try again later',
            'Error => Something went wrong, Try again later',
      );
      return null;
    });
  }

  static Future<String?> patchMethod({
    required feedUrl,
    Map<String, String>? fields,
    context,
  }) async {
    Map<String, String> headers = {
      'Content-Type': 'application/x-www-form-urlencoded',
      // 'Connection': 'keep-alive',
      'accept': 'application/json',
      'X-Request-Id': ApiRequestGenerator().xRequestId,
      'X-Request-Timestamp': ApiRequestGenerator().xRequestTimeStamp,
      'X-Client-Referrer': 'swagger',
      'Accept-Language': 'en',
    };
    var request = http.MultipartRequest('PATCH', Uri.parse('$feedUrl'));
    if (fields != null) {
      request.fields.addAll(fields);
      logger.i(request.fields);
    }

    request.headers.addAll(headers);

    return await request.send().then((http.StreamedResponse response) async {
      String result = await response.stream.bytesToString();
      logger
          .i(apiExceptionFormat('PATCH', feedUrl, response.statusCode, result));

      var decodedBody = json.decode(result);
      var data = decodedBody['data'];
      var success = decodedBody['success'];

      if (response.statusCode == 200 ||
          response.statusCode == 201 ||
          success == 'true') {
        debugPrint('-->> in status code 200 & success = true');
        return result;
      } else if (response.statusCode == 401 ||
          response.reasonPhrase == 'Unauthorized') {
        showToast('tokenIsExpired'.tr);
        Get.offAll(const SignInScreen());
        logger.i('Token Expire');
        return null;
      } else if (response.statusCode == 403 ||
          response.reasonPhrase == 'Forbidden') {
        showToast('youAreNotAllowedToPerformThisAction'.tr);
        // AppController().logoutFunc();
        logger.i('youAreNotAllowedToPerformThisAction'.tr);
        return null;
      } else if (response.statusCode == 400 ||
          response.reasonPhrase == 'Bad Request') {
        Get.offAll(() => AppConfirmationPage(
              title: 'error'.tr,
              txt: 'someIssueOccurredInProceedingWithYourRequest'.tr,
              btnTxt: 'goToDashBoard'.tr,
            ));
      } else if (success == 'false') {
        if (data is List && data.isEmpty) {
          logger.i('-->>in empty data list');
          await ExceptionController().errorAlert(
            resBody: 'theGivenDataWasInvalid'.tr,
            exceptionFormat: apiExceptionFormat('PATCH', feedUrl,
                response.statusCode, 'theGivenDataWasInvalid'.tr),
          );
          return null;
        }
      } else if (data != null && data.containsKey('two_fa_driver')) {
        logger.i('-->>in two factor driver');
        debugPrint('-->>in two factor driver');
        return 'two_fa_driver';
      } else {
        await ExceptionController().errorAlert(
          resBody: result,
          exceptionFormat:
              apiExceptionFormat('PATCH', feedUrl, response.statusCode, result),
        );
        return null;
      }
      // if (response.statusCode == 204 || response.reasonPhrase == 'No Content') {
      //   logger.i('Bank Account Delete Successfully!');
      //   // Check current route and pop accordingly
      //   if (Get.currentRoute == '/AppOtpPage') {
      //     Get.close(2);
      //   }
      //   Get.find<WalletController>().fetchBankAccountList();
      //
      //   return 'deleted';
      // }
    }).onError((error, stackTrace) async {
      logger.e('StackTrace $stackTrace');
      await ExceptionController().exceptionAlert(
        errorMsg: 'Something went wrong\n Please try again later', //$error
        exceptionFormat:
            // 'Error: ApiService -> postMultiPartMethod -> API Do = $feedUrl, Error => Something went wrong, Try again later',
            'Error => Something went wrong, Try again later',
      );
      return null;
    });
  }
}
