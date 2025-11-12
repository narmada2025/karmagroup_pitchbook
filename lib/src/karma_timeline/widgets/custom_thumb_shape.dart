import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class CustomThumbShape extends StatelessWidget {
  final String label;
  final bool isActive;

  const CustomThumbShape({
    super.key,
    required this.label,
    this.isActive = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.transparent,
      width: 44,
      alignment: Alignment.center,
      padding: const EdgeInsets.fromLTRB(0, 9, 0, 9),
      child: Wrap(
        direction: Axis.vertical,
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 5,
        children: [
          AnimatedContainer(
            width: 12,
            height: 12,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppColors.white : AppColors.tableGray2,
            ),
          ),
          AnimatedContainer(
            width: 6,
            height: 6,
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isActive ? AppColors.white : AppColors.tableGray2,
            ),
          ),
          AnimatedDefaultTextStyle(
            style: TextStyle(
              color: isActive ? AppColors.white : AppColors.black,
              fontWeight: FontWeight.w500,
            ),
            duration: const Duration(milliseconds: 500),
            curve: Curves.ease,
            child: CustomText(
              label: label,
              type: 'xs',
            ),
          )
        ],
      ),
    );
  }
}
