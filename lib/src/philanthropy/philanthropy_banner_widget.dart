import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/fade_in_scale_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class PhilanthropyBannerWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final String lang;

  const PhilanthropyBannerWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      height: size.height / 1.5,
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('${AppAPI.baseUrlGcp}${data['image']}'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                FadeInAnimation(
                  delay: const Duration(milliseconds: 300),
                  child: Container(
                    width: 1,
                    height: 100,
                    color: AppColors.secondary,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInScaleAnimation(
                  initScale: 2,
                  initOpacity: 0,
                  child: CustomText(
                    label: data['subTitle'][lang],
                    textStyle: const TextStyle(color: AppColors.secondary),
                    isUppercase: true,
                  ),
                ),
                FadeInScaleAnimation(
                  initScale: 2,
                  initOpacity: 0,
                  child: CustomText(
                    label: data['title'][lang],
                    type: 'h1',
                    textStyle: const TextStyle(color: AppColors.white),
                    isSerif: true,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInAnimation(
                  delay: const Duration(milliseconds: 300),
                  child: Container(
                    width: 1,
                    height: 100,
                    color: AppColors.secondary,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
