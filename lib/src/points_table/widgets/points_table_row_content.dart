import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class PointsTableRowContent extends StatelessWidget {
  final double height;
  final Color bgColor;
  final TextStyle? textStyle;
  final Color gapColor;
  final Color weeklyColor;
  final Color dailyColor;
  final double gap;

  final List<dynamic> weeklyData;
  final List<dynamic> dailyData;

  const PointsTableRowContent({
    super.key,
    this.height = 100,
    this.bgColor = AppColors.dark,
    this.textStyle,
    this.gapColor = AppColors.black,
    this.dailyColor = AppColors.primary,
    this.weeklyColor = AppColors.secondary,
    this.gap = 2,
    required this.weeklyData,
    required this.dailyData,
  });

  @override
  Widget build(BuildContext context) {
    final BorderSide borderStyle = BorderSide(
      color: gapColor,
      width: gap,
    );

    return SizedBox(
      height: height,
      child: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                ...weeklyData.map<Widget>((entry) {
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          top: borderStyle,
                          left: borderStyle,
                          right: borderStyle,
                        ),
                      ),
                      child: Row(
                        children: [
                          if (entry.length == 0)
                            Flexible(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: weeklyColor,
                                    border: Border(
                                        left: BorderSide(
                                      color: gapColor,
                                      width: 1,
                                    ))),
                              ),
                            ),
                          for (int i = 0; i < entry.length; i++)
                            Flexible(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: weeklyColor,
                                    border: i == 0
                                        ? const Border(left: BorderSide.none)
                                        : Border(
                                            left: BorderSide(
                                            color: gapColor,
                                            width: 1,
                                          ))),
                                child: CustomText(
                                  label: entry[i],
                                  type: 'sm',
                                  textAlign: TextAlign.center,
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
                  );
                })
              ],
            ),
          ),
          Container(
            width: double.infinity,
            color: gapColor,
            height: 1,
          ),
          Expanded(
            child: Row(
              children: [
                ...dailyData.map<Widget>((entry) {
                  return Expanded(
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border(
                          left: borderStyle,
                          right: borderStyle,
                          bottom: BorderSide(
                            color: gapColor,
                            width: gap,
                          ),
                        ),
                      ),
                      child: Row(
                        children: [
                          if (entry.length == 0)
                            Flexible(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: dailyColor,
                                    border: Border(
                                        left: BorderSide(
                                      color: gapColor,
                                      width: 1,
                                    ))),
                              ),
                            ),
                          for (int i = 0; i < entry.length; i++)
                            Flexible(
                              child: Container(
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                    color: dailyColor,
                                    border: i == 0
                                        ? const Border(left: BorderSide.none)
                                        : Border(
                                            left: BorderSide(
                                            color: gapColor,
                                            width: 1,
                                          ))),
                                child: CustomText(
                                  label: entry[i],
                                  type: 'sm',
                                  textAlign: TextAlign.center,
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
                  );
                })
              ],
            ),
          ),
        ],
      ),
    );
  }
}
