import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/slide_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class HomeExperiencesWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final String lang;

  const HomeExperiencesWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.fromLTRB(60, 80, 60, 0),
      color: AppColors.black,
      child: Column(
        children: [
          SlideInAnimation(
            child: CustomText(
              label: data['title'][lang],
              type: 'h2',
              textStyle: const TextStyle(color: AppColors.primary),
              isSerif: true,
            ),
          ),
          const SizedBox(height: 20),
          SlideInAnimation(
            child: CustomText(
              label: data['description'][lang],
              textStyle: const TextStyle(color: AppColors.white),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 20),
          SlideInAnimation(
            delay: const Duration(milliseconds: 300),
            child: CustomText(
              label: data['question'][lang],
              textStyle: const TextStyle(
                color: AppColors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 100),
          Container(
            constraints: const BoxConstraints(
              maxHeight: double.infinity,
            ),
            child: Stack(
              children: [
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(bottom: 200,right: 160),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            SlideInAnimation(
                              visibilityThreshold: 1,
                              direction: SlideDirection.left,
                              child: CustomText(
                                label: data['Title2'][lang],
                                textStyle:
                                    const TextStyle(color: AppColors.primary),
                                type: 'h2',
                                isSerif: true
                              ),
                            ),
                            const SizedBox(height: 40),
                            SlideInAnimation(
                              direction: SlideDirection.left,
                              child: CustomText(
                                label: data['subTitle'][lang],
                                textStyle: const TextStyle(
                                    color: AppColors.primary,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SlideInAnimation(
                              direction: SlideDirection.left,
                              child: CustomText(
                                label: data['para1'][lang],
                                textStyle:
                                    const TextStyle(color: AppColors.white)
                              ),
                            ),
                            const SizedBox(height: 20),
                            SlideInAnimation(
                              direction: SlideDirection.left,
                              child: CustomText(
                                label: data['para2'][lang],
                                textStyle:
                                    const TextStyle(color: AppColors.white)
                              ),
                            ),
                            const SizedBox(height: 20),
                            SlideInAnimation(
                              direction: SlideDirection.left,
                              child: CustomText(
                                label: data['para3'][lang],
                                textStyle:
                                    const TextStyle(color: AppColors.white)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 4,
                      child: Stack(
                        children: [
                          SlideInAnimation(
                            visibilityThreshold: 0.1,
                            direction: SlideDirection.bottom,
                            child: Image.network('${AppAPI.baseUrlGcp}${data['john_image']}'),
                          ),
                          Positioned(
                            top:90,
                            right: 10,
                            child: FadeInAnimation(
                              delay: const Duration(milliseconds: 300),
                              initOpacity: 0,
                              child: Column(
                                children: [
                                  Container(
                                      padding: const EdgeInsets.all(5),
                                      decoration: BoxDecoration(
                                        color: AppColors.white
                                            .withValues(alpha: 0.05),
                                        border: Border.all(
                                            width: 1, color: AppColors.primary),
                                      ),
                                      child: const CustomText(
                                        label: 'JOHN SPENCE',
                                        type: 'h6',
                                        isSerif: true,
                                        textStyle:
                                            TextStyle(color: AppColors.white),
                                      )),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Image.network('${AppAPI.baseUrlGcp}${data['logo']}',
                                    width: 180,
                                  )
                                ],
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
                Positioned(
                  bottom: 120,
                  left: 0,
                  right: 0,
                  child: FadeInAnimation(
                    visibilityThreshold: 1,
                    child: Container(
                      alignment: Alignment.center,
                      constraints: const BoxConstraints(
                        maxHeight: double.infinity,
                      ),
                      child: Wrap(
                        direction: Axis.horizontal,
                        spacing: 10,
                        children: [
                          Container(
                            width: 60,
                            alignment: Alignment.topRight,
                            padding: const EdgeInsets.only(bottom: 60),
                            child: SvgPicture.asset(
                              AppIcons.quoteIcon,
                              width: 60,
                              fit: BoxFit.contain,
                              semanticsLabel: 'quote',
                              placeholderBuilder: (context) =>
                                  const CircularProgressIndicator(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                            child: Container(
                              width: 600,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: CustomText(
                                type: 'h4',
                                label: data['quote'][lang],
                                textStyle:
                                    const TextStyle(color: AppColors.white),
                                isSerif: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ),
                          Container(
                            width: 60,
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.only(top: 60),
                            child: Transform.rotate(
                              angle: 3.14 / 1,
                              child: SvgPicture.asset(
                                AppIcons.quoteIcon,
                                width: 60,
                                fit: BoxFit.contain,
                                semanticsLabel: 'quote',
                                placeholderBuilder: (context) =>
                                    const CircularProgressIndicator(),
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 70,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
