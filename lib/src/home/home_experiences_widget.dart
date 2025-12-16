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
      padding: EdgeInsets.symmetric(
        horizontal: size.width * 0.08,
        vertical: size.height * 0.001,
      ),
      color: AppColors.black,
      child: Column(
        children: [
          SizedBox(height: size.height * 0.09),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: size.width * 0.01,),
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
                SizedBox(height: size.height * 0.03),
                SlideInAnimation(
                  child: CustomText(
                    label: data['description'][lang],
                    textStyle: const TextStyle(color: AppColors.white),
                    textAlign: TextAlign.center,
                    type: 'sm1',
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height * 0.1),
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
                        padding: EdgeInsets.only(bottom: size.height * 0.25, right: size.height * 0.1),
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
                            SizedBox(height: size.height * 0.05),
                            SlideInAnimation(
                              direction: SlideDirection.left,
                              child: CustomText(
                                label: data['subTitle'][lang],
                                textStyle:  const TextStyle(
                                    color: AppColors.primary, fontWeight: FontWeight.w400),
                                type: 'lg',
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            SlideInAnimation(
                              direction: SlideDirection.left,
                              child: CustomText(
                                label: data['para1'][lang],
                                type: 'sm1',
                                textStyle:
                                    const TextStyle(color: AppColors.white),
                                // letterSpacing: -0.52,
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            SlideInAnimation(
                              direction: SlideDirection.left,
                              child: CustomText(
                                label: data['para2'][lang],
                                type: 'sm1',
                                maxLines: 10,
                                textStyle:
                                    const TextStyle(color: AppColors.white)
                              ),
                            ),
                            SizedBox(height: size.height * 0.02),
                            SlideInAnimation(
                              direction: SlideDirection.left,
                              child: CustomText(
                                label: data['para3'][lang],
                                type: 'sm1',
                                textStyle:
                                    const TextStyle(color: AppColors.white)
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 5,
                      child:
                      Stack(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: size.width * 0.00),
                            child: SlideInAnimation(
                              visibilityThreshold: 0.1,
                              child: Image.network(
                                '${AppAPI.baseUrlGcp}${data['john_image']}',
                                fit: BoxFit.cover,
                                width: size.width,
                              ),
                            ),
                          ),

                          Positioned.fill(
                            child: Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: size.height * 0.3, // adjust as needed
                                decoration: BoxDecoration(
                                  gradient: LinearGradient(
                                    begin: Alignment.bottomCenter,
                                    end: Alignment.topCenter,
                                    colors: [
                                  Colors.black.withAlpha((0.99 * 255).round()),
                                      Colors.transparent,
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),

                          Positioned(
                            top: size.height * 0.08,
                            right: 0,
                            child: FadeInAnimation(
                              delay: const Duration(milliseconds: 300),
                              initOpacity: 0,
                              child: Column(
                                children: [
                                  Container(
                                    padding: EdgeInsets.symmetric(
                                      horizontal: size.width * 0.004,
                                      vertical: size.width * 0.005,
                                    ),
                                    decoration: BoxDecoration(
                                      color: AppColors.white.withValues(alpha: 0.05),
                                      border: Border.all(
                                        width: 0.1,
                                        color: AppColors.borderColor,
                                      ),
                                    ),
                                    child: const CustomText(
                                      label: 'JOHN SPENCE',
                                      type: 'h7',
                                      isSerif: true,
                                      textStyle: TextStyle(
                                        color: AppColors.white,
                                        shadows: [
                                          Shadow(
                                            color: Colors.black54,
                                            offset: Offset(0, 2),
                                            blurRadius: 6,
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.005),
                                  Image.network(
                                    '${AppAPI.baseUrlGcp}${data['logo']}',
                                    width: size.width * 0.12,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      )

                    ),
                  ],
                ),
                Positioned(
                  bottom: size.height * 0.05,
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
                            width: size.width * 0.06,
                            alignment: Alignment.topRight,
                            padding: const EdgeInsets.only(bottom: 60),
                            child: SvgPicture.asset(
                              AppIcons.quoteIcon,
                              colorFilter:  const ColorFilter.mode(AppColors.strokeColor, BlendMode.srcIn),
                              width: size.width * 0.06,
                              fit: BoxFit.contain,
                              semanticsLabel: 'quote',
                              placeholderBuilder: (context) =>
                                  const CircularProgressIndicator(),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 15.0,right: 15.0),
                            child: Container(
                              width: size.width * 0.5,
                              // width: 600,
                              padding: const EdgeInsets.symmetric(vertical: 5),
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
                            width: size.width * 0.06,
                            alignment: Alignment.bottomLeft,
                            padding: const EdgeInsets.only(top: 60),
                            child: Transform.rotate(
                              angle: 3.14 / 1,
                              child: SvgPicture.asset(
                                AppIcons.quoteIcon,
                                colorFilter: const ColorFilter.mode(AppColors.strokeColor, BlendMode.srcIn),
                                width: size.width * 0.06,
                                fit: BoxFit.contain,
                                semanticsLabel: 'quote',
                                placeholderBuilder: (context) =>
                                    const CircularProgressIndicator(),
                              ),
                            ),
                          ),
                           SizedBox(
                            width: size.width * 0.05,
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
