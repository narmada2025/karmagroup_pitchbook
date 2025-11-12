import 'package:flutter/material.dart';
import 'package:pitchbook/components/counter_widget.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomePhilanthropyWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final String lang;

  const HomePhilanthropyWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.all(80),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: NetworkImage('${AppAPI.baseUrlGcp}${data["stat_image"]}'),
          fit: BoxFit.cover,
        ),
      ),
      child: FadeInAnimation(
        child: Column(
          children: [
            CustomText(
              label: data["title"][lang],
              type: 'h2',
              textStyle: const TextStyle(color: AppColors.white),
              isSerif: true,
            ),
            const SizedBox(height: 25),
            CustomText(
              label: data["subTitle"][lang],
              type: 'h6',
              textStyle: const TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.w500),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 40),
            IntrinsicHeight(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: VisibilityDetector(
                      key: const Key('counter_widget_1'),
                      onVisibilityChanged: (visibility) {
                        if (visibility.visibleFraction > 0) {
                        } else {}
                      },
                      child: CounterWidget(
                        number: data["stat"]["stat1"]["number"],
                        sufix: data["stat"]["stat1"]["suffix"],
                        label: data["stat"]["stat1"]["title"][lang],
                        step: 1,
                        numberStyle: TextStyle(
                          fontSize: TextSize.h1,
                          color: AppColors.white,
                          fontFamily: 'Playfair',
                        ),
                        labelStyle: TextStyle(
                          fontSize: TextSize.lg,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 100,
                    thickness: 1,
                    indent: 10,
                    color: AppColors.white,
                  ),
                  Flexible(
                    child: VisibilityDetector(
                      key: const Key('counter_widget_2'),
                      onVisibilityChanged: (visibility) {
                        if (visibility.visibleFraction > 0) {
                        } else {}
                      },
                      child: CounterWidget(
                        number: data["stat"]["stat2"]["number"],
                        sufix: data["stat"]["stat2"]["suffix"],
                        label: data["stat"]["stat2"]["title"][lang],
                        step: 1,
                        numberStyle: TextStyle(
                          fontSize: TextSize.h1,
                          color: AppColors.white,
                          fontFamily: 'Playfair',
                        ),
                        labelStyle: TextStyle(
                          fontSize: TextSize.lg,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  ),
                  const VerticalDivider(
                    width: 100,
                    thickness: 1,
                    indent: 10,
                    color: AppColors.white,
                  ),
                  Flexible(
                    child: VisibilityDetector(
                      key: const Key('counter_widget_3'),
                      onVisibilityChanged: (visibility) {
                        if (visibility.visibleFraction > 0) {
                        } else {}
                      },
                      child: CounterWidget(
                        number: data["stat"]["stat3"]["number"],
                        sufix: data["stat"]["stat3"]["suffix"],
                        label: data["stat"]["stat3"]["title"][lang],
                        step: 1,
                        numberStyle: TextStyle(
                          fontSize: TextSize.h1,
                          color: AppColors.white,
                          fontFamily: 'Playfair',
                        ),
                        labelStyle: TextStyle(
                          fontSize: TextSize.lg,
                          color: AppColors.white,
                        ),
                      ),
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
