import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../Config/app_config.dart';
import '../Theme/colors.dart';
import '../Utils/font_styles.dart';

class AppFormField extends StatefulWidget {
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
  final Widget? suffix;
  final Function()? onEditingComp;
  final int? maxLength;
  final double? width;
  final Widget? child;
  final TextStyle? textStyle;

  const AppFormField(
      {super.key,
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
      this.suffix,
      this.textStyle});
  @override
  AppFormFieldState createState() => AppFormFieldState();
}

class AppFormFieldState extends State<AppFormField> {
  late FocusNode _internalFocusNode;
  bool _obscureText = true;
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
    final isFocused = _internalFocusNode.hasFocus;
    return Container(
      // width: widget.width,
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
      height: widget.height,
      margin: widget.margin,
      padding: widget.padding,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            Text(widget.title!,
                style: const TextStyle(fontWeight: FontWeight.w500)),
          widget.child ??
              TextFormField(
                maxLength: widget.maxLength,
                focusNode: widget.focusNode,
                // validator: widget.validator,
                validator: widget.validator != null
                    ? (value) {
                        if (widget.validator!(value) != null) {
                          return widget.validator!(value);
                        }
                        // Custom email validation
                        if (widget.keyboardType == TextInputType.emailAddress &&
                            !isValidEmail(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      }
                    : (value) {
                        // Custom email validation
                        if (widget.keyboardType == TextInputType.emailAddress &&
                            !isValidEmail(value)) {
                          return 'Please enter a valid email address';
                        }
                        return null;
                      },
                decoration: InputDecoration(
                  // isDense: widget.isDense ??
                  //     ResponsiveWrapper.of(context).isSmallerThan(DESKTOP),
                  // // filled: true,
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  labelText: (widget.isLabel && widget.title == null)
                      ? widget.labelText
                      : null,
                  hintText: (widget.hintText != null) ? widget.hintText : null,
                  hintStyle: regular14NavyBlue,
                  labelStyle: bold12NavyBlue,
                  prefixIcon: (widget.prefixIcon != null)
                      ? widget.prefixIcon
                      : (widget.icon != null)
                          ? Icon(widget.icon,
                              color: Colors.grey.withOpacity(0.4))
                          : null,
                  border: widget.isOutlineBorder
                      ? AppStyles.outlineBorder(context,
                          isBorderColorApply: widget.isBorderColorApply)
                      : AppStyles.underlineBorder,
                  enabledBorder: widget.isOutlineBorder
                      ? OutlineInputBorder(
                          borderSide: BorderSide(
                            color: isFocused
                                ? primaryBlueColor
                                : secDarkBlueNavyColor,
                          ),
                        )
                      : AppStyles.underlineBorder,
                  focusedBorder: widget.isOutlineBorder
                      ? AppStyles.outlineBorder(context,
                          isBorderColorApply: widget.isBorderColorApply)
                      : AppStyles.underlineBorder,
                  suffix: (widget.suffix != null) ? widget.suffix : null,
                  suffixIcon: (widget.suffixIcon != null)
                      ? widget.suffixIcon
                      : (widget.isPasswordField)
                          ? _buildPasswordFieldVisibilityToggle()
                          : null,
                ),
                style: widget.textStyle ?? bold14NavyBlue,
                keyboardType: widget.keyboardType,
                inputFormatters: widget.inputFormatterList ??
                    ((widget.keyboardType == TextInputType.number)
                        ? [
                            FilteringTextInputFormatter.allow(
                                RegExp("[0-9-+.]"))
                          ]
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
                textCapitalization: (widget.keyboardType ==
                            TextInputType.emailAddress ||
                        widget.keyboardType == TextInputType.visiblePassword)
                    ? TextCapitalization.none
                    : (widget.keyboardType == TextInputType.name)
                        ? TextCapitalization.words
                        : TextCapitalization.sentences,
              ),
        ],
      ),
    );
  }

  Widget _buildPasswordFieldVisibilityToggle() {
    return GestureDetector(
      child: Icon(
        _obscureText ? Icons.visibility_off : Icons.visibility,
        color: secDarkGreyIconColor,
      ),
      onTap: () => setState(() => _obscureText = !_obscureText),
    );
  }

  // Function to validate email address using regex
  bool isValidEmail(String? email) {
    if (email == null) return false;
    // Regex pattern for email validation
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$',
        caseSensitive: false, multiLine: false);
    return regex.hasMatch(email);
  }
}
