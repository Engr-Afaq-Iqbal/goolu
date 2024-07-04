import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Components/app_custom_button.dart';
import 'package:goolu/Utils/dimensions.dart';
import 'package:goolu/View/Auth/sign_in.dart';

import '../../Components/custom_painter_class.dart';
import '../../Config/app_config.dart';
import '../../Theme/colors.dart';
import '../../Utils/font_styles.dart';

class ContinuePage extends StatefulWidget {
  const ContinuePage({super.key});

  @override
  State<ContinuePage> createState() => _ContinuePageState();
}

class _ContinuePageState extends State<ContinuePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        decoration: BoxDecoration(
          color: kWhite,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: CustomPaint(
                    painter: CustomStyleArrow(),
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      child: Center(
                        child: customText(
                            text: 'Welcome to Gool-u\ncan you say it?',
                            textStyle: bold16White,
                            maxLines: 3,
                            textAlign: TextAlign.center),
                      ),
                    ),
                  ),
                ),
                // Container(
                //   padding: const EdgeInsets.all(20),
                //   margin: const EdgeInsets.symmetric(horizontal: 20),
                //   height: SizesDimensions.height(10),
                //   decoration: BoxDecoration(
                //     borderRadius: BorderRadius.circular(30),
                //     color: kYellowffde59,
                //   ),
                //   child: Center(
                //     child: customText(
                //         text: 'Welcome to Gool-u\ncan you say it?',
                //         textStyle: bold16White,
                //         maxLines: 3,
                //         textAlign: TextAlign.center),
                //   ),
                // )
              ],
            ),
            Image.asset(
              '${gooluLogoUrl}goolu.png',
              width: SizesDimensions.width(80),
            ),
            size150h,
            Padding(
              padding:
                  EdgeInsets.symmetric(horizontal: SizesDimensions.width(20)),
              child: AppCustomButton(
                padding: EdgeInsets.symmetric(vertical: 15),
                title: customText(
                  text: 'Continue',
                  textStyle: bold20White,
                ),
                onTap: () {
                  Get.to(() => const SignInScreen(),
                      transition: Transition.downToUp,
                      duration: const Duration(seconds: 1));
                },
                borderRadius: 10,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
