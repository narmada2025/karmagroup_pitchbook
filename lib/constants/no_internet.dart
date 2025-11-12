import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class NoInternet extends StatelessWidget {
  final VoidCallback onRefresh;

  const NoInternet({super.key, required this.onRefresh});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.all(60),
      padding: const EdgeInsets.all(40),
      alignment: Alignment.center,
      decoration: BoxDecoration(
          color: AppColors.gray, borderRadius: BorderRadius.circular(20)),
      child: Wrap(
        crossAxisAlignment: WrapCrossAlignment.center,
        spacing: 10,
        direction: Axis.vertical,
        children: [
          const Icon(
            Icons.wifi_off_rounded,
            color: Colors.redAccent,
            size: 40,
          ),
          const CustomText(
            label:
                'Looks like you are not connected to the internet. \nConnect to the Internet and try again',
            textStyle: TextStyle(
              color: AppColors.white,
            ),
            textAlign: TextAlign.center,
          ),
          ElevatedButton(
            onPressed: onRefresh,
            child: const Text(
              'Refresh',
              style: TextStyle(color: AppColors.primary),
            ),
          ),
        ],
      ),
    );
  }
}
