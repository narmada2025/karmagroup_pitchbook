import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';

class ScrollIndicator extends StatelessWidget {
  final ScrollController controller;
  final int itemCount;

  const ScrollIndicator(
      {super.key, required this.controller, required this.itemCount});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(itemCount, (index) {
        return Container(
          width: 8,
          height: 8,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: index == controller.offset ~/ 100
                ? AppColors.primary
                : AppColors.white,
          ),
        );
      }),
    );
  }
}
