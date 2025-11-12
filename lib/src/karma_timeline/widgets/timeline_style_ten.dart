import 'package:flutter/material.dart';

class TimelineStyleTen extends StatelessWidget {
  final double topPadding;
  final Widget? leftWidget;
  final Widget? centerWidget;
  final Widget? rightWidget;
  final CrossAxisAlignment contentAlignment;

  const TimelineStyleTen(
      {super.key,
      this.leftWidget,
      this.centerWidget,
      this.rightWidget,
      this.topPadding = 120,
      this.contentAlignment = CrossAxisAlignment.start});

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
              crossAxisAlignment: contentAlignment,
              children: [
                Expanded(
                  flex: 1,
                  child: leftWidget!,
                ),
                Expanded(
                  flex: 1,
                  child: centerWidget!,
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
