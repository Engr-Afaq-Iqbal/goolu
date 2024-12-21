// // import 'dart:convert';
// //
// // import 'package:dio/dio.dart';
// // import 'package:flutter/cupertino.dart';
// // import 'package:flutter_stripe/flutter_stripe.dart';
// // import 'package:goolu/Config/app_config.dart';
// // import 'package:goolu/Services/api_urls.dart';
// //
// // import '../Utils/consts.dart';
// // import '../Utils/utils.dart';
// //
// // class StripeService {
// //   StripeService._();
// //
// //   static final StripeService instance = StripeService._();
// //
// //   Future<void> makePayment({required int amount}) async {
// //     try {
// //       String? paymentIntentClientSecret = await _createPaymentIntent(
// //         amount,
// //         AppConfig.currency,
// //       );
// //       if (paymentIntentClientSecret == null) return;
// //       await Stripe.instance.initPaymentSheet(
// //         paymentSheetParameters: SetupPaymentSheetParameters(
// //           paymentIntentClientSecret: paymentIntentClientSecret,
// //           merchantDisplayName: AppConfig.merchantDisplayName,
// //         ),
// //       );
// //       await _processPayment();
// //     } catch (e) {
// //       logger.e(e);
// //     }
// //   }
// //
// //   Future<String?> _createPaymentIntent(int amount, String currency) async {
// //     try {
// //       final Dio dio = Dio();
// //       Map<String, dynamic> data = {
// //         "amount": _calculateAmount(
// //           amount,
// //         ),
// //         "currency": currency,
// //       };
// //       var response = await dio.post(
// //         ApiUrls.paymentApi,
// //         data: data,
// //         options: Options(
// //           contentType: Headers.formUrlEncodedContentType,
// //           headers: {
// //             "Authorization": "Bearer $stripeSecretKey",
// //             "Content-Type": 'application/x-www-form-urlencoded'
// //           },
// //         ),
// //       );
// //       printFullResponse(response.data);
// //       if (response.statusCode == 200) {
// //         logger.i("In condition Response status code: ${response.statusCode}");
// //         logger.i("In condition Response headers: ${response.headers}");
// //         logger.i("In condition Response data: ${response.data}");
// //       }
// //       if (response.data != null) {
// //         logger.i("Client secret received: ${response.data["client_secret"]}");
// //         return response.data["client_secret"];
// //       }
// //
// //       return null;
// //     } catch (e) {
// //       logger.e(e);
// //     }
// //     return null;
// //   }
// //
// //   void printFullResponse(Map<String, dynamic> response) {
// //     const encoder = JsonEncoder.withIndent('  ');
// //     final prettyString = encoder.convert(response);
// //     debugPrint(prettyString, wrapWidth: 1024); // Adjust wrapWidth as needed
// //   }
// //
// //   Future<void> _processPayment() async {
// //     try {
// //       await Stripe.instance.presentPaymentSheet();
// //       logger.i('Payment Confirmation !!!');
// //       await Stripe.instance.confirmPaymentSheetPayment();
// //     } catch (e) {
// //       logger.e(e);
// //     }
// //   }
// //
// //   String _calculateAmount(int amount) {
// //     final calculatedAmount = amount * 100;
// //     return calculatedAmount.toString();
// //   }
// // }
//
// import 'dart:convert';
//
// import 'package:dio/dio.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter_stripe/flutter_stripe.dart';
// import 'package:goolu/Config/app_config.dart';
// import 'package:goolu/Services/api_urls.dart';
//
// import '../Utils/consts.dart';
// import '../Utils/utils.dart';
//
// class StripeService {
//   StripeService._();
//
//   static final StripeService instance = StripeService._();
//
//   /// Main function to handle payment
//   Future<void> makePayment({required int amount}) async {
//     try {
//       logger.i("Initiating payment of $amount ${AppConfig.currency}");
//       final paymentIntentClientSecret = await _createPaymentIntent(
//         amount,
//         AppConfig.currency,
//       );
//
//       if (paymentIntentClientSecret == null) {
//         logger.e("Failed to retrieve payment intent client secret.");
//         return;
//       }
//
//       await _initializePaymentSheet(paymentIntentClientSecret);
//       await _processPayment();
//     } catch (e) {
//       logger.e("Payment failed: $e");
//     }
//   }
//
//   /// Create Payment Intent on the server
//   Future<String?> _createPaymentIntent(int amount, String currency) async {
//     try {
//       final Dio dio = Dio();
//       final data = {
//         "amount": _calculateAmount(amount),
//         "currency": currency,
//       };
//
//       logger.i("Creating payment intent with data: $data");
//
//       final response = await dio.post(
//         ApiUrls.paymentApi,
//         data: data,
//         options: Options(
//           contentType: Headers.formUrlEncodedContentType,
//           headers: {
//             "Authorization": "Bearer $stripeSecretKey",
//             "Content-Type": 'application/x-www-form-urlencoded',
//           },
//         ),
//       );
//
//       _logApiResponse(response);
//
//       if (response.statusCode == 200 && response.data != null) {
//         final clientSecret = response.data["client_secret"];
//         logger.i(
//             "Payment intent created successfully. Client secret: $clientSecret");
//         return clientSecret;
//       } else {
//         logger.e("Failed to create payment intent: ${response.statusCode}");
//       }
//     } catch (e) {
//       logger.e("Error in _createPaymentIntent: $e");
//     }
//     return null;
//   }
//
//   /// Initialize Stripe Payment Sheet
//   Future<void> _initializePaymentSheet(String clientSecret) async {
//     try {
//       logger.i("Initializing payment sheet...");
//       await Stripe.instance.initPaymentSheet(
//         paymentSheetParameters: SetupPaymentSheetParameters(
//           paymentIntentClientSecret: clientSecret,
//           merchantDisplayName: AppConfig.merchantDisplayName,
//         ),
//       );
//       logger.i("Payment sheet initialized successfully.");
//     } catch (e) {
//       logger.e("Error in _initializePaymentSheet: $e");
//       rethrow;
//     }
//   }
//
//   /// Present and Confirm Payment
//   Future<void> _processPayment() async {
//     try {
//       logger.i("Presenting payment sheet...");
//       await Stripe.instance.presentPaymentSheet();
//       logger.i("Payment sheet presented. Confirming payment...");
//       await Stripe.instance.confirmPaymentSheetPayment();
//       logger.i("Payment confirmed successfully!");
//     } catch (e) {
//       logger.e("Error in _processPayment: $e");
//     }
//   }
//
//   /// Calculate Amount for Stripe (in cents)
//   String _calculateAmount(int amount) {
//     final calculatedAmount = amount * 100; // Convert to smallest currency unit
//     logger.i("Calculated Stripe amount: $calculatedAmount");
//     return calculatedAmount.toString();
//   }
//
//   /// Utility to log API responses
//   void _logApiResponse(Response response) {
//     logger.i("API Response: Status Code - ${response.statusCode}");
//     const encoder = JsonEncoder.withIndent('  ');
//     final prettyString = encoder.convert(response.data);
//     debugPrint("API Response Data:\n$prettyString", wrapWidth: 1024);
//   }
// }

import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:goolu/Config/app_config.dart';
import 'package:goolu/Config/date_time_format.dart';
import 'package:goolu/Controller/SideDrawerController/side_drawer_controller.dart';
import 'package:goolu/Services/api_urls.dart';
import 'package:goolu/Services/storage_sevices.dart';

import '../Model/UserModel/usersModel.dart';
import '../Utils/consts.dart';
import '../Utils/utils.dart';

class StripeService {
  StripeService._();

  static final StripeService instance = StripeService._();

  Future<void> makePayment({required int amount}) async {
    try {
      final String? clientSecret =
          await _createPaymentIntent(amount, AppConfig.currency);

      if (clientSecret != null) {
        await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
            paymentIntentClientSecret: clientSecret,
            merchantDisplayName: AppConfig.merchantDisplayName,
          ),
        );
        await _processPayment(clientSecret: clientSecret);
      } else {
        logger.w("Payment initialization failed. Client secret is null.");
      }
    } catch (e) {
      logger.e("Error in makePayment: $e");
    }
  }

  Future<String?> _createPaymentIntent(int amount, String currency) async {
    try {
      final Dio dio = Dio();
      Map<String, dynamic> data = {
        "amount": _calculateAmount(amount),
        "currency": currency,
      };

      logger.i(data);
      var response = await dio.post(
        ApiUrls.paymentApi,
        data: data,
        options: Options(
          contentType: Headers.formUrlEncodedContentType,
          headers: {
            "Authorization": "Bearer $stripeSecretKey",
            "Content-Type": 'application/x-www-form-urlencoded'
          },
        ),
      );

      logger.i(response);
      // Pretty print the response
      printFullResponse(response.data);

      if (response.statusCode == 200 && response.data != null) {
        logger.i("Client secret received: ${response.data["client_secret"]}");
        return response.data["client_secret"];
      }

      return null;
    } catch (e) {
      logger.e("Error in _createPaymentIntent: $e");
      return null;
    }
  }

  Future<void> _processPayment({required String clientSecret}) async {
    try {
      logger.i("Presenting payment sheet...");
      await Stripe.instance.presentPaymentSheet();
      final paymentIntent = await _fetchPaymentIntent(clientSecret);
      if (paymentIntent != null) {
        // Log the detailed payment intent response
        _logPaymentResponse(paymentIntent);

        // Send the payment response to your backend for storage
        await storePaymentRecordInFireStore(paymentIntent: paymentIntent);
      } else {
        logger.w("PaymentIntent could not be retrieved.");
      }
      logger.i("Payment sheet presented. Confirming payment...");
      await Stripe.instance.confirmPaymentSheetPayment();

      logger.i("Payment confirmed successfully!");

      // Retrieve detailed payment intent response after successful payment
      // final paymentIntent = await _fetchPaymentIntent(clientSecret);
    } on StripeException catch (_, e) {
      logger.e("Stripe error: $e");
    } catch (e) {
      logger.e("Error in _processPayment: $e");
    }
  }

  Future<Map<String, dynamic>?> _fetchPaymentIntent(String clientSecret) async {
    try {
      logger.i("Fetching PaymentIntent details...");
      final paymentIntent = await Stripe.instance.retrievePaymentIntent(
        clientSecret,
      );
      logger.i("PaymentIntent retrieved successfully.");
      logger.i(paymentIntent.toJson());
      return paymentIntent.toJson();
    } catch (e) {
      logger.e("Error fetching PaymentIntent: $e");
      return null;
    }
  }

  void _logPaymentResponse(Map<String, dynamic> paymentIntent) {
    logger.i("Payment Successful. Details:");
    logger.i("Payment ID: ${paymentIntent['id']}");
    logger.i("Amount: ${paymentIntent['amount']} ${paymentIntent['currency']}");
    logger.i("Status: ${paymentIntent['status']}");
    logger.i("Payment Method: ${paymentIntent['payment_method']}");
    logger.i("Created At: ${paymentIntent['created']}");

    const encoder = JsonEncoder.withIndent('  ');
    final prettyString = encoder.convert(paymentIntent);
    debugPrint("Full Payment Response:\n$prettyString", wrapWidth: 1024);
  }

  void printFullResponse(Map<String, dynamic> response) {
    const encoder = JsonEncoder.withIndent('  ');
    final prettyString = encoder.convert(response);
    debugPrint(prettyString, wrapWidth: 1024); // Adjust wrapWidth as needed
  }

  String _calculateAmount(int amount) {
    final calculatedAmount =
        // amount * 100; // Stripe accepts amounts in the smallest currency unit
        amount * 100; // Stripe accepts amounts in the smallest currency unit
    return calculatedAmount.toString();
  }

  Future<void> storePaymentRecordInFireStore({
    required Map<String, dynamic> paymentIntent,
  }) async {
    try {
      final paymentId = paymentIntent['id'];
      final paymentStatus = paymentIntent['status'];

      if (paymentStatus == 'Succeeded') {
        final userPaymentRef = FirebaseFirestore.instance
            .collection('UserStripeRecord')
            .doc(AppStorage.getUserData()?.userId)
            .collection('Records')
            .doc(paymentId);

        // Data to store
        // final paymentData = {
        //   "id": paymentIntent['id'],
        //   "amount": paymentIntent['amount'],
        //   "currency": paymentIntent['currency'],
        //   "status": paymentIntent['status'],
        //   "payment_method": paymentIntent['payment_method'],
        //   "created_at": paymentIntent['created'],
        //   "description":
        //       paymentIntent['description'] ?? "No description provided",
        //   "metadata": paymentIntent['metadata'] ?? {},
        // };

        final paymentData = paymentIntent;

        // Save the payment record
        await userPaymentRef.set(paymentData);
        UserModel updatedUser = UserModel(
            username: AppStorage.getUserData()?.username ?? '',
            userId: AppStorage.getUserData()?.userId ?? '',
            dob: AppStorage.getUserData()?.dob ?? '',
            email: AppStorage.getUserData()?.email ?? '',
            phoneNumber: AppStorage.getUserData()?.phoneNumber ?? '',
            iqamaNumber: AppStorage.getUserData()?.iqamaNumber ?? '',
            profilePicture: '',
            country: AppStorage.getUserData()?.country ?? '',
            gender: AppStorage.getUserData()?.gender ?? '',
            address: AppStorage.getUserData()?.address ?? '',
            packageStartDate: DateTime.now().toString(),
            packageEndExpiry: '${AppFormatDate.getExpiryDateOneMonth()}',
            isPackage: '1',
            packageType: 'monthly');
        Get.find<SideDrawerController>().updateUserData(updatedUser);

        logger.i("Payment record stored successfully in Firestore.");
      } else {
        logger.w("Payment status is not 'Succeeded'. Status: $paymentStatus");
      }
    } catch (e) {
      logger.e("Error storing payment record in Firestore: $e");
    }
  }
}
