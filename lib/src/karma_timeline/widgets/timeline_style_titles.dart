import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/app_data.dart';

class TimelineStyleTitles extends StatelessWidget {
  final String? title;
  final String? status;
  final String? tag;
  final bool showArrow;
  final String? year;

  const TimelineStyleTitles({
    super.key,
    this.title,
    this.status,
    this.tag,
    this.showArrow = true,
    this.year
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(left: 20),
      alignment: Alignment.topLeft,
      child: Wrap(
        direction: Axis.vertical,
        spacing: 4,
        children: [
          if (status != null)
            Row(
              children: [
                CustomText(
                  label: status ?? '',
                  type: 'xs',
                  isUppercase: true,
                  textStyle: const TextStyle(color: AppColors.white),
                ),
                CustomText(
                  label: year ?? '',
                  type: 'xs',
                  isUppercase: true,
                  textStyle: const TextStyle(color: AppColors.white),
                ),
              ],
            ),
          if (title != null)
            CustomText(
              label: title ?? '',
              type: 'h6',
              isSerif: true,
              textStyle: const TextStyle(color: AppColors.white, height: 1.2),
            ),
          if (tag != null)
            CustomText(
              label: tag ?? '',
              type: 'xs',
              isUppercase: true,
              textStyle: const TextStyle(color: AppColors.white),
            ),
          if (showArrow && title != null)
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: SvgPicture.asset(
                AppIcons.chevDown,
                width: 14,
                fit: BoxFit.contain,
                semanticsLabel: 'calendar',
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(),
              ),
            ),
        ],
      ),
    );
  }
}
