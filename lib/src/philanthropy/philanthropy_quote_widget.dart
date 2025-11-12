import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class PhilanthropyQuoteWidget extends StatelessWidget {
  final String data;

  const PhilanthropyQuoteWidget({
    required this.data,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FadeInAnimation(
      delay: const Duration(milliseconds: 700),
      visibilityThreshold: 1,
      child: Container(
        padding: const EdgeInsets.all(50),
        constraints: const BoxConstraints(
          maxHeight: double.infinity,
        ),
        child: Wrap(
          direction: Axis.horizontal,
          spacing: 10,
          children: [
            Container(
              width: 60,
              alignment: Alignment.topRight,
              padding: const EdgeInsets.only(bottom: 60),
              child: SvgPicture.asset(
                AppIcons.quoteIcon,
                width: 60,
                fit: BoxFit.contain,
                semanticsLabel: 'quote',
                placeholderBuilder: (context) =>
                    const CircularProgressIndicator(),
              ),
            ),
            Container(
              width: 600,
              padding: const EdgeInsets.symmetric(vertical: 20),
              child: CustomText(
                type: 'h5',
                label: data,
                // ignore: prefer_const_constructors
                textStyle: TextStyle(color: AppColors.white),
                isSerif: true,
                textAlign: TextAlign.center,
              ),
            ),
            Container(
              width: 60,
              alignment: Alignment.bottomLeft,
              padding: const EdgeInsets.only(top: 60),
              child: Transform.rotate(
                angle: 3.14 / 1,
                child: SvgPicture.asset(
                  AppIcons.quoteIcon,
                  width: 60,
                  fit: BoxFit.contain,
                  semanticsLabel: 'quote',
                  placeholderBuilder: (context) =>
                      const CircularProgressIndicator(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
