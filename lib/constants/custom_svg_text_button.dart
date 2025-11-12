import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/app_data.dart';

class CustomSvgTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final String svgPath;
  final double size;

  const CustomSvgTextButton({
    super.key,
    required this.onTap,
    required this.label,
    required this.svgPath,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: SvgPicture.asset(
              svgPath,
              fit: BoxFit.cover,
              semanticsLabel: 'bg',
              placeholderBuilder: (context) =>
                  const CircularProgressIndicator(),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
