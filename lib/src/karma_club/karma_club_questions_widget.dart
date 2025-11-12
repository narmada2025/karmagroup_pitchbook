import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class KarmaClubQuestionsWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final String lang;

  const KarmaClubQuestionsWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      child: Container(
        padding: const EdgeInsets.all(80),
        color: AppColors.darker,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomText(
              label: data['Questions'][lang],
              isSerif: true,
              type: 'h2',
              textStyle: const TextStyle(color: AppColors.primary),
            ),
            const SizedBox(
              width: 10,
            ),
            TextButton(
              onPressed: () => Navigator.pushNamed(context, '/faqs',
                  arguments: {'showBack': true}),
              child: CustomText(
                label: data['Look here'][lang],
                isSerif: true,
                type: 'h2',
                textStyle: const TextStyle(
                    color: AppColors.white,
                    decoration: TextDecoration.underline,
                    decorationColor: AppColors.white),
              ),
            )
          ],
        ),
      ),
    );
  }
}
