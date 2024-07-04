import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';

import '../Config/app_config.dart';
import '../Utils/dimensions.dart';
import '../Utils/font_styles.dart';

class NoLoginWidget extends StatelessWidget {
  const NoLoginWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SvgPicture.asset('${imgUrl}profileImg.svg'),
        size30h,
        customText(
            text: 'noLoginDescription'.tr,
            textStyle: regular14NavyBlue,
            maxLines: 5,
            textAlign: TextAlign.center),
      ],
    );
  }
}
