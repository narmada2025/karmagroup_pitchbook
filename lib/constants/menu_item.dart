import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_svg_text_button.dart';

import 'custom_png_text_button.dart';

class MenuItem extends StatelessWidget {
  final double btnSize;
  final String label;
  final String svgPath;
  final VoidCallback? onTap;
  final bool isShortPath;
  final bool showPath;
  final bool isChangeColor;
  final bool isPng;

  const MenuItem({
    super.key,
    this.btnSize = 44,
    required this.label,
    required this.svgPath,
    this.onTap,
    this.isShortPath = false,
    this.showPath = true,
    this.isChangeColor = false,
    this.isPng = false
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        if (showPath)
          Padding(
            padding: const EdgeInsets.only(right: 35),
            child: SvgPicture.asset(
              isShortPath
                  ? AppIcons.menuShortPathIcon
                  : AppIcons.menuLongPathIcon,
              width: isShortPath ? 38 : 38,
              colorFilter:  const ColorFilter.mode(AppColors.strokeColor, BlendMode.srcIn),
              fit: BoxFit.contain,
              alignment: Alignment.topCenter,
              semanticsLabel: 'path',
              placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
            ),
          ),
        if (!showPath && btnSize == 44)
          const SizedBox(
            height: 14,
          ),
        (isPng == false)? CustomSvgTextButton(
          onTap: onTap!,
          label: label,
          svgPath: svgPath,
          size: btnSize,
          isChangeColor: isChangeColor,
        )
        :CustomPngTextButton(
          onTap: onTap!,
          label: label,
          svgPath: svgPath,
          size: btnSize,
          isChangeColor: isChangeColor,
        ),
      ],
    );
  }
}
