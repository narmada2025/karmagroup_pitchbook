import 'package:flutter/material.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_titles.dart';

import '../../../constants/app_data.dart';

class TimelineStyleEight extends StatelessWidget {
  final String? title;
  final String? status;
  final String? tag;
  final String? title2;
  final String? tag2;
  final String? status2;
  final String image;
  final String? logo;
  final String? number;
  final String? text;
  final double topPadding;
  final WrapAlignment contentAlignment;
  final Widget? rightWidget;

  const TimelineStyleEight({
    super.key,
    this.title,
    this.status,
    this.tag,
    this.title2,
    this.status2,
    this.tag2,
    required this.image,
    this.logo,
    this.number,
    this.text,
    this.rightWidget,
    this.topPadding = 120,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  flex: 2,
                  child: Stack(
                    children: [
                      Wrap(
                        runAlignment: WrapAlignment.end,
                        runSpacing: 20,
                        children: [
                          TimelineStyleTitles(
                            status: status,
                            title: title,
                            tag: tag,
                          ),
                          Padding(
                            padding:
                                EdgeInsets.only(left: logo != null ? 10 : 0),
                            child: Image.network(
                              '${AppAPI.baseUrlGcp}$image',
                            ),
                          ),
                        ],
                      ),
                      if (logo != null)
                        Positioned(
                          top: 70,
                          left: 20,
                          child: Image.network(
                            '${AppAPI.baseUrlGcp}${logo ?? ''}',
                            height: 44,
                          ),
                        )
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Wrap(
                    runSpacing: 20,
                    children: [
                      TimelineStyleTitles(
                        status: status2,
                        title: title2,
                        tag: tag2,
                        showArrow: title2 != null ? true : false,
                      ),
                      rightWidget!
                    ],
                  ),
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
