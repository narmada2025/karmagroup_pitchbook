import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';

class CustomText extends StatelessWidget {
  final String label;
  final String type;
  final bool isSerif;
  final bool isUppercase;
  final TextAlign textAlign;
  final TextOverflow overflow;
  final TextStyle? textStyle;
  final int maxLines;

  const CustomText({
    super.key,
    required this.label,
    this.type = 'def',
    this.isSerif = false,
    this.isUppercase = false,
    this.textAlign = TextAlign.left,
    this.textStyle,
    this.maxLines = 6,
    this.overflow = TextOverflow.ellipsis,
  });

  @override
  Widget build(BuildContext context) {
    double textSize;
    double textHeight;

    switch (type) {
      case 'xlg':
        textSize = TextSize.xlg;
        textHeight = TextHeight.xlg;
        break;
      case 'xmd':
        textSize = TextSize.xmd;
        textHeight = TextHeight.xmd;
        break;
      case 'xsm':
        textSize = TextSize.xsm;
        textHeight = TextHeight.xsm;
        break;
      case 'h1':
        textSize = TextSize.h1;
        textHeight = TextHeight.h1;
        break;
      case 'h2':
        textSize = TextSize.h2;
        textHeight = TextHeight.h2;
        break;
      case 'h3':
        textSize = TextSize.h3;
        textHeight = TextHeight.h3;
        break;
      case 'h3n':
        textSize = TextSize.h3n;
        textHeight = TextHeight.h3n;
        break;
      case 'h4':
        textSize = TextSize.h4;
        textHeight = TextHeight.h4;
        break;
      case 'h5':
        textSize = TextSize.h5;
        textHeight = TextHeight.h5;
        break;
      case 'h6':
        textSize = TextSize.h6;
        textHeight = TextHeight.h6;
        break;
      case 'lg':
        textSize = TextSize.lg;
        textHeight = TextHeight.lg;
        break;
      case 'md':
        textSize = TextSize.md;
        textHeight = TextHeight.md;
        break;
      case 'sm':
        textSize = TextSize.sm;
        textHeight = TextHeight.sm;
        break;
      case 'xs':
        textSize = TextSize.xs;
        textHeight = TextHeight.xs;
        break;
      default:
        textSize = TextSize.def;
        textHeight = TextHeight.def;
    }

    return Text(
      isUppercase ? label.toUpperCase() : label,
      textAlign: textAlign,
      overflow: overflow,
      maxLines: maxLines,
      style: TextStyle(
        fontFamily: isSerif ? 'Playfair' : 'Montserrat',
        fontSize: textSize,
        height: textHeight,
      ).merge(textStyle),
    );
  }
}
