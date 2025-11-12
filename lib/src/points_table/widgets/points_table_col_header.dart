import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class PointsTableColHeader extends StatelessWidget {
  final String? title;
  final String col1Title;
  final String col2Title;
  final String col3Title;
  final String? lang;
  final List<dynamic>? list;
  final double? height;
  final double iconWidth;
  final double iconGap;
  final TextStyle? textStyle;
  final Color bgColor;
  final Color gapColor;
  final double gap;
  final double listGap;
  final bool showCategory;
  final TextAlign textAlignment;
  final String alignment;

  const PointsTableColHeader({
    super.key,
    this.title,
    this.col1Title = "Red",
    this.col2Title = "White",
    this.col3Title = "Blue",
    this.lang,
    this.list,
    this.height,
    this.iconWidth = 8,
    this.iconGap = 6,
    this.textStyle,
    this.bgColor = AppColors.dark,
    this.gapColor = AppColors.black,
    this.gap = 2,
    this.listGap = 5,
    this.showCategory = true,
    this.textAlignment = TextAlign.center,
    this.alignment = 'center',
  });

  _splitText(String text) {
    RegExp regExp = RegExp(r'(?:(?: |)([^(]+))(?: |)\(([^)]+)\)');
    Iterable<Match> lines = regExp.allMatches(text);
    return lines;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.topLeft,
      height: height,
      decoration: BoxDecoration(
          color: bgColor, border: Border.all(color: gapColor, width: gap)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
              child: Container(
            padding: const EdgeInsets.all(10),
            child: Column(
              crossAxisAlignment: alignment == 'center'
                  ? CrossAxisAlignment.center
                  : CrossAxisAlignment.start,
              mainAxisAlignment: alignment == 'center'
                  ? MainAxisAlignment.center
                  : MainAxisAlignment.start,
              children: [
                if (title != null)
                  for (Match line in _splitText(title!))
                    CustomContainer(
                      line: line,
                      textStyle: textStyle,
                      textAlignment: textAlignment,
                      iconWidth: iconWidth,
                      iconGap: iconGap,
                    ),
                if (list != null)
                  Flexible(
                    child: Wrap(
                      runSpacing: listGap,
                      children: [
                        ...list!.map<Widget>((entry) {
                          return Wrap(
                            direction: Axis.horizontal,
                            children: [
                              for (var line in _splitText(entry[lang]))
                                Row(
                                  children: [
                                    CustomContainer(
                                      line: line,
                                      isMultiLine: true,
                                      textStyle: textStyle,
                                      textAlignment: textAlignment,
                                      iconWidth: iconWidth,
                                      iconGap: iconGap,
                                    ),
                                  ],
                                ),
                            ],
                          );
                        }),
                      ],
                    ),
                  )
              ],
            ),
          )),
          if (showCategory)
            Row(
              children: [
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
                    color: Colors.red.shade300,
                    child: Center(
                        child: CustomText(
                            label: col1Title,
                            type: 'xs',
                            isUppercase: true,
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.w600))),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
                    color: Colors.white,
                    child: Center(
                        child: CustomText(
                            label: col2Title,
                            type: 'xs',
                            isUppercase: true,
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.w600))),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(2, 10, 2, 10),
                    color: Colors.blue.shade300,
                    child: Center(
                        child: CustomText(
                            label: col3Title,
                            type: 'xs',
                            isUppercase: true,
                            textStyle:
                                const TextStyle(fontWeight: FontWeight.w600))),
                  ),
                )
              ],
            ),
        ],
      ),
    );
  }
}

class CustomContainer extends StatelessWidget {
  final Match line;
  final bool isMultiLine;
  final TextStyle? textStyle;
  final double iconWidth;
  final double iconGap;

  final TextAlign textAlignment;

  const CustomContainer(
      {super.key,
      required this.line,
      this.isMultiLine = false,
      required this.textStyle,
      required this.iconWidth,
      required this.iconGap,
      required this.textAlignment});

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Wrap(
        alignment: textAlignment == TextAlign.center
            ? WrapAlignment.center
            : WrapAlignment.start,
        direction: Axis.horizontal,
        children: [
          CustomText(
            label: line.group(1)!,
            type: 'sm',
            textAlign: textAlignment,
            textStyle: const TextStyle(
              color: AppColors.white,
              fontWeight: FontWeight.w600,
              height: 1.2,
            ).merge(textStyle),
          ),
          Wrap(
            children: [
              CustomText(
                label: '(${line.group(2)!.split(' x ')[0]} X ',
                type: 'sm',
                textAlign: textAlignment,
                textStyle: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ).merge(textStyle),
              ),
              SizedBox(
                width: isMultiLine ? 2 : iconGap,
              ),
              SvgPicture.asset(
                AppIcons.person,
                width: iconWidth,
                fit: BoxFit.contain,
                semanticsLabel: 'person',
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(),
              ),
              CustomText(
                label: ' )',
                type: 'sm',
                textAlign: TextAlign.center,
                textStyle: const TextStyle(
                  color: AppColors.white,
                  fontWeight: FontWeight.w600,
                  height: 1,
                ).merge(textStyle),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
