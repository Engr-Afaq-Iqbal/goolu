import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/AuthController/auth_controller.dart';

import '../Config/app_config.dart';
import '../Theme/colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/image_urls.dart';
import '../View/CameraPage/camera_main.dart';
import '../View/Dashboard/dashboard.dart';
import '../View/Drawer/drawer_design.dart';
import '../View/MicrophonePage/microphone_page.dart';
import '../View/RobotPage/robot_main.dart';

class AppBottomNavigationBar extends StatefulWidget {
  const AppBottomNavigationBar({
    super.key,
  });

  @override
  State<AppBottomNavigationBar> createState() => _AppBottomNavigationBarState();
}

class _AppBottomNavigationBarState extends State<AppBottomNavigationBar> {
  late int currentIndex = 0;
  late List<Widget> screens;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    screens = [
      const Dashboard(),
      const CameraMain(),
      const MicrophonePage(),
      const RobotMain(),
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
        height: SizesDimensions.height(9.0),
        decoration: BoxDecoration(
            color: kWhite,
            // boxShadow: [
            //   BoxShadow(
            //     color: Colors.grey.withOpacity(0.1),
            //     spreadRadius: 2,
            //     blurRadius: 3,
            //     offset: const Offset(0, 1),
            //   ),
            // ],
            border: Border(
              top: BorderSide(
                color: kYellowffde59, // Color of the border
                width: 1.0, // Thickness of the border
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
                '$imgUrl$dashboardIconImg',
                colorFilter: ColorFilter.mode(
                  (currentIndex == 0) ? primaryColor : secDarkGreyIconColor,
                  BlendMode.srcIn,
                ),
                height: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                '$imgUrl$cameraIconImg',
                colorFilter: ColorFilter.mode(
                  (currentIndex == 1) ? primaryColor : secDarkGreyIconColor,
                  BlendMode.srcIn,
                ),
                height: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                '$imgUrl$micIconImg',
                colorFilter: ColorFilter.mode(
                  (currentIndex == 2) ? primaryColor : secDarkGreyIconColor,
                  BlendMode.srcIn,
                ),
                height: 35,
              ),
              label: '',
            ),
            BottomNavigationBarItem(
              icon: SvgPicture.asset(
                '$imgUrl$msgIconImg',
                colorFilter: ColorFilter.mode(
                  (currentIndex == 3) ? primaryColor : secDarkGreyIconColor,
                  BlendMode.srcIn,
                ),
                height: 35,
              ),
              label: '',
            ),
          ],
          currentIndex: currentIndex,
          elevation: 0,
          unselectedItemColor: secDarkGreyIconColor,
          selectedItemColor: primaryColor,
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
