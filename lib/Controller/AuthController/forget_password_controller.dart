import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class ForgetPasswordController extends GetxController {
  final forgetPasswordFormKey = GlobalKey<FormState>();
  final setNewPasswordFormKey = GlobalKey<FormState>();
  Timer? timer;
  int remainingSeconds = 120; // 2 minutes = 120 seconds
  bool canResend = false;
  String _otp = '';
  bool _showPasswordField = false;

  TextEditingController forgetEmailCtrl = TextEditingController();
  TextEditingController newPasswordCtrl = TextEditingController();
  TextEditingController confirmPasswordCtrl = TextEditingController();
  String get otp => _otp;

  set setOtp(String value) {
    _otp = value;
  }

  bool get showPasswordField => _showPasswordField;

  set setShowPasswordField(bool value) {
    _showPasswordField = value;
  }

  void startTimer() {
    canResend = false;
    remainingSeconds = 120;
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (remainingSeconds > 0) {
        remainingSeconds--;
        update();
      } else {
        timer.cancel();
        canResend = true;
        update();
      }
    });
  }

  String formatDuration(int seconds) {
    final minutes = seconds ~/ 60;
    final remainingSeconds = seconds % 60;
    return '$minutes:${remainingSeconds.toString().padLeft(2, '0')}';
  }

  clearAllForgetPasswordController() {
    forgetEmailCtrl.clear();
    newPasswordCtrl.clear();
    confirmPasswordCtrl.clear();
  }

  disposeAllForgetPasswordController() {
    forgetEmailCtrl.dispose();
    newPasswordCtrl.dispose();
    confirmPasswordCtrl.dispose();
  }
}
