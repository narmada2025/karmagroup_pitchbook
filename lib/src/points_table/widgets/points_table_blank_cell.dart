import 'package:flutter/material.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/app_data.dart';

class PointsTableBlankCell extends StatelessWidget {
  final double height;
  final Color color;
  final Color gapColor;
  final double gap;
  final String? title;
  final Alignment textAlignment;

  const PointsTableBlankCell({
    super.key,
    required this.height,
    required this.color,
    required this.gapColor,
    required this.gap,
    this.textAlignment = Alignment.centerLeft,
    this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: height,
      alignment: textAlignment,
      padding: const EdgeInsets.all(15),
      decoration: BoxDecoration(
          color: color, border: Border.all(color: gapColor, width: gap)),
      child: CustomText(
        label: title ?? '',
        type: 'md',
        textStyle: const TextStyle(
            color: AppColors.white, fontWeight: FontWeight.w500, height: 1.2),
      ),
    );
  }
}
