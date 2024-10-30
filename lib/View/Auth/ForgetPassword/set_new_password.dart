import 'package:flutter/material.dart';
import 'package:flutter_pin_code_fields/flutter_pin_code_fields.dart';
import 'package:get/get.dart';

import '../../../Components/app_confirmation_page.dart';
import '../../../Components/app_custom_button.dart';
import '../../../Components/app_form_field.dart';
import '../../../Config/app_config.dart';
import '../../../Controller/AuthController/forget_password_controller.dart';
import '../../../Theme/colors.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';
import '../../../Utils/utils.dart';

class SetNewPassword extends StatefulWidget {
  const SetNewPassword({super.key});

  @override
  State<SetNewPassword> createState() => _SetNewPasswordState();
}

class _SetNewPasswordState extends State<SetNewPassword> {
  ForgetPasswordController forgetPassCtrl =
      Get.find<ForgetPasswordController>();

  @override
  void initState() {
    super.initState();
    forgetPassCtrl.startTimer();
  }

  @override
  void dispose() {
    forgetPassCtrl.timer?.cancel();
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
        body: GetBuilder<ForgetPasswordController>(
            builder: (ForgetPasswordController forgetPasswordCtrl) {
          return Form(
            key: forgetPasswordCtrl.setNewPasswordFormKey,
            child: Stack(
              children: [
                // bottomLogo(),
                Padding(
                  padding: EdgeInsets.symmetric(
                    horizontal: SizesDimensions.width(2.0),
                  ),
                  child: Column(
                    children: [
                      size120h,
                      Image.asset(
                        '${gooluLogoUrl}goolu.png',
                        width: SizesDimensions.width(45),
                      ),
                      size20h,
                      customText(
                        text: 'identityVerification'.tr,
                        textStyle: bold18Blue,
                      ),
                      size5h,
                      customText(
                          text: 'anActivitationCodeHasBeenSent'.tr,
                          textStyle: regular16NavyBlue,
                          maxLines: 3,
                          textAlign: TextAlign.center),
                      size40h,
                      PinCodeFields(
                        length: 6,
                        fieldBorderStyle: FieldBorderStyle.square,
                        responsive: false,
                        fieldHeight: SizesDimensions.height(6.0),
                        fieldWidth: SizesDimensions.width(11.0),
                        borderWidth: 2.0,
                        activeBorderColor: primaryColor,
                        activeBackgroundColor: kFFFFFF,
                        borderRadius: BorderRadius.circular(4.0),
                        keyboardType: TextInputType.number,
                        autoHideKeyboard: true,
                        fieldBackgroundColor: kFFFFFF,
                        borderColor: kC8C8C8,
                        textStyle: bold20NavyBlue,
                        padding: const EdgeInsets.all(0),
                        margin: const EdgeInsets.all(0),
                        onChange: (val) {
                          forgetPasswordCtrl.setOtp = val;
                          if (val.length == 6) {
                            forgetPasswordCtrl.setShowPasswordField = true;
                          } else {
                            forgetPasswordCtrl.setShowPasswordField = false;
                          }
                          forgetPasswordCtrl.update();
                        },
                        onComplete: (output) {
                          forgetPasswordCtrl.setOtp = output;
                          forgetPasswordCtrl.setShowPasswordField = true;
                          forgetPasswordCtrl.update();
                        },
                      ),
                      size20h,
                      customText(
                        text: forgetPasswordCtrl.formatDuration(
                            forgetPasswordCtrl.remainingSeconds),
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
                            onTap: forgetPasswordCtrl.canResend
                                ? () async {
                                    showProgress();
                                    // bool isForgetPassword =
                                    //     await forgetPasswordCtrl
                                    //         .requestResetPassword();
                                    // if (!isForgetPassword) {
                                    //   stopProgress();
                                    // }
                                  }
                                : null,
                            child: customText(
                              text: 'resend'.tr,
                              textStyle: forgetPasswordCtrl.canResend
                                  ? bold14Blue
                                  : bold14Grey,
                            ),
                          ),
                        ],
                      ),
                      if (forgetPasswordCtrl.showPasswordField == true &&
                          forgetPasswordCtrl.otp.length == 6)
                        Column(
                          children: [
                            size40h,
                            AppFormField(
                              controller: forgetPasswordCtrl.newPasswordCtrl,
                              labelText: 'newPassword'.tr,
                              hintText: '********'.tr,
                              keyboardType: TextInputType.text,
                              isPasswordField: true,
                              validator: (String? v) {
                                if (v!.isEmpty) {
                                  return 'newPasswordRequired'.tr;
                                }
                                return null;
                              },
                            ),
                            size10h,
                            AppFormField(
                              controller:
                                  forgetPasswordCtrl.confirmPasswordCtrl,
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
                            size40h,
                            AppCustomButton(
                              title: customText(
                                text: 'confirmNewPasswordAndLogin'.tr,
                                textStyle: bold14White,
                              ),
                              onTap: confirmNewPasswordHandler,
                              borderRadius: 4,
                            ),
                          ],
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
          );
        }),
      ),
    );
  }

  confirmNewPasswordHandler() async {
    if (!forgetPassCtrl.setNewPasswordFormKey.currentState!.validate()) {
      return;
    }
    FocusScope.of(context).unfocus();
    showProgress();
    Get.to(AppConfirmationPage(
      title: 'newPasswordSetToYourAccount'.tr,
      txt: 'yourNewPasswordHasBeenSuccessfullyReset'.tr,
      btnTxt: 'myAccount'.tr,
      route: 'setNewPassword',
    ));
    // bool resetPassword = await forgetPassCtrl.resetPassword();
    // if (!resetPassword) {
    //   stopProgress();
    // }
  }
}
