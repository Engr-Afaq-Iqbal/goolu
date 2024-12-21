import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Controller/AuthController/auth_controller.dart';
import '../Locale/Languages/arabic.dart';
import '../Locale/Languages/english.dart';
import '../Theme/colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/image_urls.dart';

String gooluLogoUrl = "assets/gooluLogo/";
String imgUrl = "assets/images/";

class AppConfig {
  /// Application Name
  static const String appName = "Blomal Capital";
  // API base url
  static String baseUrl = "https://apiuat.blomal.sa";

  static String merchantDisplayName = "Haider Shatti";

  static String currency = "sar";

  static const String languageDefault = "en";
  static final Map<String, AppLanguage> languagesSupported = {
    "en": AppLanguage("English", english()),
    "ar": AppLanguage("عربى", arabic()),
  };
}

class AppLanguage {
  final String name;
  final Map<String, String> values;
  AppLanguage(this.name, this.values);
}

class AppStyles {
  /// field border styles
  static OutlineInputBorder outlineBorder(context,
          {bool isBorderColorApply = true}) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(5),
        borderSide: BorderSide(
          width: 0.5,
          color: isBorderColorApply ? primaryColor : Colors.transparent,
        ),
      );

  static outlineBorderDecoration(context, {bool isBorderColorApply = true}) =>
      BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(
          width: 0.5,
          color: isBorderColorApply ? primaryColor : Colors.transparent,
        ),
      );

  static UnderlineInputBorder underlineBorder = const UnderlineInputBorder(
    borderSide: BorderSide(color: Colors.transparent),
  );

  /// Divider Line
  static Widget dividerLine(
          {double? height, double? width, Color? color, double? margin}) =>
      Container(
        margin: width != null
            ? EdgeInsets.symmetric(horizontal: margin ?? 0)
            : null,
        height: height ?? 0.7,
        width: width,
        color: color ?? secBorderColor,
      );

  static Widget dividerLineVertical(
          {double? height, double? width, Color? color, double? margin}) =>
      Container(
        margin: width != null
            ? EdgeInsets.symmetric(horizontal: margin ?? 0)
            : null,
        height: height ?? 29,
        width: width ?? 0.7,
        color: color ?? secBorderColor,
      );
  AppBar customAppBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      title: Image.asset(
        '$gooluLogoUrl$gooluNewLogo',
        height: 28,
        width: 77,
      ),
      actions: [
        GestureDetector(
            onTap: () {
              Get.find<AuthController>().scaffoldKey.currentState?.openDrawer();
            },
            child: SvgPicture.asset('$imgUrl$menuImg')),
        size40w,
      ],
    );
  }
}
