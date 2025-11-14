import 'package:flutter/material.dart';
import 'package:pitchbook/components/award_card_widget.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/slide_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class HomeAwardsWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final String lang;

  const HomeAwardsWidget({
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
      color: AppColors.black,
      child: Column(
        children: [
          FadeInAnimation(
            child: CustomText(
              label: data['title'][lang],
              type: 'h2',
              textStyle: const TextStyle(color: AppColors.primary),
              isSerif: true,
            ),
          ),
          const SizedBox(height: 25),
          FadeInAnimation(
            child: CustomText(
              label: data['subTitle'][lang],
              type: 'h6',
              textStyle: const TextStyle(
                  color: AppColors.secondary, fontWeight: FontWeight.w400),
              textAlign: TextAlign.center,
              isUppercase: true,
            ),
          ),
          const SizedBox(height: 40),
          SizedBox(
            width: size.width / 1.4,
            child: Row(
              spacing: 30,
              children: data['awards'].asMap().entries.map<Widget>((entry) {
                int index = entry.key;
                // Award award = Award.fromJson(entry.value);
                return Expanded(
                  flex: 1,
                  child: SlideInAnimation(
                    direction: SlideDirection.right,
                    delay: Duration(milliseconds: index * 200),
                    child: AwardCardWidget(
                      award: entry.value,
                      lang: lang,
                    ),
                  ),
                );
              }).toList(),
            ),
          )
        ],
      ),
    );
  }
}
