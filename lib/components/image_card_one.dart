import 'package:flutter/material.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/app_data.dart';

class ImageCardOne extends StatelessWidget {
  final String title;
  final String description;
  final Color borderColor;

  const ImageCardOne({
    super.key,
    required this.title,
    required this.description,
    required this.borderColor,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(30),
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: borderColor),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: 50,
            child: Divider(
              thickness: 2,
              color: borderColor,
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 10, 0, 20),
            child: CustomText(
              label: title,
              type: 'h2',
              isSerif: true,
              textAlign: TextAlign.center,
              textStyle: const TextStyle(color: AppColors.white),
            ),
          ),
          CustomText(
            label: description,
            type: 'md',
            textAlign: TextAlign.center,
            textStyle: const TextStyle(color: AppColors.white),
          ),
          Container(
            margin: const EdgeInsets.only(top: 10),
            width: 1,
            height: 30,
            decoration: BoxDecoration(
              color: borderColor,
            ),
          ),
        ],
      ),
    );
  }
}
