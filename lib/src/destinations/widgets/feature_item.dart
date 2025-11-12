import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class FeatureItem extends StatelessWidget {
  final String title;
  final String image;
  final double width;

  const FeatureItem({
    super.key,
    required this.title,
    required this.image,
    this.width = 250,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Stack(
        alignment: Alignment.bottomCenter,
        children: [
          Image.network('${AppAPI.baseUrlGcp}$image'),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.black.withValues(alpha: 0.5),
                  AppColors.black.withValues(alpha: 0.0)
                ],
                begin: Alignment.bottomCenter,
                end: Alignment.topCenter,
                stops: const [0.2, 1.0],
              ),
            ),
            child: CustomText(
              label: title,
              type: 'h5',
              isSerif: true,
              textAlign: TextAlign.center,
              textStyle: const TextStyle(color: AppColors.white),
            ),
          ),
        ],
      ),
    );
  }
}
