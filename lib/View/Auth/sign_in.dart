import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/View/Auth/sign_up.dart';

import '../../../Config/app_config.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';
import '../../../Utils/utils.dart';
import '../../Components/app_bottom_navigation_bar.dart';
import '../../Components/app_custom_button.dart';
import '../../Components/app_form_field.dart';
import '../../Controller/AuthController/auth_controller.dart';
import '../ForgetPassword/forgot_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthController authenticationCtrl = Get.find<AuthController>();

  // @override
  // void dispose() {
  //   // TODO: implement dispose
  //   authCtrl.disposeSignInControllers();
  //   super.dispose();
  // }
  @override
  void initState() {
    authenticationCtrl.initializeLoginControllers();
    // TODO: implement initState
    super.initState();
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
          return SizedBox(
            height: Get.height,
            width: Get.width,
            child: Form(
              key: authCtrl.signInFormKey,
              child: Stack(
                children: [
                  // bottomLogo(),
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: SizesDimensions.width(3.0),
                    ),
                    child: Column(
                      children: [
                        size120h,
                        Image.asset('${gooluLogoUrl}goolu.png'),
                        size20h,
                        customText(
                          text: 'welcomeBack'.tr,
                          textStyle: bold18Blue,
                        ),
                        size5h,
                        customText(
                          text: 'loginToYourPersonalAccount'.tr,
                          textStyle: regular16NavyBlue,
                        ),
                        size40h,
                        AppFormField(
                          controller: authCtrl.emailCtrl,
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
                        size15h,
                        AppFormField(
                          controller: authCtrl.passwordCtrl,
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
                        size20h,
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Get.to(() => const ForgotPassword());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              customText(
                                text: 'forgetMyPassword'.tr,
                                textStyle: regular14PrimaryBlue,
                              ),
                            ],
                          ),
                        ),
                        size5h,
                        AppCustomButton(
                          title: customText(
                            text: 'signIn'.tr,
                            textStyle: bold14White,
                          ),
                          enableLoading: true,
                          onTap: loginHandler,
                          borderRadius: 4,
                        ),
                        size20h,
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
                                Get.to(() => const SignUpPage());
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
          );
        }),
      ),
    );
  }

  void loginHandler() async {
    // if (!authenticationCtrl.signInFormKey.currentState!.validate()) return;

    FocusScope.of(context).unfocus();
    showProgress();
    FirebaseAuth.instance
        .signInWithEmailAndPassword(
            email: authenticationCtrl.emailCtrl.text,
            password: authenticationCtrl.passwordCtrl.text)
        .then((value) {
      Get.offAll(() => const AppBottomNavigationBar(),
          transition: Transition.downToUp,
          duration: const Duration(seconds: 1));
      logger.i(value);
    });

    // bool login = await authenticationCtrl.postLogin(isLogin: true);
    // if (!login) {
    //   stopProgress();
    // }
  }
}
