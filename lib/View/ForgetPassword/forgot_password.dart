import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/View/ForgetPassword/set_new_password.dart';

import '../../../Components/app_custom_app_bar.dart';
import '../../../Components/app_custom_button.dart';
import '../../../Components/app_form_field.dart';
import '../../../Config/app_config.dart';
import '../../../Theme/colors.dart';
import '../../../Utils/font_styles.dart';
import '../../../Utils/utils.dart';
import '../../Controller/AuthController/forget_password_controller.dart';
import '../../Utils/dimensions.dart';

class ForgotPassword extends StatefulWidget {
  const ForgotPassword({super.key});

  @override
  State<ForgotPassword> createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  ForgetPasswordController forgetPassCtrl =
      Get.find<ForgetPasswordController>();

  @override
  void dispose() {
    // TODO: implement dispose
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
        backgroundColor: kFFFFFF,
        body: Form(
          key: forgetPassCtrl.forgetPasswordFormKey,
          child: Stack(
            children: [
              // bottomLogo(),
              Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: SizesDimensions.width(2.0),
                ),
                child: Column(
                  children: [
                    size60h,
                    const AppCustomAppBar(),
                    size20h,
                    // SvgPicture.asset('${gooluLogoUrl}blomalBColor.svg'),
                    size20h,
                    customText(
                      text: 'forgotPassword'.tr,
                      textStyle: bold18Blue,
                    ),
                    size5h,
                    customText(
                      text: 'enterYourEmailAddressToReset'.tr,
                      textStyle: regular16NavyBlue,
                    ),
                    size60h,
                    AppFormField(
                      controller: forgetPassCtrl.forgetEmailCtrl,
                      labelText: 'emailAddress'.tr,
                      hintText: 'accountname@goolu.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? v) {
                        if (v!.isEmpty) {
                          return 'emailRequired'.tr;
                        }
                        return null;
                      },
                    ),
                    size20h,
                    AppCustomButton(
                      title: customText(
                        text: 'sendEmail'.tr,
                        textStyle: bold14White,
                      ),
                      onTap: forgetPasswordHandler,
                      borderRadius: 4,
                    ),
                    const Spacer(),
                    AppStyles.dividerLine(width: Get.width),
                    size30h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        customText(
                          text: 'dontHaveAnAccount'.tr,
                          textStyle: regular14NavyBlue,
                        ),
                        size10w,
                        GestureDetector(
                          onTap: () {
                            // Get.to(() => const ChooseAccountType());
                          },
                          child: customText(
                            text: 'requestAccount'.tr,
                            textStyle: bold14Blue,
                          ),
                        ),
                      ],
                    ),
                    size40h,
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void forgetPasswordHandler() async {
    if (!forgetPassCtrl.forgetPasswordFormKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    showProgress();
    Get.to(() => const SetNewPassword(
        // heading: 'verification'.tr,
        // btnTxt: 'verifyTheOtp'.tr,
        // route: 'isForgetPassword',
        // subHeading: '',
        // showLogo: true,
        ));
    // bool isForgetPassword = await
    // forgetPassCtrl.requestResetPassword();
    // if (!isForgetPassword) {
    //   stopProgress();
    // }
  }
}
