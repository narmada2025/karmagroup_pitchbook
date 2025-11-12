import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/app_data.dart';

class EventCategoryWidget extends StatelessWidget {
  final String semanticsLabel;
  final String svgAsset;
  final Color borderColor;
  final double padding;
  final VoidCallback onTap;
  final bool isActive;

  const EventCategoryWidget(
      {super.key,
      required this.semanticsLabel,
      required this.svgAsset,
      required this.onTap,
      this.borderColor = AppColors.primary,
      this.padding = 10,
      this.isActive = false});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: 50,
        height: 50,
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            border: Border.all(color: borderColor),
            borderRadius: BorderRadius.circular(50),
            color: isActive ? AppColors.primary : Colors.transparent),
        child: SvgPicture.asset(
          svgAsset,
          height: 30,
          fit: BoxFit.contain,
          semanticsLabel: semanticsLabel,
          placeholderBuilder: (context) => const CircularProgressIndicator(),
        ),
      ),
    );
  }
}
