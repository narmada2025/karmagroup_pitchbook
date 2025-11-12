import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class PointsTableLeftCol extends StatelessWidget {
  final double height;
  final Color bgColor;
  final TextStyle? textStyle;
  final int firstCellFlex;
  final int cellFlex;
  final Color gapColor;
  final Color weeklyColor;
  final Color dailyColor;
  final double gap;
  final bool showTitle;
  final String title;
  final String weeklyTitle;
  final String dailyTitle;

  const PointsTableLeftCol({
    super.key,
    this.height = 100,
    this.bgColor = AppColors.dark,
    this.textStyle,
    this.firstCellFlex = 1,
    this.cellFlex = 1,
    required this.title,
    this.gapColor = AppColors.black,
    this.dailyColor = AppColors.primary,
    this.weeklyColor = AppColors.secondary,
    this.gap = 2,
    this.showTitle = true,
    this.weeklyTitle = "Weekly",
    this.dailyTitle = "Daily",
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
          color: bgColor,
          border: Border.all(
            color: gapColor,
            width: gap,
          )),
      height: height,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (showTitle)
            Flexible(
              flex: firstCellFlex,
              child: Container(
                alignment: Alignment.center,
                padding: const EdgeInsets.all(15),
                child: CustomText(
                  label: title.toString(),
                  type: 'md',
                  textStyle: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w500,
                          height: 1.2)
                      .merge(textStyle),
                ),
              ),
            ),
          Flexible(
            flex: cellFlex,
            child: Column(
              children: [
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: weeklyColor,
                        border: Border(
                            left: showTitle
                                ? BorderSide(color: gapColor, width: 4)
                                : BorderSide.none)),
                    child: CustomText(
                      label: weeklyTitle,
                      type: showTitle ? 'sm' : 'md',
                      textStyle: const TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                              height: 1.2)
                          .merge(textStyle),
                    ),
                  ),
                ),
                Container(
                  width: double.infinity,
                  color: gapColor,
                  height: 1,
                ),
                Expanded(
                  child: Container(
                    alignment: Alignment.center,
                    width: double.infinity,
                    decoration: BoxDecoration(
                        color: dailyColor,
                        border: Border(
                            left: showTitle
                                ? BorderSide(color: gapColor, width: 4)
                                : BorderSide.none)),
                    child: CustomText(
                      label: dailyTitle,
                      type: showTitle ? 'sm' : 'md',
                      textStyle: const TextStyle(
                              color: AppColors.black,
                              fontWeight: FontWeight.w500,
                              height: 1.2)
                          .merge(textStyle),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
