import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class GoBack extends StatelessWidget {
  final bool isBgLight;
  final String title;
  final String type;
  final bool isSerif;
  final TextAlign textAlign;
  final TextStyle textStyle;
  final double gap;
  final EdgeInsets padding;

  const GoBack({
    super.key,
    this.isBgLight = false,
    this.title = '',
    this.type = 'h4',
    this.isSerif = false,
    this.textAlign = TextAlign.left,
    this.textStyle = const TextStyle(color: AppColors.white),
    this.gap = 40,
    this.padding = const EdgeInsets.fromLTRB(80, 60, 80, 40),
  });

  @override
  Widget build(BuildContext context) {
    final String iconAsset =
        isBgLight ? AppIcons.backArrowBlack : AppIcons.backArrowWhite;

    return Container(
      padding: padding,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            // margin: const EdgeInsets.only(top: 5),
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
                color: AppColors.primary.withValues(alpha: 0.9),
                borderRadius: BorderRadius.circular(50)),
            child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: SvgPicture.asset(
                iconAsset,
                width: 24,
                fit: BoxFit.contain,
                semanticsLabel: 'calendar',
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(),
              ),
            ),
          ),
          SizedBox(
            width: gap,
          ),
          if (title != '')
            CustomText(
              label: title,
              type: type,
              isSerif: isSerif,
              textAlign: textAlign,
              textStyle: textStyle,
            )
        ],
      ),
    );
  }
}
