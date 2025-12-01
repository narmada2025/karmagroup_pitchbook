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
      padding: const EdgeInsets.symmetric(vertical: 50),
      color: AppColors.black,
      child: Column(
        children: [
          FadeInAnimation(
            child: CustomText(
              label: data['title'][lang],
              type: 'h2',
              textStyle: const TextStyle(color: AppColors.borderColor),
              isSerif: true,
            ),
          ),
          SizedBox(height: size.height * 0.035),
          FadeInAnimation(
            child: CustomText(
              label: data['subTitle'][lang],
              type: 'h7',
              textStyle: const TextStyle(
                  color: AppColors.secondary, fontWeight: FontWeight.w400,fontStyle: FontStyle.normal),
              textAlign: TextAlign.center,
              isUppercase: true,
            ),
          ),
          SizedBox(height: size.height * 0.055),
          SizedBox(
            width: size.width / 1.3,
            child: Row(
              spacing: size.width * 0.055,
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
          ),
          SizedBox(height: size.height * 0.03),
        ],
      ),
    );
  }
}
