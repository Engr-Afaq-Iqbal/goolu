import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/date_time_format.dart';
import '../../Model/UserModel/usersModel.dart';
import '../../Services/storage_sevices.dart';
import '../../Utils/utils.dart';

class SideDrawerController extends GetxController {
  TextEditingController usernameCtrl = TextEditingController();
  TextEditingController iqamaNumberCtrl = TextEditingController();
  TextEditingController emailCtrl = TextEditingController();
  TextEditingController dateOfBirthCtrl = TextEditingController();
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

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
// Update user data
  Future<void> updateUserData(UserModel user) async {
    try {
      // Update Firestore document
      await _firestore
          .collection('users')
          .doc(user.userId)
          .update(user.toMap());

      // If you want to store updated data locally
      // await AppStorage.box.erase();
      await AppStorage.setUserData(
          user); // Make sure you have this method in AppStorage

      showToast('Your data updated successfully!');
      Get.back();
      // Get.offAll(
      //   () => const AppBottomNavigationBar(),
      // );
      update();
    } catch (e) {
      showToast('Failed to update your data: $e');
      logger.e('Error updating user data: $e');
    }
    stopProgress();
  }
}
