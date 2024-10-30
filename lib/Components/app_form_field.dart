import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

import '../Utils/dimensions.dart';
import '../Utils/font_styles.dart';
import '../Utils/utils.dart';

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
  final Function()? onEditingComp;
  final int? maxLength;
  final double? width;
  final Widget? child;
  final Color borderColor;
  final Color fieldBgColor;
  final TextStyle? textStyle;
  final bool contextMenuBuilder;
  final TextAlign textAlign;
  final Widget? suffix;
  final double? borderRadius;
  const AppFormField({
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
    this.suffix,
    this.borderColor = Colors.grey,
    this.fieldBgColor = Colors.white,
    this.textStyle,
    this.contextMenuBuilder = false,
    this.textAlign = TextAlign.start,
    this.borderRadius,
  });

  @override
  State<AppFormField> createState() => _AppFormFieldState();
}

class _AppFormFieldState extends State<AppFormField> {
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
        color: widget.fieldBgColor,
        border: Border.all(
          width: 1,
          color: widget.borderColor,
        ),
        borderRadius: BorderRadius.circular(
          widget.borderRadius ?? Dimensions.radiusDefault,
        ),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (widget.title != null)
            customText(text: widget.title!, textStyle: bold14NavyBlue),
          // Text(widget.title!,
          //     style: const TextStyle(fontWeight: FontWeight.w500)),
          widget.child ??
              TextFormField(
                textAlign: widget.textAlign,
                contextMenuBuilder: widget.contextMenuBuilder
                    ? (context, editableTextState) {
                        return AdaptiveTextSelectionToolbar(
                          anchors: editableTextState.contextMenuAnchors,
                          children: [
                            TextSelectionToolbarTextButton(
                              onPressed: () {
                                editableTextState.copySelection(
                                    SelectionChangedCause.toolbar);
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizesDimensions.width(3)),
                              child: customText(
                                text: 'copy'.tr,
                                textStyle: regular14NavyBlue,
                              ),
                            ),
                            TextSelectionToolbarTextButton(
                              onPressed: () {
                                editableTextState.cutSelection(
                                    SelectionChangedCause.toolbar);
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizesDimensions.width(3)),
                              child: customText(
                                  text: 'cut'.tr, textStyle: regular14NavyBlue),
                            ),
                            TextSelectionToolbarTextButton(
                              onPressed: () {
                                editableTextState
                                    .pasteText(SelectionChangedCause.toolbar);
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizesDimensions.width(3)),
                              child: customText(
                                  text: 'paste'.tr,
                                  textStyle: regular14NavyBlue),
                            ),
                            TextSelectionToolbarTextButton(
                              onPressed: () {
                                editableTextState
                                    .selectAll(SelectionChangedCause.toolbar);
                              },
                              padding: EdgeInsets.symmetric(
                                  horizontal: SizesDimensions.width(3)),
                              child: customText(
                                  text: 'selectAll'.tr,
                                  textStyle: regular14NavyBlue),
                            ),
                          ],
                        );
                      }
                    : null,
                // toolbarOptions: const ToolbarOptions(
                //   copy: true,
                //   paste: true,
                //   cut: true,
                //   selectAll: true,
                // ),
                maxLength: widget.maxLength,
                focusNode: widget.focusNode,
                enableInteractiveSelection: true,
                // validator: widget.validator,
                validator: widget.validator != null
                    ? (value) {
                        if (widget.validator!(value) != null) {
                          return widget.validator!(value);
                        }
                        // Custom email validation
                        if (widget.keyboardType == TextInputType.emailAddress &&
                            !isValidEmail(value)) {
                          return 'pleaseEnterAValidEmailAddress'.tr;
                        }
                        return null;
                      }
                    : (value) {
                        // Custom email validation
                        if (widget.keyboardType == TextInputType.emailAddress &&
                            !isValidEmail(value)) {
                          return 'pleaseEnterAValidEmailAddress'.tr;
                        }
                        return null;
                      },
                decoration: InputDecoration(
                  // isDense: widget.isDense ??
                  //     ResponsiveWrapper.of(context).isSmallerThan(DESKTOP),
                  // // filled: true,
                  counterText: '',
                  contentPadding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  labelText: (widget.isLabel && widget.title == null)
                      ? widget.labelText
                      : null,
                  hintText: (widget.hintText != null) ? widget.hintText : null,
                  hintStyle: regular14NavyBlue.copyWith(
                    color: Theme.of(context).iconTheme.color!,
                  ),
                  labelStyle: bold14NavyBlue.copyWith(
                    color: Theme.of(context).iconTheme.color,
                  ),
                  prefixIcon: (widget.prefixIcon != null)
                      ? widget.prefixIcon
                      : (widget.icon != null)
                          ? Icon(widget.icon,
                              color: Colors.grey.withOpacity(0.4))
                          : null,

                  border: InputBorder.none,
                  // widget.isOutlineBorder
                  //     ? AppStyles.outlineBorder(context,
                  //         isBorderColorApply: widget.isBorderColorApply)
                  //     : AppStyles.underlineBorder,
                  enabledBorder: InputBorder.none,
                  // widget.isOutlineBorder
                  //     ? OutlineInputBorder(
                  //         borderRadius:
                  //             BorderRadius.circular(Dimensions.radiusLarge),
                  //         borderSide: BorderSide(
                  //           color: isFocused
                  //               ? Theme.of(context).colorScheme.primary
                  //               : Theme.of(context).colorScheme.surfaceBright,
                  //         ),
                  //       )
                  //     : AppStyles.underlineBorder,
                  focusedBorder: InputBorder.none,
                  // widget.isOutlineBorder
                  //     ? AppStyles.outlineBorder(context,
                  //         isBorderColorApply: widget.isBorderColorApply)
                  //     : AppStyles.underlineBorder,
                  suffix: (widget.suffix != null) ? widget.suffix : null,
                  suffixIcon: (widget.suffixIcon != null)
                      ? widget.suffixIcon
                      : (widget.isPasswordField)
                          ? _buildPasswordFieldVisibilityToggle()
                          : null,
                ),
                style: widget.textStyle ??
                    regular14NavyBlue.copyWith(
                      color: Theme.of(context).iconTheme.color,
                    ),
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

                cursorColor: Theme.of(context).colorScheme.primary,
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
        color:
            Theme.of(context).colorScheme.surfaceBright, //secDarkGreyIconColor,
      ),
      onTap: () => setState(() => _obscureText = !_obscureText),
    );
  }
}
