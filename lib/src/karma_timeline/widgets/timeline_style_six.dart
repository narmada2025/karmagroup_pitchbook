import 'package:flutter/material.dart';
import 'package:pitchbook/src/karma_timeline/widgets/timeline_style_titles.dart';

import '../../../constants/app_data.dart';

class TimelineStyleSix extends StatelessWidget {
  final String? title;
  final String? tag;
  final String? status;
  final String image;
  final String? image2;
  final String? logo;

  final double topPadding;
  final WrapAlignment contentAlignment;

  const TimelineStyleSix({
    super.key,
    this.title,
    this.tag,
    this.status,
    required this.image,
    this.image2,
    this.logo,
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
              runSpacing: 0,
              children: [
                TimelineStyleTitles(
                  status: status,
                  title: title,
                  tag: tag,
                ),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 40),
                        child: Image.network(
                          '${AppAPI.baseUrlGcp}$image',
                        ),
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Stack(
                        children: [
                          Image.network(
                            '${AppAPI.baseUrlGcp}${image2 ?? ' '}',
                            width: 220,
                          ),
                          Positioned(
                            top: 20,
                            left: 200,
                            child: Image.network(
                              '${AppAPI.baseUrlGcp}${logo ?? ' '}',
                              width: 140,
                            ),
                          ),
                        ],
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
