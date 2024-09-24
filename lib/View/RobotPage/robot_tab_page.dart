import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/RobotController/robot_controller.dart';

import '../../../Theme/colors.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';
import '../../Config/app_config.dart';

class RobotTabPage extends StatelessWidget {
  const RobotTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: RobotController.viewSingleRobotTabsList.length,
      child: Scaffold(
        // bottomNavigationBar:
        // (AppStorage.getUserToken()?.data?.accessToken != '' ||
        //     AppStorage.getUserToken()?.data?.accessToken != null)
        //     ? Padding(
        //   padding: EdgeInsets.symmetric(
        //     horizontal: SizesDimensions.width(3),
        //     vertical: SizesDimensions.height(1),
        //   ),
        //   child: AppCustomButton(
        //     title: customText(
        //       text: 'investInThisOpportunity'.tr,
        //       textStyle: bold16White,
        //     ),
        //     onTap: investmentHandler,
        //     borderRadius: 4,
        //   ),
        // )
        //     : const SizedBox.shrink(), // Empty widget if not logged in
        body: Column(
          children: [
            SizedBox(
              height: SizesDimensions.height(7.0),
              child: TabBar(
                tabs: RobotController.viewSingleRobotTabsList.map((orderTab) {
                  return Tab(
                    text: orderTab.label,
                    // text: null,
                    // icon: SvgPicture.asset(
                    //   '${orderTab.iconsUrl}',
                    //   height: 22,
                    // ),
                  );
                }).toList(),
                labelStyle: bold12Blue,
                dividerColor: Colors.transparent,
                indicatorSize: TabBarIndicatorSize.tab,
                // labelPadding: const EdgeInsets.symmetric(horizontal: 0),
                indicatorPadding: const EdgeInsets.symmetric(horizontal: 10),
                unselectedLabelColor: primaryBlueColor.withOpacity(0.5),
                labelColor: primaryBlueColor,
                indicatorColor: primaryBlueColor,
              ),
            ),
            AppStyles.dividerLine(width: Get.width),
            Expanded(
              child: TabBarView(
                  children: RobotController.viewSingleRobotTabsList
                      .map((offersTab) => offersTab.page)
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
