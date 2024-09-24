import 'package:flutter/material.dart';
import 'package:get/get.dart';

class Dimensions {
  static double fontSizeExtraSmall = Get.context!.width >= 1300 ? 14 : 10;
  static double fontSizeSmall = Get.context!.width >= 1300 ? 16 : 12;
  static double fontSizeDefault = Get.context!.width >= 1300 ? 18 : 14;
  static double fontSizeLarge = Get.context!.width >= 1300 ? 20 : 16;
  static double fontSizeExtraLarge = Get.context!.width >= 1300 ? 22 : 18;
  static double fontSizeOverLarge = Get.context!.width >= 1300 ? 28 : 24;

  static double formField100 = Get.context!.width >= 900 ? 400 : 400;
  static double formFieldP10 = 10;

  static const double paddingSizeExtraSmall = 5.0;
  static const double paddingSizeSmall = 10.0;
  static const double paddingSizeDefault = 15.0;
  static const double paddingSizeLarge = 20.0;
  static const double paddingSizeExtraLarge = 25.0;
  static const double paddingSizeDoubleExtraLarge = 35.0;

  static const double radiusSmall = 5.0;
  static const double radiusDefault = 10.0;
  static const double radiusLarge = 15.0;
  static const double radiusExtraLarge = 20.0;
  static const double radiusSingleExtraLarge = 25.0;
  static const double radiusDoubleExtraLarge = 45.0;
  static const double languageScreenLogo = 120.0;
  static const double authLogo = 200.0;
  static const double signUpLogo = 60.0;

  static const double webMaxWidth = 1170;

  static const double width_5p = 5;
  static const double width_10p = 10;

  static double fontSize(double size) {
    // This method assumes size is the base size for a specific design (e.g., 360 width).
    double baseWidth = 480.0;
    return (Get.context!.width / baseWidth) * size;
  }
}

class SizesDimensions {
  static double height(double value) => Get.context!.height * (value / 100);
  static double width(double value) => Get.context!.width * (value / 100);
}

// SizedBox size2h = SizedBox(
//   height: 2.h,
// );

SizedBox size2h = SizedBox(
  height: SizesDimensions.height(0.2),
);
SizedBox size5h = SizedBox(
  height: SizesDimensions.height(0.5),
);
SizedBox size6h = SizedBox(
  height: SizesDimensions.height(0.6),
);

SizedBox size10h = SizedBox(
  height: SizesDimensions.height(1.0),
);

SizedBox size15h = SizedBox(
  height: SizesDimensions.height(1.5),
);

SizedBox size16h = SizedBox(
  height: SizesDimensions.height(1.6),
);

SizedBox size20h = SizedBox(
  height: SizesDimensions.height(2.0),
);

SizedBox size30h = SizedBox(
  height: SizesDimensions.height(3.0),
);

SizedBox size40h = SizedBox(
  height: SizesDimensions.height(4.0),
);

SizedBox size50h = SizedBox(
  height: SizesDimensions.height(5.0),
);

SizedBox size60h = SizedBox(
  height: SizesDimensions.height(6.0),
);

SizedBox size70h = SizedBox(
  height: SizesDimensions.height(7.0),
);

SizedBox size100h = SizedBox(
  height: SizesDimensions.height(10.0),
);

SizedBox size120h = SizedBox(
  height: SizesDimensions.height(12.0),
);

SizedBox size150h = SizedBox(
  height: SizesDimensions.height(15.0),
);

SizedBox size5w = SizedBox(
  width: SizesDimensions.width(0.5),
);

SizedBox size10w = SizedBox(
  width: SizesDimensions.width(1.0),
);
SizedBox size15w = SizedBox(
  width: SizesDimensions.width(1.5),
);

SizedBox size20w = SizedBox(
  width: SizesDimensions.width(2.0),
);
SizedBox size25w = SizedBox(
  width: SizesDimensions.width(2.5),
);

SizedBox size30w = SizedBox(
  width: SizesDimensions.width(3.0),
);

SizedBox size40w = SizedBox(
  width: SizesDimensions.width(4.0),
);

SizedBox size50w = SizedBox(
  width: SizesDimensions.width(5.0),
);

SizedBox size60w = SizedBox(
  width: SizesDimensions.width(6.0),
);
