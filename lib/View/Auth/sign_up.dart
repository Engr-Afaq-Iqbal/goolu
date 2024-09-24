import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/View/Auth/sign_in.dart';

import '../../../Components/app_custom_button.dart';
import '../../../Components/app_form_field.dart';
import '../../../Config/app_config.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';
import '../../Controller/AuthController/sign_up_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/image_urls.dart';
import '../../Utils/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // final AuthService _authService = AuthService();
  SignupController signCtrl = Get.find<SignupController>();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<void> signUpFunc(
      String email, String password, String username) async {
    try {
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      User? user = userCredential.user;

      if (user != null) {
        await _firestore.collection('users').doc(user.uid).set({
          'email': user.email,
          'username': username,
          'uid': user.uid,
          'createdAt': FieldValue.serverTimestamp(),
        });
        debugPrint('User created and data stored successfully.');
      }
    } on FirebaseAuthException catch (e) {
      debugPrint('Error: $e');
      // Handle errors here
    }
  }

  Future<bool> signUp() async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: signCtrl.emailCtrl.text.trim(),
        password: signCtrl.passwordCtrl.text.trim(),
      )
          .then((val) {
        Get.offAll(const SignInScreen());
        logger.i(val);
      });
      return true;
      // Sign-up successful, navigate to home or another scree
    } on FirebaseAuthException catch (e) {
      // Handle error
      logger.e(e.message);
      return false;
    } catch (e) {
      logger.e('An unknown error occurred.');
      return false;
    }
  }

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
                horizontal: SizesDimensions.width(4.0),
              ),
              child: Column(
                children: [
                  size120h,
                  customText(
                    text: 'Create Account',
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
                          'Create your account so you start learning\nfrom today!',
                      textAlign: TextAlign.center,
                      textStyle: regular18NavyBlue,
                      maxLines: 3),
                  size70h,
                  Column(
                    children: [
                      size15h,
                      AppFormField(
                          fieldBgColor: kF8F9FF,
                          borderColor: kDarkGreen5b99a5,
                          controller: signUpCtrl.emailCtrl,
                          labelText: 'Email',
                          hintText: 'accountname@domain.com',
                          keyboardType: TextInputType.emailAddress,
                          validator: (String? v) {
                            if (v!.isEmpty) {
                              return 'Email required';
                            }
                            return null;
                          }),
                      // AppFormFieldPhone(
                      //   maxLength: 9,
                      //   controller: signUpCtrl.phoneNumberCtrl,
                      //   labelText: 'phoneNumber'.tr,
                      //   hintText: 'phoneNumber'.tr,
                      //   keyboardType: TextInputType.number,
                      // ),
                      size15h,
                      // AppFormField(
                      //   controller: signUpCtrl.dateOfBirthCtrl,
                      //   labelText: 'dateOfBirth'.tr,
                      //   hintText: 'dateOfBirth'.tr,
                      //   readOnly: true,
                      //   keyboardType: TextInputType.emailAddress,
                      //   validator: (String? v) {
                      //     if (v!.isEmpty) {
                      //       return 'dateOfBirthRequired'.tr;
                      //     }
                      //     return null;
                      //   },
                      // ),
                      AppFormField(
                        fieldBgColor: kF8F9FF,
                        borderColor: kDarkGreen5b99a5,
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
                      size15h,
                      AppFormField(
                        fieldBgColor: kF8F9FF,
                        borderColor: kDarkGreen5b99a5,
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
                  size30h,
                  AppCustomButton(
                    title: customText(
                      text: 'Sign Up',
                      textStyle: regular16White.copyWith(fontSize: 18),
                    ),
                    enableLoading: true,
                    onTap: nextStepHandler,
                    borderRadius: Dimensions.radiusDoubleExtraLarge,
                    verticalPadding: 10,
                  ),
                  size30h,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () {
                          Get.to(() => const SignInScreen());
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

  void nextStepHandler() async {
    if (!Get.find<SignupController>().signUpFormKey.currentState!.validate()) {
      return;
    }
    showProgress();
    bool isSignUp = await signUp();
    if (!isSignUp) {
      stopProgress();
    }
    // signUpFunc(
    //   signCtrl.emailCtrl.text.trim(),
    //   signCtrl.passwordCtrl.text.trim(),
    //   signCtrl.phoneNumberCtrl.text.trim(),
    // );
    // signUp();
    // await _authService.signUpWithEmailAndPassword(signCtrl.emailCtrl.text,
    //     signCtrl.passwordCtrl.text, signCtrl.phoneNumberCtrl.text);
    // Get.offAll(() => const SignInScreen());
    // Get.find<SignupController>().signUp();
    // Get.to(
    //   () => AppOtpPage(
    //     heading: 'identityVerification'.tr,
    //     btnTxt: 'verifyTheOtp'.tr,
    //     route: 'signIn',
    //     subHeading: '',
    //     showLogo: true,
    //   ),
    // );
    // Get.to(
    //   () => const CreateNewAccountOtpPage(),
    //   transition: Transition.cupertino,
    //   duration: const Duration(seconds: 1),
    // );
    // showProgress();
    // authCtrl.postLogin();
  }
}
