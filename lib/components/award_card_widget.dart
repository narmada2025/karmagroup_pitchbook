import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class AwardCardWidget extends StatelessWidget {
  final Map<String, dynamic> award;
  final String lang;

  const AwardCardWidget({
    super.key,
    required this.award,
    required this.lang,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: 150, child: Image.network('${AppAPI.baseUrlGcp}${award['image']}')),
        const SizedBox(
          height: 15,
        ),
        CustomText(
          label: award['title'][lang] ?? '',
          type: 'md',
          textAlign: TextAlign.center,
          textStyle: const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.w500),
        ),
        Divider(
          height: 20,
          thickness: 1,
          indent: 10,
          color: AppColors.white.withValues(alpha: 0.1),
        ),
        CustomText(
          label: award['tag'][lang] ?? '',
          type: 'def',
          textAlign: TextAlign.center,
          textStyle: const TextStyle(color: AppColors.white),
        ),
        const SizedBox(
          height: 10,
        ),
        CustomText(
          label: award['name'][lang] ?? '',
          type: 'xs',
          textAlign: TextAlign.center,
          textStyle: const TextStyle(color: AppColors.secondary),
        ),
      ],
    );
  }
}
