import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class PropertyItem extends StatelessWidget {
  final String title;
  final String image;
  final double width;
  final double height;
  final int propertyCount;

  const PropertyItem({
    super.key,
    required this.title,
    required this.image,
    this.width = 250,
    this.height = 360,
    required this.propertyCount,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width / 4.5,
      height: height,
      margin: const EdgeInsets.only(right: 20),
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        image: DecorationImage(
            image: NetworkImage('${AppAPI.baseUrlGcp}$image'),
            fit: BoxFit.cover,
            alignment: Alignment.bottomCenter),
        borderRadius: BorderRadius.circular(10),
      ),
      child: Container(
        alignment: Alignment.bottomCenter,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          gradient: LinearGradient(
              colors: [
                AppColors.black.withValues(alpha: 0.8),
                AppColors.black.withValues(alpha: 0.4),
                AppColors.black.withValues(alpha: 0)
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
              stops: const [0, 0.4, .8]),
        ),
        child: CustomText(
          label: title,
          isSerif: true,
          type: 'h6',
          textStyle: const TextStyle(color: AppColors.white),
        ),
      ),
    );
  }
}
