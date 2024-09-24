import 'package:flutter/material.dart';

class NavBarModel {
  dynamic identifier;
  String label;
  Function()? onTap;
  Widget page;
  String? iconsUrl;

  NavBarModel(
      {this.identifier,
      required this.label,
      this.onTap,
      required this.page,
      this.iconsUrl});
}
