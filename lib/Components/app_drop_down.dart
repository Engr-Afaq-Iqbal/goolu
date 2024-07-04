import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Theme/colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/font_styles.dart';

class AppDropDown extends StatefulWidget {
  final List items;
  String? selectedItem;
  final String? hintTxt;
  AppDropDown(
      {super.key, required this.items, this.selectedItem, this.hintTxt});

  @override
  State<AppDropDown> createState() => _AppDropDownState();
}

class _AppDropDownState extends State<AppDropDown> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizesDimensions.height(6.0),
      width: Get.width,
      margin: EdgeInsets.only(
        bottom: SizesDimensions.height(0.0),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton2(
          isExpanded: true,
          hint: Align(
              alignment: AlignmentDirectional.centerStart,
              child: customText(
                text: widget.hintTxt ?? 'all'.tr,
                textStyle: regular14NavyBlue,
              )),
          items: widget.items.map((e) {
            return DropdownMenuItem(
                value: e,
                child: customText(
                  text: e,
                  textStyle: regular14NavyBlue,
                ));
          }).toList(),
          value: widget.selectedItem,
          onChanged: (Object? value) {
            widget.selectedItem = value as String?;
            setState(() {});
            // onChanged(value as String?);
          },
          dropdownStyleData: DropdownStyleData(
            maxHeight: SizesDimensions.height(50.0),
            width: SizesDimensions.width(70.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(14),
              color: kFFFFFF,
            ),
            offset: const Offset(-5, 0),
            scrollbarTheme: ScrollbarThemeData(
              radius: const Radius.circular(40),
              thickness: WidgetStateProperty.all(6),
              thumbVisibility: WidgetStateProperty.all(true),
            ),
          ),
          buttonStyleData: ButtonStyleData(
            decoration: BoxDecoration(
                border: Border.all(
                  width: 1,
                  color: secDarkBlueNavyColor,
                ),
                borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
            padding: EdgeInsets.symmetric(
              horizontal: SizesDimensions.width(2.0),
            ),
            height: SizesDimensions.height(6.0),
            width: Get.width,
          ),
        ),
      ),
    );
  }
}
