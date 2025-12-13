import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/fade_in_scale_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class DestinationsBannerWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final String lang;

  const DestinationsBannerWidget({
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
          colorFilter: ColorFilter.mode(
            Colors.black.withAlpha((0.6 * 255).round()),
            BlendMode.darken
          ),
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
                SizedBox(height: size.height * 0.021),
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
                  child: SizedBox(
                    width: size.width / 1.5,
                    child: CustomText(
                      label: data['title'][lang],
                      type: 'h1',
                      textStyle: const TextStyle(color: AppColors.white),
                      isSerif: true,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                SizedBox(height: size.height * 0.021),
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
