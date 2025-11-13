import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class IconNumText extends StatelessWidget {
  final String? icon;
  final String? number;
  final String? text;
  final TextStyle? textStyle;
  final EdgeInsetsGeometry? textPadding;
  final MainAxisAlignment contentAlignment;
  final double padLeft;
  final bool isUppercase;

  const IconNumText({
    super.key,
    this.icon,
    this.number,
    this.text,
    this.textStyle,
    this.textPadding,
    this.contentAlignment = MainAxisAlignment.center,
    this.padLeft = 0,
    this.isUppercase = true,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.only(left: padLeft),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: contentAlignment,
        children: [
          if (icon != null)
            Image.network(
              '${AppAPI.baseUrlGcp}${icon ?? ''}',
              width: 40,
            ),
          if (icon != null)
            // Padding(
            //   padding: const EdgeInsets.symmetric(horizontal: 10),
            //   child: SvgPicture.asset(
            //     AppIcons.chevLeft,
            //     width: 8,
            //     fit: BoxFit.contain,
            //     semanticsLabel: 'chevLeft',
            //     placeholderBuilder: (context) =>
            //         const CircularProgressIndicator(),
            //   ),
            // ),
          if (number != null)
            CustomText(
              label: number ?? '',
              type: 'h2',
              textStyle: TextStyle(
                  color: AppColors.white,
                  fontFamily: 'Eloquent',
                  letterSpacing: number!.length > 1 ? -1 : 0),
            ),
          if (number != null) const SizedBox(width: 10),
          Flexible(
            child: Padding(
              padding: textPadding ?? const EdgeInsets.all(0),
              child: CustomText(
                label: text ?? '',
                type: 'xs',
                isUppercase: isUppercase,
                textStyle: const TextStyle(
                        color: AppColors.white,
                        height: 1.2,
                        fontWeight: FontWeight.w500)
                    .merge(textStyle),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
