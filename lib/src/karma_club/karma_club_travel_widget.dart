import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/components/bullet_list_two_widget.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class KarmaClubTravelWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final String lang;

  const KarmaClubTravelWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.fromLTRB(80, 80, 60, 80),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              children: [
                const SizedBox(height: 20),
                FadeInAnimation(
                  visibilityThreshold: 1,
                  child: CustomText(
                    label: data['title'][lang],
                    type: 'h1',
                    textStyle: const TextStyle(color: AppColors.white),
                    isSerif: true,
                  ),
                ),
                const SizedBox(height: 50),
                Row(
                  children: [
                    Expanded(
                      flex: 1,
                      child: FadeInAnimation(
                        child: Container(
                          width: size.width,
                          height: 500,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('${AppAPI.baseUrlGcp}${data['TwoForOne']['image']}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                padding: const EdgeInsets.all(30),
                                color: AppColors.black.withValues(alpha: .6),
                                child: Wrap(
                                  runSpacing: 20,
                                  children: [
                                    CustomText(
                                      label: data['TwoForOne']['title'][lang],
                                      type: 'h1',
                                      textStyle: const TextStyle(
                                          color: AppColors.white),
                                      isSerif: true,
                                    ),
                                    const SizedBox(height: 30),
                                    CustomText(
                                      label: data['TwoForOne']['description']
                                          [lang],
                                      textStyle: const TextStyle(
                                          color: AppColors.white),
                                    ),
                                    const SizedBox(height: 20),
                                    BulletListTwoWidget(
                                      iconWidget: SvgPicture.asset(
                                        AppIcons.squareOutlinedIcon,
                                        width: 14,
                                        fit: BoxFit.contain,
                                        semanticsLabel: 'square outlined',
                                        placeholderBuilder: (context) =>
                                            const CircularProgressIndicator(),
                                      ),
                                      // iconTrailWidget: SvgPicture.asset(
                                      //   AppIcons.arrowTopRightIcon,
                                      //   width: 14,
                                      //   fit: BoxFit.contain,
                                      //   semanticsLabel: 'arrow',
                                      //   placeholderBuilder: (context) =>
                                      //       const CircularProgressIndicator(),
                                      // ),
                                      textStyle: const TextStyle(
                                        color: AppColors.white,
                                      ),
                                      type: 'sm',
                                      gap: 12.0,
                                      itemGap: 15,
                                      items: [
                                        BulletItem(
                                            text: data['TwoForOne']
                                                ['bulletItem1'][lang]),
                                        BulletItem(
                                            text: data['TwoForOne']
                                                ['bulletItem2'][lang]),
                                        BulletItem(
                                          text: data['TwoForOne']['bulletItem3']
                                              [lang],
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 20,
                    ),
                    Expanded(
                      flex: 1,
                      child: FadeInAnimation(
                        child: Container(
                          width: size.width,
                          height: 500,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage('${AppAPI.baseUrlGcp}${data['TwoForOne']['image']}'),
                              fit: BoxFit.cover,
                            ),
                          ),
                          child: ClipRRect(
                            child: BackdropFilter(
                              filter:
                                  ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                              child: Container(
                                padding: const EdgeInsets.all(30),
                                color: AppColors.black.withValues(alpha: .3),
                                child: Wrap(
                                  runSpacing: 20,
                                  children: [
                                    CustomText(
                                      label: data['Rewards Xtra']['title']
                                          [lang],
                                      type: 'h1',
                                      textStyle: const TextStyle(
                                          color: AppColors.white),
                                      isSerif: true,
                                    ),
                                    const SizedBox(height: 30),
                                    CustomText(
                                      label: data['Rewards Xtra']['description']
                                          [lang],
                                      textStyle: const TextStyle(
                                          color: AppColors.white),
                                    ),
                                    const SizedBox(height: 20),
                                    Row(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Flexible(
                                          child: BulletListTwoWidget(
                                            iconWidget: SvgPicture.asset(
                                              AppIcons.squareOutlinedIcon,
                                              width: 14,
                                              fit: BoxFit.contain,
                                              semanticsLabel: 'square outlined',
                                              placeholderBuilder: (context) =>
                                                  const CircularProgressIndicator(),
                                            ),
                                            // iconTrailWidget: SvgPicture.asset(
                                            //   AppIcons.arrowTopRightIcon,
                                            //   width: 14,
                                            //   fit: BoxFit.contain,
                                            //   semanticsLabel: 'arrow',
                                            //   placeholderBuilder: (context) =>
                                            //       const CircularProgressIndicator(),
                                            // ),
                                            textStyle: const TextStyle(
                                                color: AppColors.white),
                                            type: 'sm',
                                            gap: 12.0,
                                            itemGap: 15,
                                            items: [
                                              BulletItem(
                                                  text: data['Rewards Xtra']
                                                      ['bulletItem1'][lang]),
                                              BulletItem(
                                                  text: data['Rewards Xtra']
                                                      ['bulletItem2'][lang]),
                                              BulletItem(
                                                text: data['Rewards Xtra']
                                                    ['bulletItem3'][lang],
                                              ),
                                            ],
                                          ),
                                        ),
                                        const SizedBox(
                                          width: 40,
                                        ),
                                        Flexible(
                                          child: BulletListTwoWidget(
                                            iconWidget: SvgPicture.asset(
                                              AppIcons.squareOutlinedIcon,
                                              width: 14,
                                              fit: BoxFit.contain,
                                              semanticsLabel: 'square outlined',
                                              placeholderBuilder: (context) =>
                                                  const CircularProgressIndicator(),
                                            ),
                                            // iconTrailWidget: SvgPicture.asset(
                                            //   AppIcons.arrowTopRightIcon,
                                            //   width: 14,
                                            //   fit: BoxFit.contain,
                                            //   semanticsLabel: 'arrow',
                                            //   placeholderBuilder: (context) =>
                                            //       const CircularProgressIndicator(),
                                            // ),
                                            textStyle: const TextStyle(
                                                color: AppColors.white),
                                            type: 'sm',
                                            gap: 12.0,
                                            itemGap: 10,
                                            items: [
                                              BulletItem(
                                                  text: data['Rewards Xtra']
                                                      ['bulletItem4'][lang]),
                                              BulletItem(
                                                  text: data['Rewards Xtra']
                                                      ['bulletItem5'][lang]),
                                              BulletItem(
                                                text: data['Rewards Xtra']
                                                    ['bulletItem6'][lang],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
