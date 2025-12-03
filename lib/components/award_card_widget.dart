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
    Size size = MediaQuery.of(context).size;
    return Column(
      children: [
        SizedBox(height: size.height * 0.18, child: Image.network('${AppAPI.baseUrlGcp}${award['image']}')),
        SizedBox(
          height: size.height * 0.03,
        ),
        CustomText(
          label: award['title'][lang] ?? '',
          type: 'md',
          textAlign: TextAlign.center,
          textStyle: const TextStyle(
              color: AppColors.white, fontWeight: FontWeight.w500),
        ),
        Divider(
          height: 15,
          thickness: 0,
          indent: 10,
          color: AppColors.white.withValues(alpha: 0.0),
        ),
        CustomText(
          label: award['tag'][lang] ?? '',
          type: 'def',
          textAlign: TextAlign.center,
          textStyle: const TextStyle(color: AppColors.lightTextColor,fontWeight: FontWeight.w300),
        ),
         SizedBox(
          height: size.height * 0.012,
        ),
        CustomText(
          label: award['name'][lang] ?? '',
          type: 'sm',
          textAlign: TextAlign.center,
          textStyle: const TextStyle(color: AppColors.secondary,fontWeight: FontWeight.w500),
        ),
      ],
    );
  }
}
