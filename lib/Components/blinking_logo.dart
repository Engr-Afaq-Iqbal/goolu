import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../Config/app_config.dart';

class BlinkingLogoProgressIndicator extends StatefulWidget {
  final double? height;
  final double? width;
  final double? padding;
  const BlinkingLogoProgressIndicator(
      {super.key, this.height, this.width, this.padding});

  @override
  State<BlinkingLogoProgressIndicator> createState() =>
      _BlinkingLogoProgressIndicatorState();
}

class _BlinkingLogoProgressIndicatorState
    extends State<BlinkingLogoProgressIndicator> {
  bool _isVisible = true;

  @override
  void initState() {
    super.initState();
    // Start flashing when the widget is first created
    _startFlashing();
  }

  void _startFlashing() {
    // Toggle the visibility of the container every 500 milliseconds
    Timer.periodic(const Duration(milliseconds: 500), (timer) {
      if (mounted) {
        setState(() {
          _isVisible = !_isVisible;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: _isVisible ? 1.0 : 0.5,
      duration: const Duration(milliseconds: 200),
      child: Container(
        // height: 100,
        // width: 100,
        padding: EdgeInsets.symmetric(vertical: widget.padding ?? 45),
        child: Center(
            child: SvgPicture.asset(
          '${gooluLogoUrl}blomalBColor.svg',
          height: widget.height,
          width: widget.width,
          fit: BoxFit.contain,
        )
            // Image.asset(
            //   'assets/images/carzLogo.png',
            //   height: widget.height,
            //   width: widget.width,
            //   fit: BoxFit.contain,
            // ),
            ),
      ),
    );
  }
}
