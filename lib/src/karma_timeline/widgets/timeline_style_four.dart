import 'package:flutter/material.dart';
import 'package:pitchbook/src/karma_timeline/widgets/icon_num_text.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_titles.dart';

import '../../../constants/app_data.dart';

class TimelineStyleFour extends StatelessWidget {
  final String? title;
  final String? status;
  final String? tag;
  final String? title2;
  final String? tag2;
  final String? title3;
  final String? tag3;
  final String image;
  final String? icon;
  final String? icon2;
  final String? number;
  final String? text;
  final String? textRight;
  final String? award;
  final double topPadding;
  final WrapAlignment contentAlignment;

  const TimelineStyleFour({
    super.key,
    this.title,
    this.status,
    this.tag,
    this.title2,
    this.tag2,
    this.title3,
    this.tag3,
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
                Transform.translate(
                  offset: const Offset(0, 50),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        flex: 1,
                        child: TimelineStyleTitles(
                          status: status,
                          title: title,
                          tag: tag,
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Padding(
                          padding: const EdgeInsets.only(left: 20),
                          child: Wrap(
                            spacing: 4,
                            direction: Axis.vertical,
                            children: [
                              TimelineStyleTitles(
                                title: title2,
                                tag: tag2,
                                showArrow: false,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              TimelineStyleTitles(
                                title: title3,
                                tag: tag3,
                                showArrow: false,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
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
                      child: IconNumText(
                        icon: icon,
                        number: number,
                        text: textRight,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
