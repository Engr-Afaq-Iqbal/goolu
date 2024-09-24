import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Config/app_config.dart';
import '../../Controller/SideDrawerController/side_drawer_controller.dart';
import '../../Theme/colors.dart';
import '../../Utils/dimensions.dart';
import '../../Utils/font_styles.dart';

class NotificationsPage extends StatefulWidget {
  const NotificationsPage({super.key});

  @override
  State<NotificationsPage> createState() => _NotificationsPageState();
}

class _NotificationsPageState extends State<NotificationsPage> {
  SideDrawerController sideDrawerCtrl = Get.find<SideDrawerController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: GetBuilder<SideDrawerController>(
          builder: (SideDrawerController sideDrawerCtrl) {
        return Column(
          children: [
            Expanded(
              child: Container(
                width: Get.width,
                padding: EdgeInsets.symmetric(
                  vertical: SizesDimensions.height(3),
                  horizontal: SizesDimensions.width(5),
                ),
                decoration: BoxDecoration(
                  borderRadius: const BorderRadius.only(
                      topLeft:
                          Radius.circular(Dimensions.radiusDoubleExtraLarge),
                      topRight:
                          Radius.circular(Dimensions.radiusDoubleExtraLarge)),
                  color: kLightYellow.withOpacity(0.3),
                ),
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: customText(
                          text: 'Notifications',
                          textStyle: bold18NavyBlue,
                        ),
                      ),
                      size10h,
                      customText(
                        text: 'Common',
                        textStyle: bold16NavyBlue,
                      ),
                      size10h,
                      _buildSwitchRow(context, 'General Notifications',
                          'generalNotification'),
                      _buildSwitchRow(context, 'Sound', 'sound'),
                      _buildSwitchRow(context, 'Vibrate', 'vibrate'),
                      size20h,
                      AppStyles.dividerLine(),
                      size20h,
                      customText(
                        text: 'System & services update',
                        textStyle: bold16NavyBlue,
                      ),
                      size10h,
                      _buildSwitchRow(context, 'App Updates', 'appUpdates'),
                      _buildSwitchRow(context, 'Bill Reminder', 'billReminder'),
                      _buildSwitchRow(context, 'Promotion', 'promotion'),
                      _buildSwitchRow(
                          context, 'Discount Available', 'discountAvailable'),
                      _buildSwitchRow(
                          context, 'Payment Request', 'paymentRequest'),
                      size20h,
                      AppStyles.dividerLine(),
                      size20h,
                      customText(
                        text: 'Others',
                        textStyle: bold16NavyBlue,
                      ),
                      size10h,
                      _buildSwitchRow(context, 'New Service Available',
                          'newServiceAvailable'),
                      _buildSwitchRow(
                          context, 'New Tips Available', 'newTipsAvailable'),
                    ],
                  ),
                ),
              ),
            ),
          ],
        );
      }),
    );
  }

  // A function to build a row with the switch and label
  Widget _buildSwitchRow(BuildContext context, String label, String key) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          label,
          style: TextStyle(color: Theme.of(context).iconTheme.color),
        ),
        Obx(() => Switch(
              value: sideDrawerCtrl.switchValues[key]?.value ?? false,
              onChanged: (val) {
                sideDrawerCtrl.toggleSwitch(key, val);
              },
              activeColor: Theme.of(context).colorScheme.primary,
              inactiveThumbColor: Colors.blueGrey,
              inactiveTrackColor: Colors.grey,
            )),
      ],
    );
  }
}
