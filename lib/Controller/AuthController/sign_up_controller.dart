import 'package:flutter/material.dart';
import 'package:get/get.dart';

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
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController passwordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  TextEditingController iqamaNumberCtrl = TextEditingController();
  TextEditingController dateOfBirthCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController authPhoneNumberCtrl = TextEditingController();
  TextEditingController commercialRegistrationNumberCtrl =
      TextEditingController();

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
}
