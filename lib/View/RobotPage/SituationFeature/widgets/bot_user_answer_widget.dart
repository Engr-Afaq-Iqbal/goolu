import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Theme/colors.dart';
import '../../../../Utils/dimensions.dart';
import '../../../../Utils/font_styles.dart';

class BotUserAnswerWidget extends StatelessWidget {
  final String? answer;
  const BotUserAnswerWidget({super.key, this.answer});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: 10.0,
        vertical: 5,
      ),
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 10,
          vertical: 10,
        ),
        width: Get.width,
        margin: const EdgeInsets.only(left: 20, top: 10, bottom: 5),
        decoration: BoxDecoration(
            color: kDarkYellow,
            borderRadius: const BorderRadius.only(
                topLeft: Radius.circular(Dimensions.radiusExtraLarge),
                bottomLeft: Radius.circular(Dimensions.radiusExtraLarge),
                topRight: Radius.circular(Dimensions.radiusExtraLarge))),
        child: SizedBox(
          width: SizesDimensions.width(50),
          child: customText(
              text: '$answer',
              maxLines: 5,
              textStyle: regular14NavyBlue.copyWith(
                fontSize: 14,
                color: kWhite,
              )),
        ),
      ),
    );
  }
}
