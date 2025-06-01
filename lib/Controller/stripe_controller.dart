import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../Utils/utils.dart';

class StripeController extends GetxController {
  String? publishableKeyTest;
  String? secretKeyTest;
  String? publishableKey;
  String? secretKey;
  bool isLoadingStripeKeys = false;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;

  Future<void> fetchStripeKeys() async {
    isLoadingStripeKeys = true;
    update(); // Notify listeners about loading state

    try {
      DocumentSnapshot doc =
          await firestore.collection("settings").doc("stripeKeys").get();

      if (doc.exists) {
        publishableKeyTest = doc['publishableKeyTest'];
        secretKeyTest = doc['secretKeyTest'];
        publishableKey = doc['publishableKey'];
        secretKey = doc['secretKey'];
        logger.i("Fetched Stripe Keys:");
        logger.i("Publishable Key: $publishableKey");
        logger.i("Secret Key: $secretKey");
      } else {
        publishableKey = "Not found";
        secretKey = "Not found";
        logger.w("Stripe keys not found in Firestore");
      }
    } catch (e) {
      publishableKey = "Error";
      secretKey = "Error";
      logger.e("Error fetching Stripe keys: $e");
    } finally {
      isLoadingStripeKeys = false;
      update(); // Notify listeners that loading has finished
    }
  }
}
