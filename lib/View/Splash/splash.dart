import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Utils/dimensions.dart';

import '../../Config/app_config.dart';
import '../../Controller/AuthController/auth_controller.dart';
import '../../Theme/colors.dart';
import '../Auth/continue_page.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  AuthController authCtrl = Get.find<AuthController>();

  @override
  void initState() {
    super.initState();

    authCtrl.controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 2),
    );

    authCtrl.animation2 =
        Tween<double>(begin: 0, end: 1).animate(authCtrl.controller);
    authCtrl.animation = Tween<Offset>(
      begin: const Offset(-10.0, 0.0),
      end: const Offset(0.0, 0.0),
    ).animate(CurvedAnimation(
      parent: authCtrl.controller,
      curve: Curves.easeInCubic,
    ));

    authCtrl.controller.forward();
    authCtrl.controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        Future.delayed(const Duration(seconds: 4), () {
          Get.offAll(() => const ContinuePage(),
              transition: Transition.downToUp,
              duration: const Duration(seconds: 1));
        });

        // Future.delayed(const Duration(seconds: 2), () {
        //   Get.offAll(() => const HomePageNoLogin(),
        //       transition: Transition.downToUp,
        //       duration: const Duration(seconds: 1));
        //   // if (authCtrl.token == '' || authCtrl.token == null) {
        //   //   Get.offAll(const SignInScreen());
        //   // } else {
        //   //   Get.offAll(const AppBottomNavigationBar());
        //   // }
        // });
      }
    });
  }

  @override
  void dispose() {
    authCtrl.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: kWhite,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SlideTransition(
              position: authCtrl.animation,
              child: Image.asset(
                '${gooluLogoUrl}goolu.png',
                width: SizesDimensions.width(80),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
