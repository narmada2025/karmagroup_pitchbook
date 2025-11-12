import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/app_data.dart';

class TimelineStyleFive extends StatelessWidget {
  final String? title;
  final String? status;
  final String logo;
  final String? logo2;
  final String? icon1;
  final String? icon2;
  final String? icon3;
  final String? icon4;
  final double topPadding;
  final WrapAlignment contentAlignment;

  const TimelineStyleFive({
    super.key,
    this.title,
    this.status,
    required this.logo,
    this.logo2,
    this.icon1,
    this.icon2,
    this.icon3,
    this.icon4,
    this.topPadding = 150,
    this.contentAlignment = WrapAlignment.end,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (size.width * 0.15)),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 4; i++)
                const VerticalDivider(
                  thickness: 1,
                  color: Color.fromARGB(129, 77, 73, 68),
                )
            ],
          ),
          Container(
            height: size.height / 1.2,
            padding: EdgeInsets.fromLTRB(8, topPadding, 8, topPadding / 1.5),
            child: Wrap(
              runSpacing: 30,
              children: [
                Container(
                  padding: const EdgeInsets.only(left: 20),
                  alignment: Alignment.topLeft,
                  child: Wrap(
                    direction: Axis.vertical,
                    spacing: 20,
                    children: [
                      CustomText(
                        label: title ?? '',
                        type: 'h6',
                        isSerif: true,
                        textStyle: const TextStyle(
                            color: AppColors.white, height: 1.2),
                      ),
                      if (title != null)
                        SvgPicture.asset(
                          AppIcons.chevDown,
                          width: 14,
                          fit: BoxFit.contain,
                          semanticsLabel: 'calendar',
                          placeholderBuilder: (context) =>
                              const CircularProgressIndicator(),
                        ),
                    ],
                  ),
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        alignment: Alignment.topLeft,
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: 20,
                          children: [
                            Image.network(
                              '${AppAPI.baseUrlGcp}$logo',
                              width: 200,
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        padding: const EdgeInsets.only(left: 20),
                        alignment: Alignment.topLeft,
                        child: Wrap(
                          alignment: WrapAlignment.center,
                          spacing: 20,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  '${AppAPI.baseUrlGcp}${icon1 ?? ' '}',
                                  width: 70,
                                ),
                                Image.network(
                                  '${AppAPI.baseUrlGcp}${icon2 ?? ' '}',
                                  width: 40,
                                ),
                              ],
                            ),
                            Container(
                              margin: const EdgeInsets.symmetric(vertical: 40),
                              padding:
                                  const EdgeInsets.fromLTRB(40, 10, 40, 10),
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.primary, width: 0.5)),
                              child: CustomText(
                                label: status ?? '',
                                type: 'sm',
                                textStyle:
                                    const TextStyle(color: AppColors.white),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Image.network(
                                  '${AppAPI.baseUrlGcp}${icon3 ?? ' '}',
                                  width: 100,
                                ),
                                Image.network(
                                  '${AppAPI.baseUrlGcp}${icon4 ?? ' '}',
                                  width: 60,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        child: Wrap(
                          direction: Axis.vertical,
                          spacing: 20,
                          children: [
                            Image.network(
                              '${AppAPI.baseUrlGcp}${logo2 ?? ' '}',
                              width: 220,
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
