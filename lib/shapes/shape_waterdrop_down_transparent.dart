import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';

class ShapeWaterdropDownTransparent extends CustomPainter {
  final Color color;

  ShapeWaterdropDownTransparent({
    this.color = AppColors.dark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, 0)
      ..cubicTo(size.width / 4.15, 0, size.width / 3.26, size.height - 1,
          size.width / 2, size.height)
      ..cubicTo(size.width / 1.54, size.height - 1, size.width / 1.27, 0,
          size.width, 0)
      ..lineTo(size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
