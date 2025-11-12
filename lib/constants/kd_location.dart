import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/app_data.dart';

class KdLocation extends StatelessWidget {
  final String award;
  final double iconWidth;
  final double awardHeight;
  final double awardTop;
  final double awardLeft;
  final Color textColor;
  final String textType;
  final String textLabel;

  const KdLocation({
    super.key,
    this.award = '',
    this.iconWidth = 50,
    this.awardHeight = 30,
    this.awardTop = 18,
    this.awardLeft = 80,
    this.textColor = AppColors.variation1,
    this.textType = 'lg',
    required this.textLabel,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              AppIcons.kdLocationIcon,
              width: iconWidth,
              fit: BoxFit.contain,
              semanticsLabel: 'kdLocationIcon',
              placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
            ),
            const SizedBox(
              height: 4,
            ),
            CustomText(
              label: textLabel,
              type: textType,
              isSerif: true,
              textStyle:
                  TextStyle(color: textColor, fontWeight: FontWeight.w600),
            )
          ],
        ),
        if (award != '')
          Positioned(
            top: awardTop,
            left: awardLeft,
            child: SvgPicture.asset(
              award,
              height: awardHeight,
              fit: BoxFit.contain,
              semanticsLabel: 'kdLocationIcon',
              placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
            ),
          ),
      ],
    );
  }
}
