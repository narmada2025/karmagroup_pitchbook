import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class CustomSnackBar {
  final String message;
  final Color backgroundColor;
  final Color textColor;
  final double? width;
  final Widget? icon;
  final Duration duration;
  final BuildContext? context;
  final SnackBarAction? action;

  CustomSnackBar({
    required this.message,
    this.backgroundColor = AppColors.primary,
    this.textColor = AppColors.white,
    this.width = 500,
    this.icon,
    this.duration = const Duration(seconds: 2),
    required this.context,
    this.action,
  }) {
    _showSnackBar();
  }

  void _showSnackBar() {
    ScaffoldMessenger.of(context!).hideCurrentSnackBar();
    ScaffoldMessenger.of(context!).showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        elevation: 0,
        width: width,
        backgroundColor: Colors.transparent,
        content: Container(
          padding: const EdgeInsets.all(10),
          decoration: BoxDecoration(
            color: backgroundColor,
            borderRadius: BorderRadius.circular(10),
          ),
          height: 60,
          child: Row(
            children: [
              icon ?? Icon(Icons.info, color: textColor),
              const SizedBox(width: 16),
              Expanded(
                child: CustomText(
                  label: message.toString(),
                  textStyle: TextStyle(
                    fontSize: 16,
                    color: textColor,
                  ),
                  maxLines: 2,
                ),
              ),
              const SizedBox(width: 16),
              IconButton(
                icon: Icon(Icons.close, color: textColor),
                onPressed: () {
                  ScaffoldMessenger.of(context!).hideCurrentSnackBar();
                },
              ),
            ],
          ),
        ),
        duration: duration,
        action: action,
      ),
    );
  }
}
