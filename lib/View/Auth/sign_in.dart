import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Config/app_config.dart';
import 'package:goolu/View/Auth/sign_up.dart';

import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';
import '../../../Utils/utils.dart';
import '../../Components/app_bottom_navigation_bar.dart';
import '../../Components/app_custom_button.dart';
import '../../Components/app_form_field.dart';
import '../../Controller/AuthController/auth_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/image_urls.dart';
import 'ForgetPassword/forgot_password.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  AuthController authenticationCtrl = Get.find<AuthController>();

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
                      horizontal: SizesDimensions.width(4.0),
                    ),
                    child: Column(
                      children: [
                        size120h,
                        customText(
                          text: 'Login here',
                          textAlign: TextAlign.center,
                          textStyle: bold20NavyBlue.copyWith(
                            fontSize: 22,
                            color: kDarkGreen365D64,
                          ),
                          maxLines: 2,
                        ),
                        size30h,
                        customText(
                            text: 'Welcome back you’ve\nbeen missed!',
                            textAlign: TextAlign.center,
                            textStyle: regular18NavyBlue,
                            maxLines: 3),
                        size70h,
                        AppFormField(
                          fieldBgColor: kF8F9FF,
                          borderColor: kDarkGreen5b99a5,
                          controller: authCtrl.emailCtrl,
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
                        size15h,
                        AppFormField(
                          fieldBgColor: kF8F9FF,
                          borderColor: kDarkGreen5b99a5,
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
                        size50h,
                        GestureDetector(
                          behavior: HitTestBehavior.translucent,
                          onTap: () {
                            Get.to(() => const ForgotPassword());
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              customText(
                                text: 'forgetMyPassword'.tr,
                                textStyle: regular14PrimaryBlue.copyWith(
                                  color: kDarkGreen365D64,
                                  fontSize: 14,
                                ),
                              ),
                            ],
                          ),
                        ),
                        size30h,
                        AppCustomButton(
                          title: customText(
                            text: 'signIn'.tr,
                            textStyle: regular16White.copyWith(fontSize: 18),
                          ),
                          enableLoading: true,
                          onTap: loginHandler,
                          borderRadius: Dimensions.radiusDoubleExtraLarge,
                          verticalPadding: 10,
                        ),
                        size30h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            GestureDetector(
                              onTap: () {
                                Get.to(() => const SignUpPage());
                              },
                              child: customText(
                                text: 'Create new account'.tr,
                                textStyle: regular18NavyBlue.copyWith(
                                  color: secDarkBlueNavyColor,
                                ),
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            customText(
                              text: 'Or continue with',
                              textStyle: regular14PrimaryBlue.copyWith(
                                color: kDarkGreen365D64,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        size30h,
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            methodsBox(imagePath: facebookImg),
                            size50w,
                            methodsBox(imagePath: googleImg),
                            size50w,
                            methodsBox(imagePath: appleImg),
                          ],
                        ),
                        size15h,
                        size70h,
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

  Container methodsBox({String? imagePath}) {
    return Container(
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: kF8F9FF,
          borderRadius: BorderRadius.circular(Dimensions.radiusLarge)),
      child: Image.asset('$imgUrl$imagePath'),
    );
  }

  void loginHandler() async {
    if (!authenticationCtrl.signInFormKey.currentState!.validate()) return;

    FocusScope.of(context).requestFocus(FocusNode());
    showProgress();

    try {
      final userCredential =
          await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: authenticationCtrl.emailCtrl.text,
        password: authenticationCtrl.passwordCtrl.text,
      );
      stopProgress();
      Get.offAll(() => const AppBottomNavigationBar(),
          transition: Transition.downToUp,
          duration: const Duration(seconds: 1));

      logger.i(userCredential);
    } catch (e) {
      stopProgress();
      logger.e(e);
      showToast(
        e.toString(),
      );
    }
  }
}
