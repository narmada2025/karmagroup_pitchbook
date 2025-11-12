import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_btn.dart';
import 'package:pitchbook/constants/custom_text.dart';

class CardOneWidget extends StatelessWidget {
  final String title;
  final String description;
  final Color borderColor;
  final bool showBtn;
  final String? btnText;
  final VoidCallback onTap;

  const CardOneWidget({
    super.key,
    required this.title,
    required this.description,
    required this.borderColor,
    this.showBtn = false,
    this.btnText = 'Know More',
    this.onTap = _defaultOnTap,
  });

  static void _defaultOnTap() {}

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
              type: 'h3',
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
          if (showBtn)
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: CustomBtn(
                label: btnText!,
                btnType: BtnType.primary,
                onPressed: onTap,
                textAlign: TextAlign.center,
                borderRadius: 50,
              ),
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
