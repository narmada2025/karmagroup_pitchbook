import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/fade_in_scale_animation.dart';
import 'package:pitchbook/components/pdf_screen.dart';
import 'package:pitchbook/components/slide_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_para.dart';
import 'package:pitchbook/constants/custom_snackbar.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/go_back.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/app_locatizations.dart';

class KarmaClubFractionalOwnershipScreen extends StatefulWidget {
  const KarmaClubFractionalOwnershipScreen({super.key});

  @override
  State<KarmaClubFractionalOwnershipScreen> createState() =>
      _KarmaClubFractionalOwnershipScreenState();
}

class _KarmaClubFractionalOwnershipScreenState
    extends State<KarmaClubFractionalOwnershipScreen> {
  Map<String, dynamic> data = {};
  bool _isLoading = true;

  Future<void> _loadJsonData() async {
    final jsonData = await loadJsonFromAssets(AppAPI.fractionalOwnership);
    setState(() {
      data = jsonData;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    Size size = MediaQuery.of(context).size;

    void onTapped(String? assetPath, Map<String, dynamic> title) async {
      if (assetPath == null || assetPath.isEmpty) {
        CustomSnackBar(
          message: tr(context, 'errors.Content not available', lang),
          context: context,
        );
        return;
      } else {
        try {
          String pdfPath = await loadPdfFromAssets(assetPath);
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => PdfScreen(pdfPath: pdfPath, title: title),
            ),
          );
        } catch (e) {
          CustomSnackBar(
            message: '${tr(context, 'Failed to load PDF', lang)}: $e',
            context: context,
          );
        }
      }
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: _isLoading
          ? const LoadingComponent()
          : Stack(
              children: [
                SingleChildScrollView(
                  scrollDirection: Axis.vertical,
                  child: Column(
                    children: [
                      Container(
                        width: size.width,
                        height: size.height / 1.5,
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage('${AppAPI.baseUrlGcp}${data['banner']['image']}'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Column(
                                children: [
                                  FadeInAnimation(
                                    delay: const Duration(milliseconds: 300),
                                    child: Container(
                                      width: 1,
                                      height: 100,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  FadeInScaleAnimation(
                                    initScale: 2,
                                    initOpacity: 0,
                                    child: CustomText(
                                      label: data['banner']['subTitle'][lang],
                                      textStyle: const TextStyle(
                                          color: AppColors.secondary),
                                      isUppercase: true,
                                    ),
                                  ),
                                  FadeInScaleAnimation(
                                    initScale: 2,
                                    initOpacity: 0,
                                    child: CustomText(
                                      label: data['banner']['title'][lang],
                                      type: 'h1',
                                      textStyle: const TextStyle(
                                          color: AppColors.white),
                                      isSerif: true,
                                    ),
                                  ),
                                  const SizedBox(height: 20),
                                  FadeInAnimation(
                                    delay: const Duration(milliseconds: 300),
                                    child: Container(
                                      width: 1,
                                      height: 100,
                                      color: AppColors.secondary,
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(140, 80, 140, 80),
                        child: Wrap(
                          runSpacing: 30,
                          children: [
                            FadeInAnimation(
                              delay: const Duration(milliseconds: 700),
                              child: CustomText(
                                label: data['banner']['title2'][lang],
                                type: 'h3',
                                textStyle:
                                    const TextStyle(color: AppColors.primary),
                                isSerif: true,
                                textAlign: TextAlign.center,
                              ),
                            ),
                            FadeInAnimation(
                              visibilityThreshold: 0.2,
                              delay: const Duration(milliseconds: 800),
                              child: CustomPara(
                                labels: [
                                  data['banner']['para1'][lang],
                                  data['banner']['para2'][lang],
                                  data['banner']['para3'][lang],
                                ],
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.fromLTRB(80, 0, 80, 80),
                        child: SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Wrap(
                            spacing: 20,
                            children: [
                              ...data['brochure']
                                  .asMap()
                                  .entries
                                  .map<Widget>((entry) {
                                int index = entry.key;

                                return index < 6
                                    ? SlideInAnimation(
                                        direction: SlideDirection.right,
                                        delay:
                                            Duration(milliseconds: 100 * index),
                                        child: Container(
                                          alignment: Alignment.bottomCenter,
                                          constraints: BoxConstraints(
                                            maxWidth: size.width / 4.4,
                                            minHeight: 350,
                                          ),
                                          padding: const EdgeInsets.fromLTRB(
                                              30, 30, 30, 30),
                                          decoration: BoxDecoration(
                                              image: DecorationImage(
                                                  image: NetworkImage(
                                                      '${AppAPI.baseUrlGcp}${entry.value['image']}'),
                                                  fit: BoxFit.fill)),
                                          child: Wrap(
                                            alignment: WrapAlignment.center,
                                            runSpacing: 20,
                                            children: [
                                              CustomText(
                                                label: entry.value['title']
                                                    [lang],
                                                type: 'h3',
                                                isSerif: true,
                                                textAlign: TextAlign.center,
                                                textStyle: const TextStyle(
                                                    color: AppColors.white),
                                              ),
                                              CustomText(
                                                label:
                                                    data['FRACTIONAL BROCHURE']
                                                        [lang],
                                                type: 'lg',
                                                isUppercase: true,
                                                textAlign: TextAlign.center,
                                                textStyle: const TextStyle(
                                                    color: AppColors.white),
                                              ),
                                              InkWell(
                                                onTap: () => onTapped(
                                                    entry.value['url'],
                                                    entry.value['title']),
                                                child: SvgPicture.asset(
                                                  AppIcons.downArrowRoundedBorder,
                                                  width: 30,
                                                  fit: BoxFit.contain,
                                                  semanticsLabel: 'arrow',
                                                  placeholderBuilder: (context) =>
                                                      const CircularProgressIndicator(),
                                                ),
                                              )
                                            ],
                                          ),
                                        ),
                                      )
                                    : Container(
                                        alignment: Alignment.bottomCenter,
                                        constraints: BoxConstraints(
                                          maxWidth: size.width / 4.4,
                                          minHeight: 350,
                                        ),
                                        padding: const EdgeInsets.fromLTRB(
                                            30, 30, 30, 30),
                                        decoration: BoxDecoration(
                                            image: DecorationImage(
                                                image: NetworkImage(
                                                    '${AppAPI.baseUrlGcp}${entry.value['image']}'),
                                                fit: BoxFit.fill)),
                                        child: Wrap(
                                          alignment: WrapAlignment.center,
                                          runSpacing: 20,
                                          children: [
                                            CustomText(
                                              label: entry.value['title'],
                                              type: 'h3',
                                              isSerif: true,
                                              textAlign: TextAlign.center,
                                              textStyle: const TextStyle(
                                                  color: AppColors.white),
                                            ),
                                            const CustomText(
                                              label: 'Fractional Brochure',
                                              type: 'lg',
                                              isUppercase: true,
                                              textAlign: TextAlign.center,
                                              textStyle: TextStyle(
                                                  color: AppColors.white),
                                            ),
                                            InkWell(
                                              onTap: () => onTapped(
                                                  entry.value['url'],
                                                  entry.value['title']),
                                              child: SvgPicture.asset(
                                                AppIcons.downArrowRoundedBorder,
                                                width: 30,
                                                fit: BoxFit.contain,
                                                semanticsLabel: 'arrow',
                                                placeholderBuilder: (context) =>
                                                    const CircularProgressIndicator(),
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                              }).toList(),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 10)
                    ],
                  ),
                ),
                const GoBack(),
              ],
            ),
    );
  }
}
