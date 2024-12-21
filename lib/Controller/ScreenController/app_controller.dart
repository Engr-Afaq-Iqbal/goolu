import 'package:get/get.dart';
import 'package:goolu/Controller/AuthController/forget_password_controller.dart';
import 'package:goolu/Controller/CameraController/camera_speech_controller.dart';
import 'package:goolu/Controller/DashboardController/dashboard_controller.dart';
import 'package:goolu/Controller/MicrophoneController/microphone_controller.dart';
import 'package:goolu/Controller/RobotController/robot_controller.dart';
import 'package:goolu/Controller/SideDrawerController/side_drawer_controller.dart';

import '../AuthController/auth_controller.dart';
import '../AuthController/sign_up_controller.dart';
import '../CameraController/camera_controller.dart';
import '../dialog_controller.dart';

class AppController {
  static void initializeControllers() {
    Get.put(AuthController());
    Get.put(SignupController());
    Get.put(ForgetPasswordController());
    Get.put(MicrophoneController());
    Get.put(DialogController());
    Get.put(CameraController());
    Get.put(RobotController());
    Get.put(SideDrawerController());
    Get.put(DashboardController());
    Get.put(CameraSpeechController());
  }
}
