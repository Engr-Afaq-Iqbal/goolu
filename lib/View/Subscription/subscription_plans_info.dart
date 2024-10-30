import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_stripe/flutter_stripe.dart';
import 'package:get/get.dart';
import 'package:goolu/Config/app_config.dart';
import 'package:goolu/Utils/utils.dart';
import 'package:http/http.dart' as http;

import '../../Components/app_custom_button.dart';
import '../../Controller/SideDrawerController/side_drawer_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';
import '../../Utils/image_urls.dart';

class SubscriptionPlansInfo extends StatefulWidget {
  const SubscriptionPlansInfo({super.key});

  @override
  State<SubscriptionPlansInfo> createState() => _SubscriptionPlansInfoState();
}

class _SubscriptionPlansInfoState extends State<SubscriptionPlansInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<SideDrawerController>(
          builder: (SideDrawerController sideDrawerCtrl) {
        return Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(
                  vertical: SizesDimensions.height(3),
                  horizontal: SizesDimensions.width(5),
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft:
                          Radius.circular(Dimensions.radiusDoubleExtraLarge),
                      topRight:
                          Radius.circular(Dimensions.radiusDoubleExtraLarge)),
                  color: kLightYellow.withOpacity(0.3),
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            customText(
                              text: 'Yearly SAR 540',
                              textStyle: bold20NavyBlue.copyWith(fontSize: 18),
                            ),
                            size10h,
                            customText(
                              text: 'SAR 45',
                              textStyle: bold20NavyBlue.copyWith(fontSize: 30),
                            ),
                            customText(
                              text: '/month',
                              textStyle: regular16NavyBlue,
                            ),
                          ],
                        ),
                        size40w,
                        Image.asset('$imgUrl$heartNotifyImg'),
                        // size60h,
                      ],
                    ),
                    size30h,
                    iconWithText(
                        txt: 'Practice describing real life scenarios'),
                    iconWithText(txt: 'Voice Translation tool'),
                    iconWithText(
                        txt: 'Practice general questions with model answers'),
                    iconWithText(txt: 'Practice specific topic conversations'),
                    iconWithText(txt: 'Practice scenario based dialouges'),
                    iconWithText(txt: 'Make 500 requests per feature'),
                    iconWithText(
                        txt:
                            'Learn new vocabulary from anywhere with image recognition feature'),
                    iconWithText(txt: 'Translate texts from images'),
                    size50h,
                    AppCustomButton(
                      borderRadius: Dimensions.radiusSingleExtraLarge,
                      title:
                          customText(text: 'Subscribe', textStyle: bold16White),
                      onTap: () async {
                        await makePayment(); // Get.to(() => const SubscriptionPlansInfo());
                      },
                    ),
                  ],
                ),
              ),
            )
          ],
        );
      }),
    );
  }

  Padding iconWithText({String? txt}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        children: [
          Icon(
            Icons.check, // Tick icon
            color: primaryColor, // Icon color
            size: 24.0, // Icon size
          ),
          size30w,
          SizedBox(
              width: SizesDimensions.width(80),
              child: customText(
                  text: '$txt',
                  textStyle: bold16NavyBlue.copyWith(
                    fontSize: 12,
                  ),
                  maxLines: 3)),
        ],
      ),
    );
  }

  Map<String, dynamic>? paymentIntentData;

  Future<void> makePayment() async {
    try {
      paymentIntentData = await createPaymentIntent(20, 'USD');
      await Stripe.instance.initPaymentSheet(
          paymentSheetParameters: SetupPaymentSheetParameters(
        paymentIntentClientSecret: paymentIntentData!['client_secret'],
        applePay: const PaymentSheetApplePay(merchantCountryCode: 'US'),
        googlePay: const PaymentSheetGooglePay(merchantCountryCode: 'US'),
        style: ThemeMode.dark,
        merchantDisplayName: 'Afaq',
      ));

      displayPaymentSheet();
    } catch (e) {
      logger.e('Exception $e');
      showToast(e.toString());
    }
  }

  // displayPaymentSheet() {
  //   try {
  //     Stripe.instance
  //         .presentPaymentSheet(options: const PaymentSheetPresentOptions());
  //   } catch (e) {
  //     logger.e('Exception $e');
  //     showToast(e.toString());
  //   }
  // }

  Future<void> displayPaymentSheet() async {
    try {
      // Present the payment sheet to the user
      await Stripe.instance.presentPaymentSheet();

      // Payment successful; handle success here
      logger.i('Payment successful!');
      showToast('Payment successful!');

      // Clear payment intent data after a successful payment
      paymentIntentData = null;
    } on StripeException catch (e) {
      // Handle specific Stripe exceptions
      logger.e('StripeException: ${e.error.localizedMessage}');
      showToast('Payment cancelled: ${e.error.localizedMessage}');
    } catch (e) {
      // Handle any other exceptions
      logger.e('Exception: $e');
      showToast('Payment Cancelled,\nAn error occurred: $e');
    }
  }

  createPaymentIntent(int amount, String currency) async {
    try {
      Map<String, dynamic> body = {
        'amount': '${calculateAmount(amount)}',
        'currency': currency,
        'payment_method_types[]': 'card',
      };
      var response = await http.post(
        Uri.parse('https://api.stripe.com/v1/payment_intents'),
        body: body,
        headers: {
          'Authorization':
              'Bearer sk_test_51Pzz9X04ZKHb327KcUt7tLvoMI2l3aVTATGTaUCGfiCcIm8GMdHAswK3gCtvfCdc1dWHbkdWJOhNMCPaVixkRDNg00Uc3GGyYx',
          'Content-Type': 'application/x-www-form-urlencoded',
        },
      );
      return jsonDecode(response.body.toString());
    } catch (e) {
      logger.e('Exception $e');
      showToast(e.toString());
    }
  }

  calculateAmount(int amount) {
    final price = amount * 100;
    return price;
  }
}
