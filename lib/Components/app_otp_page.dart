import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';

import '../../../Components/app_custom_app_bar.dart';
import '../../../Config/app_config.dart';
import '../../../Theme/colors.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';
import '../Controller/AuthController/auth_controller.dart';
import '../Utils/utils.dart';
import 'app_confirmation_page.dart';

class AppOtpPage extends StatefulWidget {
  final String? heading;
  final String? subHeading;
  final String? btnTxt;
  final String? image;
  final String? route;
  final bool showLogo;
  const AppOtpPage({
    super.key,
    this.heading,
    this.btnTxt,
    this.subHeading,
    this.image,
    this.route,
    required this.showLogo,
  });

  @override
  State<AppOtpPage> createState() => _AppOtpPageState();
}

class _AppOtpPageState extends State<AppOtpPage> {
  AuthController authController = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();
    authController.startTimer();
  }

  @override
  void dispose() {
    authController.timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<AuthController>(builder: (AuthController authCtrl) {
          return Padding(
            padding: EdgeInsets.symmetric(
              horizontal: SizesDimensions.width(3.0),
            ),
            child: Column(
              children: [
                size60h,
                const AppCustomAppBar(),
                size40h,
                // if (widget.showLogo == false)
                //   SvgPicture.asset('$imgUrl${widget.image}'),
                if (widget.showLogo == true)
                  Image.asset(
                    '${gooluLogoUrl}goolu.png',
                    width: SizesDimensions.width(45),
                  ),
                size20h,
                customText(
                  text: '${widget.heading}',
                  textStyle: bold18Blue,
                ),
                size5h,
                if (widget.subHeading != null || widget.subHeading != '')
                  customText(
                    text: '${widget.subHeading}',
                    textStyle: regular16NavyBlue,
                  ),
                size60h,
                customText(
                  text: 'verificationCodeCheck'.tr,
                  textStyle: bold16NavyBlue,
                ),
                size20h,
                customText(
                  text: 'anActivitationCodeHasBeenSent'.tr,
                  textStyle: regular14NavyBlue,
                  maxLines: 2,
                  textAlign: TextAlign.center,
                ),
                size40h,
                PinCodeFields(
                  length: 6,
                  fieldBorderStyle: FieldBorderStyle.square,
                  responsive: false,
                  fieldHeight: SizesDimensions.height(6.0),
                  fieldWidth: SizesDimensions.width(11.0),
                  borderWidth: 2.0,
                  activeBorderColor: primaryBlueColor,
                  activeBackgroundColor: kFFFFFF,
                  borderRadius: BorderRadius.circular(4.0),
                  keyboardType: TextInputType.number,
                  autoHideKeyboard: true,
                  fieldBackgroundColor: kFFFFFF,
                  borderColor: kC8C8C8,
                  textStyle: bold20NavyBlue,
                  padding: const EdgeInsets.all(0),
                  margin: const EdgeInsets.all(0),
                  onComplete: (output) async {
                    authCtrl.setOtp = output;
                    // authCtrl.setCheckOtpFill = true;
                    // Get.to(
                    //   () => AppOtpPage(
                    //     heading: 'identityVerification'.tr,
                    //     btnTxt: 'verifyTheOtp'.tr,
                    //     route: 'signIn',
                    //     subHeading: '',
                    //     showLogo: true,
                    //   ),
                    // );
                    Get.to(AppConfirmationPage(
                      title: 'Account Created Successfully'.tr,
                      txt: 'Your new account is ready to use now'.tr,
                      btnTxt: 'My Account'.tr,
                      route: 'newAccount',
                    ));
                    authCtrl.update();
                  },
                ),
                size20h,
                customText(
                  text: authCtrl.formatDuration(authCtrl.remainingSeconds),
                  textStyle: bold20Grey,
                ),
                size20h,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    customText(
                      text: 'didNotReceiveCode'.tr,
                      textStyle: regular14NavyBlue,
                    ),
                    size10w,
                    GestureDetector(
                      onTap: authCtrl.canResend
                          ? () async {
                              if (widget.route == 'signIn') {
                                showProgress();
                                // bool login = await authCtrl.postLogin(
                                //     isLogin: true, resendOtp: true);
                                // if (!login) {
                                //   stopProgress();
                                // }
                              } else if (widget.route == 'isInvestment') {
                                showProgress();
                                // bool isInvestment =
                                // await Get.find<HomeController>()
                                //     .investmentExecution(
                                //     isInitial: true, resendOtp: true);
                                // if (!isInvestment) {
                                //   stopProgress();
                                // }
                              }
                            }
                          : null,
                      child: customText(
                        text: 'resend'.tr,
                        textStyle: authCtrl.canResend ? bold14Blue : bold14Grey,
                      ),
                    ),
                  ],
                ),
                // const Spacer(),
                // AppStyles.dividerLine(width: Get.width),
                // size30h,
                // AppCustomButton(
                //   title: customText(
                //     text: '${widget.btnTxt}',
                //     textStyle: bold14White,
                //   ),
                //   onTap: (authCtrl.checkOtpFill && authCtrl.otp.length == 6)
                //       ? nextStepHandler
                //       : null,
                //   borderRadius: 4,
                // ),
                size20h,
              ],
            ),
          );
        }),
      ),
    );
  }

// void nextStepHandler() async {
//   if (widget.route == 'withdraw') {
//     Get.to(() => AppConfirmationPage(
//           title: 'withdrawalSuccessfullyConfirmed'.tr,
//           txt:
//               '${'youHaveSuccessfullyWithdrawn'.tr} 50,000 SAR ${'fromYourWalletToYourBankAccount'.tr}',
//           btnTxt: 'myWallet'.tr,
//         ));
//   } else if (widget.route == 'addBank') {
//     Get.to(() => const MyWalletAddBankDocumentation());
//   } else if (widget.route == 'signIn') {
//     showProgress();
//     bool login = await authController.postLogin(
//         isLogin: false, code: authController.otp);
//     if (!login) {
//       stopProgress();
//     }
//   }
// }
}
