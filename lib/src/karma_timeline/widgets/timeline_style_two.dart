import 'package:flutter/material.dart';
import 'package:pitchbook/src/karma_timeline/widgets/icon_num_text.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_titles.dart';

import '../../../constants/app_data.dart';

class TimelineStyleTwo extends StatelessWidget {
  final String? title;
  final String? status;
  final String? tag;
  final String image;
  final String? icon;
  final String? number;
  final String? text;
  final double topPadding;
  final WrapAlignment contentAlignment;

  const TimelineStyleTwo({
    super.key,
    this.title,
    this.status,
    this.tag,
    required this.image,
    this.icon,
    this.number,
    this.text,
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
                      child: Image.network(
                        '${AppAPI.baseUrlGcp}$image',
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
