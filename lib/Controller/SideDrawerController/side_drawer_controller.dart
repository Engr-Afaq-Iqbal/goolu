import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SideDrawerController extends GetxController {
  TextEditingController fullNameCtrl = TextEditingController();
  TextEditingController nickNameCtrl = TextEditingController();
  TextEditingController labelCtrl = TextEditingController();
  TextEditingController phoneNumberCtrl = TextEditingController();
  TextEditingController addressCtrl = TextEditingController();
  String? selectedItem;
  String? selectedGenderItem;
  List<String> countryList = ['USA', 'Canada', 'Pakistan', 'Saudi Arabia'];
  List<String> genderList = [
    'Male',
    'Female',
  ];
  int? languageLevel;
  int? cferLevel;
  bool isDisable = false;
  // var isSwitched = false.obs; // Observable boolean variable for the switch
  //
  // void toggleSwitch(bool value) {
  //   isSwitched.value = value;
  // }
  var switchValues = {
    'generalNotification': false.obs,
    'sound': false.obs,
    'vibrate': false.obs,
    'appUpdates': false.obs,
    'billReminder': false.obs,
    'promotion': false.obs,
    'discountAvailable': false.obs,
    'paymentRequest': false.obs,
    'newServiceAvailable': false.obs,
    'newTipsAvailable': false.obs,
  };

  // Toggle function for switches
  void toggleSwitch(String key, bool value) {
    switchValues[key]?.value =
        value; // update the value of the corresponding switch
  }
}
