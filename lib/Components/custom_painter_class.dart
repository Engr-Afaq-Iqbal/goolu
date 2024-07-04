import 'package:flutter/material.dart';

import '../Theme/colors.dart';

class CustomStyleArrow extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final Paint paint = Paint()
      ..color = kYellowffde59
      ..strokeWidth = 1
      ..style = PaintingStyle.fill;

    const double triangleH = 20;
    const double triangleW = 40.0;
    final double width = size.width;
    final double height = size.height;

    final Path trianglePath = Path()
      ..moveTo(width / 4 - triangleW / 4, height)
      ..lineTo(width / 4, triangleH + height)
      ..lineTo(width / 3 + triangleW / 3, height)
      ..close();

    canvas.drawPath(trianglePath, paint);
    final BorderRadius borderRadius = BorderRadius.circular(30);
    final Rect rect = Rect.fromLTRB(0, 0, width, height);
    final RRect outer = borderRadius.toRRect(rect);
    canvas.drawRRect(outer, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
