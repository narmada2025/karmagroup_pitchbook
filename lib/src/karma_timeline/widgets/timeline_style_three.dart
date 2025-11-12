import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/src/karma_timeline/widgets/icon_num_text.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_titles.dart';

class TimelineStyleThree extends StatelessWidget {
  final String? title;
  final String? status;
  final String? tag;
  final String? title2;
  final String? tag2;
  final String image;
  final String? icon;
  final String? icon2;
  final String? number;
  final String? text;
  final String? textRight;
  final String? award;
  final double topPadding;
  final WrapAlignment contentAlignment;

  const TimelineStyleThree({
    super.key,
    this.title,
    this.status,
    this.tag,
    this.title2,
    this.tag2,
    required this.image,
    this.icon,
    this.icon2,
    this.award,
    this.number,
    this.text,
    this.textRight,
    this.topPadding = 100,
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
            padding: EdgeInsets.fromLTRB(8, topPadding, 8, topPadding / 1.2),
            child: Wrap(
              runAlignment: WrapAlignment.end,
              runSpacing: 30,
              children: [
                TimelineStyleTitles(
                  status: status,
                  title: title,
                  tag: tag,
                ),
                Row(
                  children: [
                    Expanded(
                      flex: 2,
                      child: Image.network('${AppAPI.baseUrlGcp}$image',
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.center,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: award != null
                              ? CrossAxisAlignment.center
                              : CrossAxisAlignment.start,
                          children: [
                            Image.network(
                              '${AppAPI.baseUrlGcp}${icon2 ?? ''}',
                              width: 40,
                            ),
                            if (award != null)
                              Padding(
                                padding: const EdgeInsets.only(left: 10),
                                child: Image.network('${AppAPI.baseUrlGcp}${award??""}',
                                  width: 130,
                                ),
                              ),
                            if (textRight != null)
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                child: SvgPicture.asset(
                                  AppIcons.chevLeft,
                                  width: 8,
                                  fit: BoxFit.contain,
                                  semanticsLabel: 'chevLeft',
                                  placeholderBuilder: (context) =>
                                      const CircularProgressIndicator(),
                                ),
                              ),
                            CustomText(
                              label: textRight ?? '',
                              type: 'sm',
                              isUppercase: true,
                              textStyle: const TextStyle(
                                  color: AppColors.white,
                                  height: 1.2,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 1,
                      child: TimelineStyleTitles(
                        title: title2,
                        tag: tag2,
                        showArrow: false,
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: IconNumText(
                        icon: icon,
                        number: number,
                        text: text,
                      ),
                    ),
                    const Expanded(
                      flex: 1,
                      child: SizedBox(),
                    )
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
