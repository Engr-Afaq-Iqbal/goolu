import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Theme/colors.dart';
import '../../../../Utils/dimensions.dart';
import '../../../../Utils/font_styles.dart';

class BotQuestionWidget extends StatelessWidget {
  final String? question;
  const BotQuestionWidget({super.key, this.question});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10.0, vertical: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // customText(
          //   text: 'Bot',
          //   textStyle: bold14NavyBlue.copyWith(
          //     fontSize: 14,
          //   ),
          // ),
          // size5h,
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
            width: Get.width,
            margin: const EdgeInsets.only(right: 30),
            decoration: BoxDecoration(
                color: kWhite,
                borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(Dimensions.radiusExtraLarge),
                    bottomRight: Radius.circular(Dimensions.radiusExtraLarge),
                    topRight: Radius.circular(Dimensions.radiusExtraLarge))),
            child: SizedBox(
              width: SizesDimensions.width(50),
              child: customText(
                  text: '$question',
                  maxLines: 5,
                  textStyle: regular14NavyBlue.copyWith(fontSize: 14)),
            ),
          )
        ],
      ),
    );
  }
}
