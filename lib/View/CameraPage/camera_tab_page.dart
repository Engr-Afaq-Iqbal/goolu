import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Controller/CameraController/camera_controller.dart';

import '../../../Theme/colors.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';
import '../../Config/app_config.dart';

class CameraTabPage extends StatelessWidget {
  const CameraTabPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: CameraController.viewSingleRobotTabsList.length,
      child: Scaffold(
        body: Column(
          children: [
            SizedBox(
              height: SizesDimensions.height(7.0),
              child: TabBar(
                tabs: CameraController.viewSingleRobotTabsList.map((orderTab) {
                  return Tab(
                    text: orderTab.label,
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
                  children: CameraController.viewSingleRobotTabsList
                      .map((offersTab) => offersTab.page)
                      .toList()),
            ),
          ],
        ),
      ),
    );
  }
}
