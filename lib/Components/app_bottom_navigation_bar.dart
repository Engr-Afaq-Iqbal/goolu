import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/AuthController/auth_controller.dart';

import '../Config/app_config.dart';
import '../Theme/colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/image_urls.dart';
import '../View/CameraPage/camera_page.dart';
import '../View/Dashboard/dashboard.dart';
import '../View/Drawer/drawer_design.dart';
import '../View/MicrophonePage/microphone_page.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    super.key,
  });

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  late int currentIndex = 1;
  late List<Widget> screens;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens = [
      const Dashboard(),
      const CameraPage(),
      const MicrophonePage(),
      const CameraPage(),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: Get.find<AuthController>().scaffoldKey,
      drawer: Drawer(
        width: SizesDimensions.width(60),
        child: const DrawerDesign(),
      ),
      body: Center(
        child: screens[currentIndex],
      ),
      bottomNavigationBar: Container(
        height: SizesDimensions.height(13.0),
        decoration: BoxDecoration(
            color: kFFFFFF,
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.1),
                spreadRadius: 2,
                blurRadius: 3,
                offset: const Offset(0, 1),
              ),
            ],
            border: Border(
              top: BorderSide(
                color: kYellowffde59, // Color of the border
                width: 5.0, // Thickness of the border
              ),
            ),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(Dimensions.paddingSizeDoubleExtraLarge),
              topLeft: Radius.circular(Dimensions.paddingSizeDoubleExtraLarge),
            )
            // color: const Color(0xff527556).withOpacity(0.90),
            ),
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: Colors.transparent,
          items: <BottomNavigationBarItem>[
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                '$imgUrl$dashboardImage',
                colorFilter: ColorFilter.mode(
                  (currentIndex == 0) ? primaryBlueColor : secDarkGreyIconColor,
                  BlendMode.srcIn,
                ),
                height: 50,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                '$imgUrl$cameraImage',
                colorFilter: ColorFilter.mode(
                  (currentIndex == 1) ? primaryBlueColor : secDarkGreyIconColor,
                  BlendMode.srcIn,
                ),
                height: 50,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                '$imgUrl$micImage',
                colorFilter: ColorFilter.mode(
                  (currentIndex == 2) ? primaryBlueColor : secDarkGreyIconColor,
                  BlendMode.srcIn,
                ),
                height: 50,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                '$imgUrl$speakImage',
                colorFilter: ColorFilter.mode(
                  (currentIndex == 3) ? primaryBlueColor : secDarkGreyIconColor,
                  BlendMode.srcIn,
                ),
                height: 50,
              ),
              label: '',
            ),
          ],
          currentIndex: currentIndex,
          elevation: 0,
          unselectedItemColor: secDarkGreyIconColor,
          selectedItemColor: primaryBlueColor,
          onTap: (index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}
