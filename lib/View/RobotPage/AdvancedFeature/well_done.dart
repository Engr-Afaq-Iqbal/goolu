import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../../Config/app_config.dart';
import '../../../Theme/colors.dart';
import '../../../Utils/dimensions.dart';
import '../../../Utils/font_styles.dart';
import '../../../Utils/image_urls.dart';

class WellDone extends StatelessWidget {
  const WellDone({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        customText(
          text: 'Well Done!',
          maxLines: 10,
          textStyle: regular14NavyBlue.copyWith(
            color: secDarkBlueNavyColor,
            fontSize: 28,
          ),
          textAlign: TextAlign.center,
        ),
        size10h,
        Center(
          child: SvgPicture.asset(
            '$imgUrl$wellDoneImg',
            height: 250,
          ),
        ),
      ],
    );
  }
}
