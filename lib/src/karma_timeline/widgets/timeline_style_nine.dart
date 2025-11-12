import 'package:flutter/material.dart';

import '../../../constants/app_data.dart';

class TimelineStyleNine extends StatelessWidget {
  final String image;
  final String? logo;
  final String? number;
  final String? text;
  final double topPadding;
  final WrapAlignment contentAlignment;
  final Widget? leftWidget;
  final Widget? rightWidget;

  const TimelineStyleNine({
    super.key,
    required this.image,
    this.logo,
    this.number,
    this.text,
    this.leftWidget,
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
                  child: Container(
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: NetworkImage('${AppAPI.baseUrlGcp}$image'),
                        fit: BoxFit.fitWidth,
                      ),
                    ),
                    child: leftWidget,
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: rightWidget!,
                ),
              ],
            ),
          )
        ],
      ),
    );
  }
}
