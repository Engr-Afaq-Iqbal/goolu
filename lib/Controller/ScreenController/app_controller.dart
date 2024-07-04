import 'package:get/get.dart';
import 'package:goolu/Controller/AuthController/forget_password_controller.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';

import '../AuthController/auth_controller.dart';
import '../AuthController/sign_up_controller.dart';

class AppController {
  static void initializeControllers() {
    Get.put(AuthController());
    Get.put(SignupController());
    Get.put(ForgetPasswordController());
    Get.put(MicrophoneController());
  }
}
