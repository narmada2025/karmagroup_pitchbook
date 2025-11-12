import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';

enum ButtonType { gold, white }

class CustomTextButton extends StatelessWidget {
  final VoidCallback onPressed;
  final IconData icon;
  final String label;
  final ButtonType type;
  final double size;

  const CustomTextButton({
    super.key,
    required this.onPressed,
    required this.icon,
    required this.label,
    required this.type,
    required this.size,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onPressed,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            padding: const EdgeInsets.all(10.0),
            decoration: BoxDecoration(
              color:
                  type == ButtonType.gold ? AppColors.primary : AppColors.white,
              borderRadius: BorderRadius.circular(100.0),
            ),
            child: Icon(icon,
                color: type == ButtonType.gold
                    ? AppColors.white
                    : AppColors.black),
          ),
          const SizedBox(height: 10.0),
          Text(
            label,
            style: const TextStyle(
              color: AppColors.white,
            ),
          ),
        ],
      ),
    );
  }
}
