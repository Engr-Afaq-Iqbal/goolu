import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Config/app_config.dart';
import 'package:goolu/Theme/colors.dart';
import 'package:goolu/Utils/dimensions.dart';
import 'package:goolu/Utils/font_styles.dart';
import 'package:goolu/Utils/image_urls.dart';
import 'package:goolu/View/Subscription/subscription_plans_info.dart';

import '../../Components/app_custom_button.dart';

class SubscriptionMain extends StatefulWidget {
  const SubscriptionMain({super.key});

  @override
  State<SubscriptionMain> createState() => _SubscriptionMainState();
}

class _SubscriptionMainState extends State<SubscriptionMain> {
  // Initially selecting the second plan by default
  bool isSelected1 = false;
  bool isSelected2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomSheet: _buildBottomSheet(context),
      body: Stack(
        children: [
          SizedBox(
            width: Get.width,
            height: SizesDimensions.height(80),
            child: Image.asset(
              '$imgUrl$subscriptionBgImg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            top: 30,
            right: 20,
            child: Container(
              width: 45.0, // Size of the container
              height: 45.0, // Size of the container
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color:
                    kC8C8C8.withOpacity(0.7), // Background color of the circle
              ),
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.close, // "X" icon
                    color: Colors.black, // Icon color
                    size: 24.0, // Icon size
                  ),
                  onPressed: () {
                    Get.back();
                  },
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 190,
            right: 50,
            left: 50,
            child: Center(
              child: customText(
                  text: '20% OFF',
                  textStyle: bold25White.copyWith(fontSize: 48)),
            ),
          ),
          Positioned(
            bottom: 165,
            right: 20,
            left: 20,
            child: Center(
              child: customText(
                text: 'Get this exclusive limited offer!',
                textStyle: regular16White.copyWith(fontSize: 20),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          size30h,
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () {
                  setState(() {
                    // Setting isSelected1 to true and isSelected2 to false when first plan is selected
                    isSelected1 = true;
                    isSelected2 = false;
                  });
                },
                child: _buildPlanCard(
                  context,
                  title: 'YEARLY',
                  price: 'SAR 540 / year',
                  isPopular: false,
                  id: 1,
                  isSelected: isSelected1, // Pass the selected state
                ),
              ),
              GestureDetector(
                onTap: () {
                  setState(() {
                    // Setting isSelected2 to true and isSelected1 to false when second plan is selected
                    isSelected2 = true;
                    isSelected1 = false;
                  });
                },
                child: _buildPlanCard(
                  context,
                  title: 'YEARLY',
                  price: 'SAR 780 / year',
                  isPopular: true,
                  id: 2,
                  isSelected: isSelected2, // Pass the selected state
                ),
              ),
            ],
          ),
          size40h,
          AppCustomButton(
            title: customText(text: 'GET INFO', textStyle: bold16White),
            onTap: () {
              Get.to(() => const SubscriptionPlansInfo());
            },
          ),
          size40h,
        ],
      ),
    );
  }

  Widget _buildPlanCard(BuildContext context,
      {required String title,
      required String price,
      required bool isPopular,
      required int id,
      required bool isSelected}) {
    return SizedBox(
      height: SizesDimensions.height(17),
      child: Stack(
        children: [
          Align(
            alignment: Alignment.bottomCenter,
            child: Container(
              width: SizesDimensions.width(44),
              height: SizesDimensions.height(17),
              decoration: BoxDecoration(
                // Change the border color based on the selected state
                border: Border.all(
                  color:
                      isSelected ? primaryColor : Colors.grey.withOpacity(0.7),
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
              ),
              padding: const EdgeInsets.all(14),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  size20h,
                  customText(
                    text: title,
                    textStyle: bold20NavyBlue,
                  ),
                  size5h,
                  customText(
                    text: price,
                    textStyle: bold20NavyBlue,
                  ),
                  size10h,
                  customText(
                    text: 'No free trial',
                    textStyle: regular16NavyBlue,
                  ),
                ],
              ),
            ),
          ),
          if (isPopular)
            Positioned(
              top: 0,
              left: 40,
              right: 40,
              child: Container(
                padding: EdgeInsets.symmetric(
                    horizontal: SizesDimensions.width(1),
                    vertical: SizesDimensions.height(0.6)),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(Dimensions.radiusDefault),
                ),
                child: Center(
                  child: customText(
                    text: 'Popular',
                    textStyle: bold16NavyBlue,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
