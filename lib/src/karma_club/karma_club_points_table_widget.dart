import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/fade_in_scale_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class KarmaClubPointTableWidget extends StatelessWidget {
  final Map<String, dynamic> data;
  final String lang;

  const KarmaClubPointTableWidget({
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
          image: NetworkImage('${AppAPI.baseUrlGcp}${data['background']}'),
          fit: BoxFit.cover,
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                FadeInAnimation(
                  visibilityThreshold: 1,
                  child: CustomText(
                    label: data['title'][lang],
                    type: 'h1',
                    textStyle: const TextStyle(color: AppColors.white),
                    isSerif: true,
                  ),
                ),
                const SizedBox(height: 30),
                FadeInAnimation(
                  visibilityThreshold: 1,
                  child: SizedBox(
                    width: size.width / 1.5,
                    child: CustomText(
                      label: data['description'][lang],
                      textStyle: const TextStyle(color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(height: 30),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FadeInScaleAnimation(
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, '/points-table-tab',
                            arguments: {'setTab': '0', 'showBack': true}),
                        child: Container(
                          width: size.width / 4,
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.primary),
                              borderRadius: BorderRadius.circular(200)),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 50,
                                  child: Divider(
                                    thickness: 1,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 20),
                                  child: CustomText(
                                    label: data['circle1'][lang],
                                    type: 'h4',
                                    isSerif: true,
                                    textAlign: TextAlign.center,
                                    textStyle:
                                        const TextStyle(color: AppColors.white),
                                  ),
                                ),
                                CustomText(
                                  label: data['View Now'][lang],
                                  type: 'md',
                                  textAlign: TextAlign.center,
                                  textStyle:
                                      const TextStyle(color: AppColors.white),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SvgPicture.asset(
                                  AppIcons.goldDownwordArrowIcon,
                                  width: 14,
                                  fit: BoxFit.contain,
                                  semanticsLabel: 'goldDownwordArrowIcon',
                                  placeholderBuilder: (context) =>
                                      const CircularProgressIndicator(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeInScaleAnimation(
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, '/points-table-tab',
                            arguments: {'setTab': '1', 'showBack': true}),
                        child: Container(
                          width: size.width / 4,
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.primary),
                              borderRadius: BorderRadius.circular(200)),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 50,
                                  child: Divider(
                                    thickness: 1,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 20),
                                  child: CustomText(
                                    label: data['circle2'][lang],
                                    type: 'h4',
                                    isSerif: true,
                                    textAlign: TextAlign.center,
                                    textStyle:
                                        const TextStyle(color: AppColors.white),
                                  ),
                                ),
                                CustomText(
                                  label: data['View Now'][lang],
                                  type: 'md',
                                  textAlign: TextAlign.center,
                                  textStyle:
                                      const TextStyle(color: AppColors.white),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SvgPicture.asset(
                                  AppIcons.goldDownwordArrowIcon,
                                  width: 14,
                                  fit: BoxFit.contain,
                                  semanticsLabel: 'goldDownwordArrowIcon',
                                  placeholderBuilder: (context) =>
                                      const CircularProgressIndicator(),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    FadeInScaleAnimation(
                      child: InkWell(
                        onTap: () => Navigator.pushNamed(
                            context, '/points-table-tab',
                            arguments: {'setTab': '2', 'showBack': true}),
                        child: Container(
                          width: size.width / 4,
                          padding: const EdgeInsets.all(30),
                          decoration: BoxDecoration(
                              border: Border.all(
                                  width: 1, color: AppColors.primary),
                              borderRadius: BorderRadius.circular(200)),
                          child: AspectRatio(
                            aspectRatio: 1,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const SizedBox(
                                  width: 50,
                                  child: Divider(
                                    thickness: 1,
                                    color: AppColors.primary,
                                  ),
                                ),
                                Padding(
                                  padding:
                                      const EdgeInsets.fromLTRB(0, 10, 0, 20),
                                  child: CustomText(
                                    label: data['circle3'][lang],
                                    type: 'h4',
                                    isSerif: true,
                                    textAlign: TextAlign.center,
                                    textStyle:
                                        const TextStyle(color: AppColors.white),
                                  ),
                                ),
                                CustomText(
                                  label: data['View Now'][lang],
                                  type: 'md',
                                  textAlign: TextAlign.center,
                                  textStyle:
                                      const TextStyle(color: AppColors.white),
                                ),
                                const SizedBox(
                                  height: 15,
                                ),
                                SvgPicture.asset(
                                  AppIcons.goldDownwordArrowIcon,
                                  width: 14,
                                  fit: BoxFit.contain,
                                  semanticsLabel: 'goldDownwordArrowIcon',
                                  placeholderBuilder: (context) =>
                                      const CircularProgressIndicator(),
                                ),
                              ],
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
