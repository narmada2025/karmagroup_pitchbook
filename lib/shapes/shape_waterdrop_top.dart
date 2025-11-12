import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';

class ShapeWaterdropTop extends CustomPainter {
  final Color color;

  ShapeWaterdropTop({
    this.color = AppColors.dark,
  });

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = color
      ..style = PaintingStyle.fill;

    Path path = Path()
      ..moveTo(0, size.height)
      ..cubicTo(size.width / 4.15, size.height, size.width / 3.26, 1,
          size.width / 2, 0)
      ..cubicTo(size.width / 1.54, 1, size.width / 1.27, size.height,
          size.width, size.height)
      ..lineTo(0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
