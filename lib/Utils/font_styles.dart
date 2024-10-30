import 'package:flutter/material.dart';

import '../Theme/colors.dart';
import 'dimensions.dart';

String fontIBMRegular = 'MontserratMedium';
String fontIBMBold = 'MontserratBold';
String fontFamily = 'Montserrat';

Text customText({
  required String text,
  TextStyle? textStyle,
  TextAlign? textAlign,
  int maxLines = 1,
}) {
  return Text(
    text,
    textAlign: textAlign ?? TextAlign.start,
    style: textStyle,
    maxLines: maxLines,
  );
}

final TextStyle regular16PrimaryBlue = TextStyle(
  fontSize: Dimensions.fontSize(16.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  color: primaryColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle regular14PrimaryBlue = TextStyle(
  fontSize: Dimensions.fontSize(14.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  color: primaryColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle regular12PrimaryBlue = TextStyle(
  fontSize: Dimensions.fontSize(12.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  color: primaryColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle regular16NavyBlue = TextStyle(
  fontSize: Dimensions.fontSize(16.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  color: secDarkBlueNavyColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle regular18NavyBlue = TextStyle(
  fontSize: Dimensions.fontSize(18.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  color: secDarkBlueNavyColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle regular14NavyBlue = TextStyle(
  fontSize: Dimensions.fontSize(14.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  color: secDarkBlueNavyColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle regular12NavyBlue = TextStyle(
  fontSize: Dimensions.fontSize(12.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  color: secDarkBlueNavyColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold12NavyBlue = TextStyle(
  fontSize: Dimensions.fontSize(12.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: secDarkBlueNavyColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold14NavyBlue = TextStyle(
  fontSize: Dimensions.fontSize(14.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: secDarkBlueNavyColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold16NavyBlue = TextStyle(
  fontSize: Dimensions.fontSize(16.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: secDarkBlueNavyColor,
  overflow: TextOverflow.ellipsis,
);
final TextStyle bold18NavyBlue = TextStyle(
  fontSize: Dimensions.fontSize(18.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: secDarkBlueNavyColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold20NavyBlue = TextStyle(
  fontSize: Dimensions.fontSize(20.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: secDarkBlueNavyColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold32NavyBlue = TextStyle(
  fontSize: Dimensions.fontSize(32.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: secDarkBlueNavyColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold16White = TextStyle(
  fontSize: Dimensions.fontSize(16.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: kWhite,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold20White = TextStyle(
  fontSize: Dimensions.fontSize(20.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: kWhite,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold12White = TextStyle(
  fontSize: Dimensions.fontSize(12.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: kWhite,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold14White = TextStyle(
  fontSize: Dimensions.fontSize(14.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: kWhite,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold25White = TextStyle(
  fontSize: Dimensions.fontSize(25.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: kWhite,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold14Blue = TextStyle(
  fontSize: Dimensions.fontSize(14.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: primaryColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold18Blue = TextStyle(
  fontSize: Dimensions.fontSize(18.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: primaryColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold24Blue = TextStyle(
  fontSize: Dimensions.fontSize(24.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: primaryColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold16Blue = TextStyle(
  fontSize: Dimensions.fontSize(16.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: primaryColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold32Blue = TextStyle(
  fontSize: Dimensions.fontSize(32.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: primaryColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle regular14DarkGrey = TextStyle(
  fontSize: Dimensions.fontSize(14.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  color: secDarkGreyIconColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold12Blue = TextStyle(
  fontSize: Dimensions.fontSize(12.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: primaryColor,
  overflow: TextOverflow.ellipsis,
);

final TextStyle regular16White = TextStyle(
  fontSize: Dimensions.fontSize(16.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  color: kWhite,
  overflow: TextOverflow.ellipsis,
);

final TextStyle regular12White = TextStyle(
  fontSize: Dimensions.fontSize(12.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  color: kWhite,
  overflow: TextOverflow.ellipsis,
);

final TextStyle regular14White = TextStyle(
  fontSize: Dimensions.fontSize(14.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  color: kWhite,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold14Red = TextStyle(
  fontSize: Dimensions.fontSize(14.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: kRedFF624D,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold20Grey = TextStyle(
  fontSize: Dimensions.fontSize(20.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: kC8C8C8,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold14Grey = TextStyle(
  fontSize: Dimensions.fontSize(14.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.bold,
  color: kC8C8C8,
  overflow: TextOverflow.ellipsis,
);

final TextStyle bold18Green = TextStyle(
  fontSize: Dimensions.fontSize(18.0),
  fontFamily: fontFamily,
  fontWeight: FontWeight.normal,
  color: kGreen1ED760,
  overflow: TextOverflow.ellipsis,
);
