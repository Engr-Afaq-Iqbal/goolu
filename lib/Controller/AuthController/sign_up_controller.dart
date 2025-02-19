import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/date_time_format.dart';
import '../../Utils/utils.dart';
import '../../View/Auth/sign_in.dart';

class SignupController extends GetxController {
  int _selectedType = 0;
  int _calenderType = 0;
  bool _isStep2Completed = false;
  bool _isStep3Completed = false;
  bool _isStep4Completed = false;
  bool _isAgreementCheckBox = false;
  int numberOfYears = 0;
  String _selectedAccountType = '';
  final signUpFormKey = GlobalKey<FormState>();
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  TextEditingController iqamaNumberCtrl = TextEditingController();
  TextEditingController dateOfBirthCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  String? selectedItem;
  String? selectedGenderItem;
  List<String> countryList = ['USA', 'Canada', 'Pakistan', 'Saudi Arabia'];
  List<String> genderList = [
    'Male',
    'Female',
  ];

  clearAllFields() {
    usernameCtrl.clear();
    emailCtrl.clear();
    passwordCtrl.clear();
    confirmPasswordCtrl.clear();
    iqamaNumberCtrl.clear();
    dateOfBirthCtrl.clear();
    phoneNumberCtrl.clear();
    selectedItem = null;
    selectedGenderItem = null;
  }

  int get selectedType => _selectedType;

  set setSelectedType(int value) {
    _selectedType = value;
  }

  String get selectedAccountType => _selectedAccountType;

  set setSelectedAccountType(String value) {
    _selectedAccountType = value;
  }

  bool get agreementCheckBox => _isAgreementCheckBox;

  set setAgreementCheckBox(bool value) {
    _isAgreementCheckBox = value;
  }

  int get calenderType => _calenderType;

  set setCalenderType(int value) {
    _calenderType = value;
  }

  bool get isStep2Completed => _isStep2Completed;

  set setStep2Completed(bool value) {
    _isStep2Completed = value;
  }

  bool get isStep3Completed => _isStep3Completed;

  set setStep3Completed(bool value) {
    _isStep3Completed = value;
  }

  bool get isStep4Completed => _isStep4Completed;

  set setStep4Completed(bool value) {
    _isStep4Completed = value;
  }

  void showTermsAndConditions(BuildContext context) {
    // showModalBottomSheet(
    //   context: context,
    //   shape: const RoundedRectangleBorder(
    //     borderRadius: BorderRadius.vertical(top: Radius.circular(20.0)),
    //   ),
    //   builder: (context) => const PlatformAgreement(),
    // );
  }

  String? educationStatus;
  List<String> getEducationLevelList() {
    List<String> options = [];
    // for (int i = 0; i < listUserCtrlObj!.listuserModel!.data!.length; i++) {
    //   options.add(
    //       '${listUserCtrlObj.listuserModel?.data?[i].firstName}');
    // }
    options.add('Bachelors Level');
    return options;
  }

  increment() {
    numberOfYears++;
    update();
  }

  decrement() {
    numberOfYears--;
    update();
  }

  Future<void> selectedDate(context) async {
    DateTime? selectedDate = await showDatePicker(
      context: context,
      firstDate: DateTime(1970),
      lastDate: DateTime(2050),
      initialDate: DateTime.now().subtract(const Duration(days: 365 * 18)),
      confirmText: 'ok'.tr,
      cancelText: 'cancel'.tr,
    );
    dateOfBirthCtrl.text = AppFormatDate.ddMMYYYY(selectedDate);
    update();
    debugPrint(dateOfBirthCtrl.text);
  }

  Future<bool> registerUser() async {
    try {
      // Create a new user with email and password
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: emailCtrl.text.trim(),
        password: passwordCtrl.text.trim(),
      );

      // After successful registration, store additional user details in Firestore
      await _firestore.collection('users').doc(userCredential.user!.uid).set({
        'username': usernameCtrl.text.trim(),
        'userId': userCredential.user!.uid,
        'dob': dateOfBirthCtrl.text.trim(),
        'email': emailCtrl.text.trim(),
        'iqamaNumber': iqamaNumberCtrl.text.trim(),
        'phoneNumber': phoneNumberCtrl.text.trim(),
        'password': passwordCtrl.text.trim(),
        'confirmPassword': confirmPasswordCtrl.text.trim(),
        'profilePic': '',
        'country': '$selectedItem',
        'gender': '$selectedGenderItem',
        'address': '',
      });
      clearAllFields();
      Get.offAll(const SignInScreen());
      logger.i('User created Successfully');
      return true;
    } on FirebaseAuthException catch (e) {
      // Handle errors
      showToast('$e');
      logger.e('An unknown error occurred.-->> $e');
    }
    return false;
  }
}
