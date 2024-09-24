import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../Controller/SideDrawerController/side_drawer_controller.dart';
import '../Utils/dimensions.dart';
import '../Utils/font_styles.dart';

class AppDropDownProfileQuestion extends StatefulWidget {
  final List<MapEntry<String, String?>>? items;
  final String? hintTxt;
  final int index;
  const AppDropDownProfileQuestion({
    super.key,
    required this.items,
    this.hintTxt,
    this.index = 0,
  });

  @override
  State<AppDropDownProfileQuestion> createState() =>
      _AppDropDownProfileQuestionState();
}

class _AppDropDownProfileQuestionState
    extends State<AppDropDownProfileQuestion> {
  String? selectedItem;
  @override
  Widget build(BuildContext context) {
    return GetBuilder<SideDrawerController>(
        builder: (SideDrawerController signUpCtrl) {
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
                  textStyle: regular14NavyBlue.copyWith(
                      color: Theme.of(context).iconTheme.color),
                )),
            items: widget.items?.map((e) {
              return DropdownMenuItem(
                  value: e.key,
                  child: customText(
                    text: e.value ?? '',
                    textStyle: regular14NavyBlue.copyWith(
                        color: Theme.of(context).iconTheme.color),
                  ));
            }).toList(),
            value: selectedItem,
            onChanged: (String? value) {
              setState(() {
                selectedItem = value;
                // Print selected key and value
                if (value != null) {
                  final selectedValue = widget.items
                      ?.firstWhere((entry) => entry.key == value)
                      .value;
                  debugPrint('Selected key: $value');
                  debugPrint('Selected value: $selectedValue');
                  signUpCtrl.update();
                }
              });
            },
            dropdownStyleData: DropdownStyleData(
              maxHeight: SizesDimensions.height(50.0),
              width: SizesDimensions.width(70.0),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                color: Theme.of(context).dialogBackgroundColor,
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
                    color: Theme.of(context).iconTheme.color!,
                  ),
                  borderRadius: BorderRadius.circular(Dimensions.radiusLarge)),
              padding: EdgeInsets.symmetric(
                horizontal: SizesDimensions.width(2.0),
              ),
              height: SizesDimensions.height(6.0),
              width: Get.width,
            ),
          ),
        ),
      );
    });
  }
}
