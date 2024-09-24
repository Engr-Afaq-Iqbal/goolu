import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/View/Auth/ForgetPassword/set_new_password.dart';
import 'package:goolu/View/Auth/sign_in.dart';

import '../../../Components/app_custom_button.dart';
import '../../../Components/app_form_field.dart';
import '../../../Controller/AuthController/forget_password_controller.dart';
import '../../../Theme/colors.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';
import '../../../Utils/utils.dart';

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
                  horizontal: SizesDimensions.width(4.0),
                ),
                child: Column(
                  children: [
                    size120h,
                    customText(
                      text: 'Forgot Password',
                      textAlign: TextAlign.center,
                      textStyle: bold20NavyBlue.copyWith(
                        fontSize: 22,
                        color: kDarkGreen365D64,
                      ),
                      maxLines: 2,
                    ),
                    size30h,
                    customText(
                        text:
                            'Enter the email address registered with\nyour account. We\'ll send you a link to\nreset your password',
                        textAlign: TextAlign.center,
                        textStyle: regular18NavyBlue,
                        maxLines: 3),
                    size70h,
                    AppFormField(
                      fieldBgColor: kF8F9FF,
                      borderColor: kDarkGreen5b99a5,
                      controller: forgetPassCtrl.forgetEmailCtrl,
                      labelText: 'Email',
                      hintText: 'accountname@domain.com',
                      keyboardType: TextInputType.emailAddress,
                      validator: (String? v) {
                        if (v!.isEmpty) {
                          return 'Email required';
                        }
                        return null;
                      },
                    ),
                    size50h,
                    AppCustomButton(
                      title: customText(
                        text: 'Submit',
                        textStyle: regular16White.copyWith(fontSize: 18),
                      ),
                      enableLoading: true,
                      onTap: forgetPasswordHandler,
                      borderRadius: Dimensions.radiusDoubleExtraLarge,
                      verticalPadding: 10,
                    ),
                    size50h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.offAll(() => const SignInScreen());
                          },
                          child: customText(
                            text: 'Already have an account'.tr,
                            textStyle: regular18NavyBlue.copyWith(
                              color: secDarkBlueNavyColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                    size10h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.offAll(() => const SignInScreen());
                          },
                          child: customText(
                            text: 'Login to your account',
                            textStyle: regular14PrimaryBlue.copyWith(
                              color: kDarkGreen365D64,
                              fontSize: 14,
                            ),
                          ),
                        ),
                      ],
                    ),
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
