import 'package:flutter/material.dart';
import 'package:pitchbook/constants/custom_text.dart';

class BulletListWidget extends StatelessWidget {
  final Widget iconWidget;
  final TextStyle textStyle;
  final String type;
  final bool isSerif;
  final TextAlign textAlign;
  final double gap;
  final double itemGap;
  final List<BulletItem> items;

  const BulletListWidget({
    super.key,
    required this.iconWidget,
    required this.textStyle,
    this.type = 'def',
    this.isSerif = false,
    this.textAlign = TextAlign.left,
    required this.gap,
    this.itemGap = 12.0,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: items.map((item) {
        return Padding(
          padding: EdgeInsets.only(bottom: itemGap),
          child: Row(
            children: [
              iconWidget,
              SizedBox(width: gap),
              CustomText(
                label: item.text,
                type: type,
                isSerif: isSerif,
                textAlign: textAlign,
                textStyle: textStyle,
              ),
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
