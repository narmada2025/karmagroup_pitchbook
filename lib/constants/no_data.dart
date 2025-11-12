import 'package:flutter/material.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/app_data.dart';

class NoData extends StatelessWidget {
  final String title;
  final TextStyle textStyle;
  final bool isDark;
  final bool isLoading;

  const NoData({
    super.key,
    required this.title,
    this.textStyle = const TextStyle(color: Colors.red),
    this.isDark = true,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(40),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomText(
            label: title,
            type: 'md',
            textAlign: TextAlign.center,
            textStyle: isDark
                ? const TextStyle(
                    color: AppColors.white,
                  ).merge(textStyle)
                : const TextStyle(
                    color: AppColors.black,
                  ).merge(textStyle),
          ),
          if (isLoading)
            const SizedBox(
              width: 30,
            ),
          if (isLoading)
            const CircularProgressIndicator(
              color: AppColors.primary,
              backgroundColor: Colors.grey,
            ),
        ],
      ),
    );
  }
}
