import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/View/Auth/sign_in.dart';

import '../../../Components/app_custom_button.dart';
import '../../../Components/app_form_field.dart';
import '../../../Components/app_form_field_phone.dart';
import '../../../Config/app_config.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';
import '../../Components/app_custom_app_bar.dart';
import '../../Controller/AuthController/sign_up_controller.dart';
import '../../Services/auth_service.dart';
import '../../Utils/utils.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final AuthService _authService = AuthService();
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
        print('User created and data stored successfully.');
      }
    } on FirebaseAuthException catch (e) {
      print('Error: $e');
      // Handle errors here
    }
  }

  Future<void> signUp() async {
    try {
      await firebaseAuth
          .createUserWithEmailAndPassword(
        email: signCtrl.emailCtrl.text.trim(),
        password: signCtrl.passwordCtrl.text.trim(),
      )
          .then((val) {
        Get.to(const SignInScreen());
        logger.i(val);
      });
      // Sign-up successful, navigate to home or another scree
    } on FirebaseAuthException catch (e) {
      // Handle error
      logger.e(e.message);
    } catch (e) {
      logger.e('An unknown error occurred.');
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
    if (!Get.find<SignupController>().signUpFormKey.currentState!.validate()) {
      return;
    }

    signUp();
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
