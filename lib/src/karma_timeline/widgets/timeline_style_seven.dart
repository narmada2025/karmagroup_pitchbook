import 'package:flutter/material.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_titles.dart';

import '../../../constants/app_data.dart';

class TimelineStyleSeven extends StatelessWidget {
  final String? title;
  final String? status;
  final String? tag;
  final String? title2;
  final String? status2;
  final String? tag2;
  final String image;
  final double topPadding;
  final WrapAlignment contentAlignment;
  final Widget? rightWidget;

  const TimelineStyleSeven({
    super.key,
    this.title,
    this.status,
    this.tag,
    this.title2,
    this.status2,
    this.tag2,
    required this.image,
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
              children: [
                Expanded(
                  flex: 2,
                  child: Wrap(
                    runAlignment: WrapAlignment.end,
                    runSpacing: 30,
                    children: [
                      TimelineStyleTitles(
                        status: status,
                        title: title,
                        tag: tag,
                      ),
                      Image.network(
                        '${AppAPI.baseUrlGcp}$image',
                      ),
                      TimelineStyleTitles(
                        status: status2,
                        title: title2,
                        tag: tag2,
                        showArrow: false,
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: rightWidget,
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
