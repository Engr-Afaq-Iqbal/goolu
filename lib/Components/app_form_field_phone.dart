import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';

import '../Config/app_config.dart';
import '../Theme/colors.dart';
import '../Utils/dimensions.dart';
import '../Utils/font_styles.dart';

class AppFormFieldPhone extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final String? title;
  final bool isLabel;
  final IconData? icon;
  final TextInputType keyboardType;
  final TextEditingController? controller;
  final FocusNode? focusNode;
  final bool isPasswordField;
  final bool enabled;
  final double? height;
  final int maxLines;
  final Function()? onTap;
  final bool readOnly;
  final bool? isDense;
  final bool isOutlineBorder;
  final bool isBorderColorApply;
  final List<TextInputFormatter>? inputFormatterList;
  final String? Function(String?)? validator;
  final Function(String)? onChanged;
  final EdgeInsets? margin;
  final EdgeInsets? padding;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final Function()? onEditingComp;
  final int? maxLength;
  final double? width;
  final Widget? child;
  const AppFormFieldPhone({
    super.key,
    this.labelText,
    this.hintText,
    this.title,
    this.isLabel = true,
    this.icon,
    this.keyboardType = TextInputType.text,
    this.isPasswordField = false,
    this.controller,
    this.focusNode,
    this.enabled = true,
    this.height,
    this.maxLines = 1,
    this.onTap,
    this.readOnly = false,
    this.isDense,
    this.isOutlineBorder = true,
    this.isBorderColorApply = true,
    this.inputFormatterList,
    this.validator,
    this.onChanged,
    this.margin,
    this.padding = const EdgeInsets.only(bottom: 15),
    this.prefixIcon,
    this.suffixIcon,
    this.onEditingComp,
    this.maxLength,
    this.width,
    this.child,
  });

  @override
  State<AppFormFieldPhone> createState() => _AppFormFieldPhoneState();
}

class _AppFormFieldPhoneState extends State<AppFormFieldPhone> {
  late FocusNode _internalFocusNode;
  final bool _obscureText = true;
  @override
  void initState() {
    super.initState();
    _internalFocusNode = widget.focusNode ?? FocusNode();
    _internalFocusNode.addListener(_onFocusChange);
  }

  @override
  void dispose() {
    _internalFocusNode.removeListener(_onFocusChange);
    if (widget.focusNode == null) {
      _internalFocusNode.dispose();
    }
    super.dispose();
  }

  void _onFocusChange() {
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        /// TODO: TextField Responsiveness
        minWidth:
            // (ResponsiveWrapper.of(context).isLargerThan('TABLET_S') )
            //     ?
            widget.width ?? 300
        // : 300
        ,
        maxWidth: widget.width ?? double.infinity,
      ),
      width: Get.width,
      height: widget.height,
      padding: EdgeInsets.symmetric(
        horizontal: SizesDimensions.width(2.0),
      ),
      decoration: BoxDecoration(
          border: Border.all(width: 1, color: secDarkBlueNavyColor),
          borderRadius: BorderRadius.circular(Dimensions.radiusSmall)),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(3),
            child: Image.asset(
              '${imgUrl}saudiFlag.png',
              height: SizesDimensions.height(2.5),
              width: SizesDimensions.width(3.7),
            ),
          ),
          size10w,
          customText(
            text: '(+966)',
            textStyle: bold12NavyBlue,
          ),
          SvgPicture.asset(
            '${imgUrl}downArrow.svg',
            colorFilter: ColorFilter.mode(
              secDarkBlueNavyColor,
              BlendMode.srcIn,
            ),
          ),
          size10w,
          AppStyles.dividerLineVertical(color: kC8C8C8, width: 2),
          size10w,
          SizedBox(
            width: SizesDimensions.width(50.0),
            child: TextFormField(
              maxLength: widget.maxLength,
              focusNode: widget.focusNode,
              // validator: widget.validator,
              validator: (value) {
                // if (widget.validator!(value) != null) {
                //   return widget.validator!(value);
                // }
                // return null;
              },
              decoration: InputDecoration(
                // isDense: widget.isDense ??
                //     ResponsiveWrapper.of(context).isSmallerThan(DESKTOP),
                // // filled: true,
                counterText: '',
                contentPadding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                labelText: null,
                hintText: (widget.hintText != null) ? widget.hintText : null,
                hintStyle: regular14NavyBlue,
                labelStyle: bold12NavyBlue,
                prefixIcon: (widget.prefixIcon != null)
                    ? widget.prefixIcon
                    : (widget.icon != null)
                        ? Icon(widget.icon, color: Colors.grey.withOpacity(0.4))
                        : null,
                border: InputBorder.none, // No border
                enabledBorder: InputBorder.none, // No border when enabled
                focusedBorder: InputBorder.none,
              ),
              style: bold14NavyBlue,
              keyboardType: widget.keyboardType,
              inputFormatters: widget.inputFormatterList ??
                  ((widget.keyboardType == TextInputType.number)
                      ? [FilteringTextInputFormatter.allow(RegExp("[0-9-+.]"))]
                      : (widget.keyboardType == TextInputType.phone)
                          ? [
                              FilteringTextInputFormatter.allow(
                                  RegExp("[0-9+]"))
                            ]
                          : []),

              cursorColor: primaryBlueColor,
              obscureText: widget.isPasswordField ? _obscureText : false,
              controller: widget.controller,
              enabled: widget.enabled,
              maxLines: widget.maxLines,
              onTap: widget.onTap,
              readOnly: widget.readOnly,
              onChanged: widget.onChanged,
              onEditingComplete: widget.onEditingComp,
              // onFieldSubmitted: widget.onFieldSub,
              textCapitalization:
                  (widget.keyboardType == TextInputType.emailAddress ||
                          widget.keyboardType == TextInputType.visiblePassword)
                      ? TextCapitalization.none
                      : (widget.keyboardType == TextInputType.name)
                          ? TextCapitalization.words
                          : TextCapitalization.sentences,
            ),
          ),
        ],
      ),
    );
  }
}
