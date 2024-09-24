import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class DialogController extends GetxController {
  var isDialogOpen = false.obs;

  void showDialog(Widget dialog) {
    if (isDialogOpen.value) {
      Get.back(); // Close the existing dialog
    }

    isDialogOpen.value = true;

    Get.dialog(
      dialog,
      barrierDismissible: false,
    ).then((_) {
      isDialogOpen.value = false;
    });
  }

  void closeDialog() {
    if (isDialogOpen.value) {
      Get.back();
      isDialogOpen.value = false;
    }
  }
}
