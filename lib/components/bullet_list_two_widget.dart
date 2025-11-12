import 'package:flutter/material.dart';
import 'package:pitchbook/constants/custom_text.dart';

class BulletListTwoWidget extends StatelessWidget {
  final Widget iconWidget;
  final Widget? iconTrailWidget;
  final TextStyle textStyle;
  final String type;
  final bool isSerif;
  final TextAlign textAlign;
  final double gap;
  final double itemGap;
  final List<BulletItem> items;

  const BulletListTwoWidget({
    super.key,
    required this.iconWidget,
    required this.textStyle,
    this.type = 'def',
    this.isSerif = false,
    this.textAlign = TextAlign.left,
    required this.gap,
    this.itemGap = 12.0,
    required this.items,
    this.iconTrailWidget,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: items.map((item) {
        return Container(
          padding: EdgeInsets.only(bottom: itemGap),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              iconWidget,
              SizedBox(width: gap),
              Container(
                padding: const EdgeInsets.only(bottom: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    CustomText(
                      label: item.text,
                      type: type,
                      isSerif: isSerif,
                      textAlign: textAlign,
                      textStyle: textStyle,
                    ),
                    SizedBox(width: gap),
                    SizedBox(child: iconTrailWidget),
                  ],
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}

class BulletItem {
  final String text;

  BulletItem({required this.text});
}
