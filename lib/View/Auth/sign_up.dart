import 'package:dropdown_button2/dropdown_button2.dart';
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
  SignupController signCtrl = Get.find<SignupController>();

  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        // resizeToAvoidBottomInset: true,
        body: GetBuilder<SignupController>(
            builder: (SignupController signUpCtrl) {
          return Form(
            key: signUpCtrl.signUpFormKey,
            child: Padding(
              padding: EdgeInsets.symmetric(
                horizontal: SizesDimensions.width(4.0),
              ),
              child: SingleChildScrollView(
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
                    size50h,
                    AppFormField(
                        // isOutlineBorder: false,
                        fieldBgColor: kF8F9FF,
                        borderColor: kDarkGreen5b99a5,
                        controller: signUpCtrl.usernameCtrl,
                        labelText: 'Username',
                        hintText: 'Muhammad',
                        keyboardType: TextInputType.text,
                        validator: (String? v) {
                          if (v!.isEmpty) {
                            return 'Username required';
                          }
                          return null;
                        }),
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
                    size15h,
                    AppFormField(
                      controller: signUpCtrl.phoneNumberCtrl,
                      labelText: 'phoneNumber'.tr,
                      hintText: 'phoneNumber'.tr,
                      keyboardType: TextInputType.number,
                      validator: (String? v) {
                        if (v!.isEmpty) {
                          return 'Phone number required'.tr;
                        }
                        return null;
                      },
                      onChanged: (v) {
                        signUpCtrl.update();
                      },
                    ),
                    // AppFormFieldPhone(
                    //   maxLength: 9,
                    //   controller: signUpCtrl.phoneNumberCtrl,
                    //   labelText: 'phoneNumber'.tr,
                    //   hintText: 'phoneNumber'.tr,
                    //   keyboardType: TextInputType.number,
                    //   validator: (String? v) {
                    //     if (v!.isEmpty) {
                    //       return 'Phone number required'.tr;
                    //     }
                    //     return null;
                    //   },
                    // ),
                    size15h,
                    AppFormField(
                      controller: signUpCtrl.dateOfBirthCtrl,
                      labelText: 'dateOfBirth'.tr,
                      hintText: 'dateOfBirth'.tr,
                      readOnly: true,
                      keyboardType: TextInputType.text,
                      onTap: () {
                        signUpCtrl.selectedDate(context);
                      },
                      validator: (String? v) {
                        if (v!.isEmpty) {
                          return 'dateOfBirthRequired'.tr;
                        }
                        return null;
                      },
                      onChanged: (v) {
                        signUpCtrl.update();
                      },
                    ),
                    size15h,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: SizesDimensions.height(6.0),
                          width: SizesDimensions.width(45.0),
                          margin: EdgeInsets.only(
                            bottom: SizesDimensions.height(0.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Align(
                                  alignment: AlignmentDirectional.centerStart,
                                  child: customText(
                                    text: 'Country',
                                    textStyle: regular14NavyBlue.copyWith(
                                        color:
                                            Theme.of(context).iconTheme.color),
                                  )),
                              items: signUpCtrl.countryList.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: customText(
                                    text: e,
                                    textStyle: bold14NavyBlue.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: signUpCtrl.selectedItem,
                              onChanged: (String? value) {
                                setState(() {
                                  signUpCtrl.selectedItem = value;
                                  // Print selected key and value
                                  if (value != null) {
                                    debugPrint('Selected key: $value');
                                    debugPrint(
                                        'Selected value: ${signUpCtrl.selectedItem}');
                                  }
                                });
                                signUpCtrl.update();
                              },
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: SizesDimensions.height(50.0),
                                width: SizesDimensions.width(50.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color:
                                      Theme.of(context).dialogBackgroundColor,
                                ),
                                offset: const Offset(-5, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: WidgetStateProperty.all(6),
                                  thumbVisibility:
                                      WidgetStateProperty.all(true),
                                ),
                              ),
                              buttonStyleData: ButtonStyleData(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    color: kWhite,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusDefault)),
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizesDimensions.width(2.0),
                                ),
                                height: SizesDimensions.height(6.0),
                                width: Get.width,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          height: SizesDimensions.height(6.0),
                          width: SizesDimensions.width(45.0),
                          margin: EdgeInsets.only(
                            bottom: SizesDimensions.height(0.0),
                          ),
                          child: DropdownButtonHideUnderline(
                            child: DropdownButton2(
                              isExpanded: true,
                              hint: Align(
                                alignment: AlignmentDirectional.centerStart,
                                child: customText(
                                  text: 'Gender',
                                  textStyle: regular14NavyBlue.copyWith(
                                      color: Theme.of(context).iconTheme.color),
                                ),
                              ),
                              items: signUpCtrl.genderList.map((e) {
                                return DropdownMenuItem(
                                  value: e,
                                  child: customText(
                                    text: e,
                                    textStyle: bold14NavyBlue.copyWith(
                                      color: Colors.grey,
                                    ),
                                  ),
                                );
                              }).toList(),
                              value: signUpCtrl.selectedGenderItem,
                              onChanged: (String? value) {
                                setState(() {
                                  signUpCtrl.selectedGenderItem = value;
                                  // Print selected key and value
                                  if (value != null) {
                                    debugPrint('Selected key: $value');
                                    debugPrint(
                                        'Selected value: ${signUpCtrl.selectedGenderItem}');
                                  }
                                });
                                signUpCtrl.update();
                              },
                              dropdownStyleData: DropdownStyleData(
                                maxHeight: SizesDimensions.height(50.0),
                                width: SizesDimensions.width(50.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(14),
                                  color:
                                      Theme.of(context).dialogBackgroundColor,
                                ),
                                offset: const Offset(-5, 0),
                                scrollbarTheme: ScrollbarThemeData(
                                  radius: const Radius.circular(40),
                                  thickness: WidgetStateProperty.all(6),
                                  thumbVisibility:
                                      WidgetStateProperty.all(true),
                                ),
                              ),
                              buttonStyleData: ButtonStyleData(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    color: kWhite,
                                    borderRadius: BorderRadius.circular(
                                        Dimensions.radiusDefault)),
                                padding: EdgeInsets.symmetric(
                                  horizontal: SizesDimensions.width(2.0),
                                ),
                                height: SizesDimensions.height(6.0),
                                width: Get.width,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    size15h,
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
                    size30h,
                    AppCustomButton(
                      title: customText(
                        text: 'Sign Up',
                        textStyle: regular16White.copyWith(fontSize: 18),
                      ),
                      enableLoading: false,
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
                    size40h,
                    // const Spacer(),
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
                  ],
                ),
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
    bool isSignUp = await signCtrl.registerUser();
    if (!isSignUp) {
      stopProgress();
    }
  }
}
