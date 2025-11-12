import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class KarmaClubLocationsWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final String lang;

  const KarmaClubLocationsWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FadeInAnimation(
      visibilityThreshold: 0.15,
      child: SizedBox(
        width: size.width,
        child: Stack(children: [
          Image.network(
           '${AppAPI.baseUrlGcp}${data['image']}',
            width: size.width,
          ),
          Container(
            width: size.width,
            padding: const EdgeInsets.symmetric(vertical: 80),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  label: data['title'][lang],
                  isSerif: true,
                  type: 'h2',
                  textStyle: const TextStyle(color: AppColors.white),
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
        ]),
      ),
    );
  }
}
