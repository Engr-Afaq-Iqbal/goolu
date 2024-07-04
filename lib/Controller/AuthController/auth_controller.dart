import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';

class AuthController extends GetxController {
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  final signInFormKey = GlobalKey<FormState>();

  String _selectedLanguage = 'EN';
  bool _showPasswordField = false;
  String _otp = '';
  // bool _checkOtpFill = false;
  late AnimationController controller;
  late Animation<Offset> animation;
  late Animation<double> animation2;
  // String? token;

  Timer? timer;
  int remainingSeconds = 120; // 2 minutes = 120 seconds
  bool canResend = false;
  late TextEditingController emailCtrl;
  late TextEditingController passwordCtrl;

  initializeLoginControllers() {
    emailCtrl = TextEditingController();
    passwordCtrl = TextEditingController();
  }

  // bool get checkOtpFill => _checkOtpFill;
  // set setCheckOtpFill(bool value) {
  //   _checkOtpFill = value;
  // }

  String get otp => _otp;

  set setOtp(String value) {
    _otp = value;
  }

  String get selectedLanguage => _selectedLanguage;

  set selectLanguage(String value) {
    _selectedLanguage = value;
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

  clearAllController() {
    emailCtrl.clear();
    passwordCtrl.clear();
  }

  disposeAllController() {
    emailCtrl.dispose();
    passwordCtrl.dispose();
  }
}
