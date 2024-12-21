import 'package:flutter/material.dart';

Color primaryColor = const Color(0xff79CCDC);
Color primaryBlueGradientDarkColor = const Color(0xff314395);
Color secDarkBlueNavyColor = Colors.black;
Color secDarkGreyIconColor = const Color(0xff292D32);
Color secBorderColor = const Color(0xffDEE4FF);
Color kWhite = Colors.white;
Color kGreen1ED760 = const Color(0xff1ED760);
Color kDarkGreen365D64 = const Color(0xff365D64);
Color kDarkGreen5b99a5 = const Color(0xff5b99a5);
Color kLightGreen79ccdc = const Color(0xff79ccdc);
Color kLightBlue32A3B8 = const Color(0xff32A3B8);
Color kLightBlue35B0C8 = const Color(0xff35B0C8);
Color kRedFF624D = const Color(0xffFF624D);
Color kRedFF5757 = const Color(0xffFF5757);
Color kRedFE5657 = const Color(0xffFE5657);
Color kRedFFB7B8 = const Color(0xffFFB7B8);
Color kRedFF9090 = const Color(0xffFF9090);
Color kOrangeF79E1B = const Color(0xffF79E1B);
Color kYellowffde59 = const Color(0xffffde59);
Color kLightYellow = const Color(0xffFDE583);
Color kDarkYellow = const Color(0xffE8C865);
Color kF3F3F3 = const Color(0xffF3F3F3);

Color kFFFFFF = const Color(0xffFFFFFF);
Color kD2B352 = const Color(0xffD2B352);
Color k003366 = const Color(0xff003366);
Color kDBE9F3 = const Color(0xffDBE9F3);
Color kF8F9FF = const Color(0xffF8F9FF);
Color kBCC8FF = const Color(0xffBCC8FF);
Color kD6ECF0 = const Color(0xffD6ECF0);
Color kC8C8C8 = const Color(0xffC8C8C8);
Color k7F7F7F = const Color(0xff7F7F7F);

/// Returns MaterialColor from Color
MaterialColor createMaterialColor(Color color) {
  List strengths = <double>[.05];
  Map<int, Color> swatch = <int, Color>{};
  final int r = color.red, g = color.green, b = color.blue;

  for (int i = 1; i < 10; i++) {
    strengths.add(0.1 * i);
  }
  for (var strength in strengths) {
    final double ds = 0.5 - strength;
    swatch[(strength * 1000).round()] = Color.fromRGBO(
      r + ((ds < 0 ? r : (255 - r)) * ds).round(),
      g + ((ds < 0 ? g : (255 - g)) * ds).round(),
      b + ((ds < 0 ? b : (255 - b)) * ds).round(),
      1,
    );
  }
  return MaterialColor(color.value, swatch);
}

Color getFillColor(Set<WidgetState> states) {
  // Check if the checkbox is checked
  if (states.contains(WidgetState.selected)) {
    // If checked, return the active color
    return primaryColor;
  } else {
    // If not checked, return grey
    // return Colors.grey;
    return secDarkGreyIconColor;
  }
}
