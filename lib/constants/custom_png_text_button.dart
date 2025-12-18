import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';

class CustomPngTextButton extends StatelessWidget {
  final VoidCallback onTap;
  final String label;
  final String svgPath;
  final double size;
  final bool isChangeColor;

  const CustomPngTextButton({
    super.key,
    required this.onTap,
    required this.label,
    required this.svgPath,
    required this.size,
    this.isChangeColor = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: size,
            height: size,
            decoration: BoxDecoration(
              color:isChangeColor?AppColors.strokeColor: AppColors.white, //Circular Container color
              shape: BoxShape.circle,
            ),
            child:Padding(
              padding: const EdgeInsets.all(7.0),
              child: Image.asset(
                svgPath,
                fit: BoxFit.scaleDown,
                color: isChangeColor?Colors.white: Colors.black,
              ),
            ),
          ),
          const SizedBox(height: 10.0),
          Text(
            label,
            textAlign: TextAlign.center,
            style: const TextStyle(
                color:AppColors.white,
                fontStyle: FontStyle.normal,
                fontWeight: FontWeight.w400
            ),
          ),
        ],
      ),
    );
  }
}
