import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/src/app_locatizations.dart';

class PartnershipsReciprocalStrategicPartnershipsWidget
    extends StatelessWidget {
  final Map<String, dynamic> data;
  final String lang;

  const PartnershipsReciprocalStrategicPartnershipsWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.fromLTRB(80, 60, 80, 100),
      child: Column(
        children: [
          FadeInAnimation(
            visibilityThreshold: 1,
            child: SizedBox(
              width: size.width / 1.8,
              child: CustomText(
                label: data['title'][lang],
                type: 'h2',
                textStyle: const TextStyle(color: AppColors.primary),
                textAlign: TextAlign.center,
                isSerif: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeInAnimation(
            visibilityThreshold: 1,
            child: Container(
              width: size.width / 1.2,
              padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
              child: CustomText(
                label: data['description'][lang],
                textStyle: const TextStyle(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 60),
          FadeInAnimation(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                direction: Axis.horizontal,
                spacing: 30,
                children: [
                  ...data['logos'] != null
                      ? data['logos'].map((logo) {
                          return SvgPicture.asset(
                            logo,
                            height: 60,
                            fit: BoxFit.contain,
                            semanticsLabel: 'logos',
                            placeholderBuilder: (context) =>
                                const CircularProgressIndicator(),
                          );
                        }).toList()
                      : [
                          NoData(
                              title: tr(
                                  context, 'errors.No Images available', lang))
                        ],
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
