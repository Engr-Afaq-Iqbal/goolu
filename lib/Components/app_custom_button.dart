import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:goolu/Theme/colors.dart';

import '../Utils/dimensions.dart';
import '../Utils/utils.dart';

class AppCustomButton extends StatefulWidget {
  final Widget? title;
  final String? btnTxt;
  final Icon? leading;
  final Function()? onTap;
  final EdgeInsets? padding;
  final Color? bgColor;
  final EdgeInsets? margin;
  final double? borderRadius;
  final MainAxisSize btnTxtAxisSize;
  final Widget? btnChild;
  final bool isBtnRounded;
  final String? toolTipMsg;
  final bool enableToolTip;
  final bool enableLoading;
  final bool isOutLinedButton;
  final double horizontalPadding;
  final double verticalPadding;

  const AppCustomButton(
      {super.key,
      Key? keys,
      this.title,
      this.btnTxt,
      this.leading,
      this.onTap,
      this.padding,
      this.bgColor,
      this.margin,
      this.borderRadius = Dimensions.radiusLarge,
      this.btnTxtAxisSize = MainAxisSize.max,
      this.btnChild,
      this.isBtnRounded = false,
      this.toolTipMsg,
      this.enableToolTip = true,
      this.enableLoading = false,
      this.isOutLinedButton = false,
      this.horizontalPadding = 15,
      this.verticalPadding = 15
      //this.height,
      });

  @override
  State<AppCustomButton> createState() => _AppCustomButtonState();
}

class _AppCustomButtonState extends State<AppCustomButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.margin ?? EdgeInsets.zero,
      child: Tooltip(
        margin: EdgeInsets.zero,
        padding: EdgeInsets.zero,
        message: widget.enableToolTip
            ? (widget.toolTipMsg ?? (widget.btnTxt ?? 'Action Button'))
            : '',
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            // minimumSize: Size.fromHeight(30),
            padding: EdgeInsets.symmetric(
                vertical: widget.verticalPadding,
                horizontal: widget.horizontalPadding),
            backgroundColor: widget.bgColor != null || widget.isOutLinedButton
                ? widget.bgColor
                : primaryBlueColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                widget.borderRadius ??
                    (widget.isBtnRounded ? 50 : Dimensions.radiusLarge),
              ),
              side: widget.isOutLinedButton
                  ? BorderSide(
                      color: Theme.of(context).colorScheme.primary, width: 1.5)
                  : BorderSide.none,
            ),
          ),
          onPressed: widget.enableLoading && widget.onTap != null
              ? () async {
                  setState(() => _isLoading = true);
                  await widget.onTap!();
                  setState(() => _isLoading = false);
                }
              : widget.onTap,
          child: Stack(
            children: [
              widget.btnChild ??
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: widget.btnTxtAxisSize,
                    children: [
                      widget.leading == null
                          ? const SizedBox.shrink()
                          : Padding(
                              padding: const EdgeInsets.only(right: 2.5),
                              child: widget.leading!,
                            ),
                      widget.title ??
                          Text(
                            widget.btnTxt ?? 'submit'.tr,
                            style: TextStyle(
                                color: widget.isOutLinedButton
                                    ? Theme.of(context).colorScheme.primary
                                    : Colors.white,
                                fontSize: 13),
                            textAlign: TextAlign.center,
                            maxLines: 1,
                            overflow: TextOverflow.fade,
                          ),
                    ],
                  ),
              if (widget.enableLoading && _isLoading)
                Positioned(
                  top: 0,
                  bottom: 0,
                  right: 0,
                  left: 0,
                  child: progressIndicator(height: 20, width: 20),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
