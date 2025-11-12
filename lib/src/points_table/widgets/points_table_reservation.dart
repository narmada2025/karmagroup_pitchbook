import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class PointsTableReservation extends StatelessWidget {
  final dynamic data;
  final String lang;
  final String title;

  const PointsTableReservation({
    super.key,
    required this.data,
    required this.lang,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        spacing: 6,
        children: [
          CustomText(
            label: title,
            isUppercase: true,
            type: 'sm',
            textStyle: const TextStyle(color: AppColors.primary),
          ),
          ...data.map<Widget>((entry) {
            return CustomText(
              label: entry[lang],
              type: 'sm',
              textStyle: const TextStyle(color: AppColors.white),
            );
          }).toList()
        ]);
  }
}
