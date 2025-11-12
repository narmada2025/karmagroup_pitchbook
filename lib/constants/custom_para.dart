import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';

class CustomPara extends StatelessWidget {
  final List<String> labels;
  final String type;
  final Color? color;
  final FontWeight? fontWeight;
  final bool isSerif;
  final bool isUppercase;
  final TextAlign textAlign;
  final double? paragraphSpacing;

  const CustomPara({
    super.key,
    required this.labels,
    this.type = 'body',
    this.color,
    this.isSerif = false,
    this.fontWeight,
    this.isUppercase = false,
    this.textAlign = TextAlign.left,
    this.paragraphSpacing,
  });

  @override
  Widget build(BuildContext context) {
    double fontSize;
    double lineHeight;
    switch (type) {
      case 'xlg':
        fontSize = 96;
        lineHeight = 1.2;
        break;
      case 'xmd':
        fontSize = 80;
        lineHeight = 1.2;
        break;
      case 'h1':
        fontSize = 70;
        lineHeight = 1.1;
        break;
      case 'h2':
        fontSize = 50;
        lineHeight = 1.2;
        break;
      case 'h3':
        fontSize = 40;
        lineHeight = 1.3;
        break;
      case 'h4':
        fontSize = 30;
        lineHeight = 1.3;
        break;
      case 'h5':
        fontSize = 24;
        lineHeight = 1.4;
        break;
      case 'h6':
        fontSize = 20;
        lineHeight = 1.4;
        break;
      case 'sm':
        fontSize = 14;
        lineHeight = 1.5;
        break;
      case 'xs':
        fontSize = 12;
        lineHeight = 1.5;
        break;
      default:
        fontSize = 16;
        lineHeight = 1.5;
    }

    String defaultFontFamily = isSerif ? 'Playfair' : 'Montserrat';

    return Column(
      children: labels.map((label) {
        return Container(
          margin: EdgeInsets.only(bottom: paragraphSpacing ?? 16.0),
          child: Text(
            isUppercase ? label.toUpperCase() : label,
            textAlign: textAlign,
            style: TextStyle(
              color: color ?? AppColors.white,
              fontSize: fontSize,
              fontWeight: fontWeight ?? FontWeight.normal,
              fontFamily: defaultFontFamily,
              height: lineHeight,
            ),
          ),
        );
      }).toList(),
    );
  }
}
