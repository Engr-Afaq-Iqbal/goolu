import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../Components/app_custom_button.dart';
import '../../../Components/app_form_field.dart';
import '../../../Components/app_form_field_phone.dart';
import '../../../Config/app_config.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';
import '../../Components/app_custom_app_bar.dart';
import '../../Components/app_otp_page.dart';
import '../../Controller/AuthController/sign_up_controller.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: GetBuilder<SignupController>(
            builder: (SignupController signUpCtrl) {
          return Form(
            key: signUpCtrl.signUpFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizesDimensions.width(3.0),
              ),
              child: Column(
                children: [
                  size60h,
                  const AppCustomAppBar(),
                  Image.asset(
                    '${gooluLogoUrl}goolu.png',
                    width: SizesDimensions.width(45),
                  ),
                  size20h,
                  customText(
                    text: 'createNewAccount'.tr,
                    textStyle: bold18Blue,
                  ),
                  size20h,
                  size20h,
                  customText(
                    text: 'personalProfileInformation'.tr,
                    textStyle: bold16NavyBlue,
                  ),
                  size20h,
                  SizedBox(
                    height: SizesDimensions.height(47.0),
                    child: SingleChildScrollView(
                      child: Column(
                        children: [
                          size15h,
                          AppFormField(
                            controller: signUpCtrl.emailCtrl,
                            labelText: 'emailAddress'.tr,
                            hintText: 'accountname@domain.com',
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? v) {
                              if (v!.isEmpty) {
                                return 'emailRequired'.tr;
                              }
                              return null;
                            },
                          ),
                          AppFormFieldPhone(
                            maxLength: 9,
                            controller: signUpCtrl.phoneNumberCtrl,
                            labelText: 'phoneNumber'.tr,
                            hintText: 'phoneNumber'.tr,
                            keyboardType: TextInputType.number,
                          ),
                          size15h,
                          AppFormField(
                            controller: signUpCtrl.dateOfBirthCtrl,
                            labelText: 'dateOfBirth'.tr,
                            hintText: 'dateOfBirth'.tr,
                            readOnly: true,
                            keyboardType: TextInputType.emailAddress,
                            validator: (String? v) {
                              if (v!.isEmpty) {
                                return 'dateOfBirthRequired'.tr;
                              }
                              return null;
                            },
                          ),
                          AppFormField(
                            controller: signUpCtrl.passwordCtrl,
                            labelText: 'password'.tr,
                            hintText: '********'.tr,
                            keyboardType: TextInputType.text,
                            isPasswordField: true,
                            validator: (String? v) {
                              if (v!.isEmpty) {
                                return 'passwordRequired'.tr;
                              }
                              return null;
                            },
                          ),
                          AppFormField(
                            controller: signUpCtrl.confirmPasswordCtrl,
                            labelText: 'confirmPassword'.tr,
                            hintText: '********'.tr,
                            keyboardType: TextInputType.text,
                            isPasswordField: true,
                            validator: (String? v) {
                              if (v!.isEmpty) {
                                return 'confirmPasswordRequired'.tr;
                              }
                              return null;
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(),
                  AppStyles.dividerLine(width: Get.width),
                  size20h,
                  AppCustomButton(
                    title: customText(
                      text: 'nextStep'.tr,
                      textStyle: bold14White,
                    ),
                    onTap: nextStepHandler,
                    borderRadius: 4,
                  ),
                  size20h,
                ],
              ),
            ),
          );
        }),
      ),
    );
  }

  void nextStepHandler() async {
    Get.to(
      () => AppOtpPage(
        heading: 'identityVerification'.tr,
        btnTxt: 'verifyTheOtp'.tr,
        route: 'signIn',
        subHeading: '',
        showLogo: true,
      ),
    );
    // Get.to(
    //   () => const CreateNewAccountOtpPage(),
    //   transition: Transition.cupertino,
    //   duration: const Duration(seconds: 1),
    // );
    // showProgress();
    // authCtrl.postLogin();
  }
}
