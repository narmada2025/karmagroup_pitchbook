import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:shimmer/shimmer.dart';

class SkeletonLoader extends StatelessWidget {
  const SkeletonLoader({
    super.key,
    this.height,
    this.width,
    this.borderRadius,
  });

  final double? height;
  final double? width;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.gray,
      highlightColor: const Color.fromARGB(255, 85, 85, 85),
      child: Container(
        height: height ?? double.infinity,
        width: width ?? double.infinity,
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: borderRadius ?? BorderRadius.circular(4.0),
        ),
      ),
    );
  }
}
