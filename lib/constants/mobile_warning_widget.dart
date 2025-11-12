import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class MobileWarningWidget extends StatelessWidget {
  const MobileWarningWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: [
              SvgPicture.asset(
                AppIcons.logo,
                colorFilter: const ColorFilter.mode(
                  AppColors.primary,
                  BlendMode.srcIn,
                ),
                width: 200,
                fit: BoxFit.contain,
                semanticsLabel: 'calendar',
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(),
              ),
              const SizedBox(
                height: 20,
              ),
              const CustomText(
                label: 'This App is not made for mobile.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
