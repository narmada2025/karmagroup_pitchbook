import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

enum BtnType { primary, secondary, danger, text }

class CustomBtn extends StatelessWidget {
  final Widget? leading;
  final Widget? trailing;
  final BtnType btnType;
  final String label;
  final VoidCallback onPressed;
  final bool isOutlined;
  final double borderRadius;
  final double iconGap;
  final TextStyle? textStyle;
  final String type;
  final bool isSerif;
  final bool isUppercase;
  final TextAlign textAlign;
  final double? width;

  final EdgeInsetsGeometry padding;

  const CustomBtn({
    super.key,
    this.leading,
    this.trailing,
    this.btnType = BtnType.text,
    required this.label,
    required this.onPressed,
    this.isOutlined = false,
    this.borderRadius = 8,
    this.iconGap = 0,
    this.textStyle = const TextStyle(color: AppColors.white),
    this.type = 'def',
    this.isSerif = false,
    this.isUppercase = false,
    this.textAlign = TextAlign.left,
    this.width = 200,
    this.padding = const EdgeInsets.fromLTRB(20, 10, 20, 10),
  });

  @override
  Widget build(BuildContext context) {
    Color getBgColor() {
      switch (btnType) {
        case BtnType.primary:
          return AppColors.primary;
        case BtnType.secondary:
          return AppColors.black;
        case BtnType.danger:
          return Colors.red;
        default:
          return Colors.transparent;
      }
    }

    Color getBorderColor() {
      switch (btnType) {
        case BtnType.primary:
          return AppColors.primary;
        case BtnType.secondary:
          return AppColors.black;
        case BtnType.danger:
          return Colors.red;
        default:
          return Colors.transparent;
      }
    }

    if (isOutlined) {
      return OutlinedButton(
        style: OutlinedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          side: BorderSide(color: getBorderColor()),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Container(
          width: width,
          padding: padding,
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              if (leading != null) leading!,
              CustomText(
                label: label,
                type: type,
                isSerif: isSerif,
                isUppercase: isUppercase,
                textAlign: textAlign,
                textStyle: textStyle,
              ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      );
    } else {
      return ElevatedButton(
        style: ElevatedButton.styleFrom(
          padding: const EdgeInsets.all(0),
          backgroundColor: getBgColor(),
          elevation: 0,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius),
          ),
        ),
        onPressed: onPressed,
        child: Container(
          width: width,
          padding: padding,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (leading != null) leading!,
              if (leading != null)
                SizedBox(
                  width: iconGap,
                ),
              CustomText(
                label: label,
                type: type,
                isSerif: isSerif,
                isUppercase: isUppercase,
                textAlign: textAlign,
                textStyle: textStyle,
              ),
              if (trailing != null)
                SizedBox(
                  width: iconGap,
                ),
              if (trailing != null) trailing!,
            ],
          ),
        ),
      );
    }
  }
}
