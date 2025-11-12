import 'package:flutter/material.dart';
import 'package:pitchbook/components/card_one_widget.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/fade_in_scale_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class KarmaClubLifestyleExperiencesWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final String lang;

  const KarmaClubLifestyleExperiencesWidget({
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
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInAnimation(
            visibilityThreshold: 1,
            delay: const Duration(milliseconds: 700),
            child: SizedBox(
              width: size.width / 1.6,
              child: CustomText(
                label: data['title'][lang],
                type: 'h3',
                textStyle: const TextStyle(color: AppColors.primary),
                textAlign: TextAlign.center,
                isSerif: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeInAnimation(
            visibilityThreshold: 1,
            delay: const Duration(milliseconds: 800),
            child: SizedBox(
              width: size.width / 1.5,
              child: CustomText(
                label: data['description'][lang],
                textStyle: const TextStyle(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 80),
          Container(
              width: size.width - 160,
              constraints: const BoxConstraints(
                maxHeight: double.infinity,
              ),
              child: Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: Column(
                          children: [
                            FadeInAnimation(
                              initOpacity: 0.2,
                              child: Container(
                                width: size.width,
                                height: 500,
                                padding: const EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('${AppAPI.baseUrlGcp}${data['card1']['image']}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: FadeInScaleAnimation(
                                  child: CardOneWidget(
                                      title: data['card1']['title'][lang],
                                      description: data['card1']['description']
                                          [lang],
                                      borderColor: AppColors.primary),
                                ),
                              ),
                            ),
                            FadeInAnimation(
                              initOpacity: 0.2,
                              child: Container(
                                width: size.width,
                                height: 420,
                                padding: const EdgeInsets.all(30),
                                decoration: const BoxDecoration(
                                  color: AppColors.gray2,
                                ),
                                child: FadeInScaleAnimation(
                                  child: CardOneWidget(
                                      title: data['card2']['title'][lang],
                                      description: data['card2']['description']
                                          [lang],
                                      borderColor: AppColors.primary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Column(
                          children: [
                            Row(
                              children: [
                                Expanded(
                                  flex: 1,
                                  child: FadeInAnimation(
                                    initOpacity: 0.2,
                                    child: Container(
                                      width: size.width,
                                      height: 420,
                                      padding: const EdgeInsets.all(30),
                                      decoration: const BoxDecoration(
                                        color: AppColors.gray2,
                                      ),
                                      child: FadeInScaleAnimation(
                                        child: CardOneWidget(
                                            title: data['card3']['title'][lang],
                                            description: data['card3']
                                                ['description'][lang],
                                            borderColor: AppColors.primary),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  flex: 1,
                                  child: FadeInAnimation(
                                    initOpacity: 0.2,
                                    child: Container(
                                      width: size.width,
                                      height: 420,
                                      padding: const EdgeInsets.all(30),
                                      decoration: BoxDecoration(
                                        image: DecorationImage(
                                          image: NetworkImage(
                                              '${AppAPI.baseUrlGcp}${data['card4']['image']}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: FadeInScaleAnimation(
                                        child: CardOneWidget(
                                            title: data['card4']['title'][lang],
                                            description: data['card4']
                                                ['description'][lang],
                                            borderColor: AppColors.primary),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            FadeInAnimation(
                              initOpacity: 0.2,
                              child: Container(
                                width: size.width,
                                height: 500,
                                padding: const EdgeInsets.all(30),
                                decoration: BoxDecoration(
                                  image: DecorationImage(
                                    image: NetworkImage('${AppAPI.baseUrlGcp}${data['card5']['image']}'),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                                child: FadeInScaleAnimation(
                                  child: CardOneWidget(
                                      title: data['card5']['title'][lang],
                                      description: data['card5']['description']
                                          [lang],
                                      borderColor: AppColors.primary),
                                ),
                              ),
                            ),
                          ],
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: FadeInAnimation(
                          initOpacity: 0.2,
                          child: Container(
                            width: size.width,
                            height: 500,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('${AppAPI.baseUrlGcp}${data['card6']['image']}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: FadeInScaleAnimation(
                              child: CardOneWidget(
                                  title: data['card6']['title'][lang],
                                  description: data['card6']['description']
                                      [lang],
                                  borderColor: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: FadeInAnimation(
                          initOpacity: 0.2,
                          child: Container(
                            width: size.width,
                            height: 500,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('${AppAPI.baseUrlGcp}${data['card7']['image']}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: FadeInScaleAnimation(
                              child: CardOneWidget(
                                  title: data['card7']['title'][lang],
                                  description: data['card7']['description']
                                      [lang],
                                  borderColor: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: FadeInAnimation(
                          initOpacity: 0.2,
                          child: Container(
                            width: size.width,
                            height: 500,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('${AppAPI.baseUrlGcp}${data['card8']['image']}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: FadeInScaleAnimation(
                              child: CardOneWidget(
                                  title: data['card8']['title'][lang],
                                  description: data['card8']['description']
                                      [lang],
                                  borderColor: AppColors.primary),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: FadeInAnimation(
                          initOpacity: 0.2,
                          child: Container(
                            width: size.width,
                            height: 500,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('${AppAPI.baseUrlGcp}${data['card9']['image']}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: FadeInScaleAnimation(
                              child: CardOneWidget(
                                  title: data['card9']['title'][lang],
                                  description: data['card9']['description']
                                      [lang],
                                  borderColor: AppColors.primary),
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: [
                      Expanded(
                        flex: 4,
                        child: FadeInAnimation(
                          initOpacity: 0.2,
                          child: Container(
                            width: size.width,
                            height: 500,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('${AppAPI.baseUrlGcp}${data['card10']['image']}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: FadeInScaleAnimation(
                              child: CardOneWidget(
                                title: data['card10']['title'][lang],
                                description: data['card10']['description']
                                    [lang],
                                borderColor: AppColors.primary,
                                showBtn: true,
                                btnText: data['card10']['Explore'][lang],
                                onTap: () => Navigator.pushNamed(
                                    context, '/reciprocal-partnerships'),
                              ),
                            ),
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: FadeInAnimation(
                          initOpacity: 0.2,
                          child: Container(
                            width: size.width,
                            height: 500,
                            padding: const EdgeInsets.all(30),
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                image: NetworkImage('${AppAPI.baseUrlGcp}${data['card11']['image']}'),
                                fit: BoxFit.cover,
                              ),
                            ),
                            child: FadeInScaleAnimation(
                              child: CardOneWidget(
                                title: data['card11']['title'][lang],
                                description: data['card11']['description']
                                    [lang],
                                borderColor: AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ))
        ],
      ),
    );
  }
}
