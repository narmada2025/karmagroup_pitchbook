import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';

import 'skeleton_loader.dart';

class ImageNetworkWidget extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final EdgeInsets? padding;
  final Widget? child;
  final BoxFit fit;
  final AlignmentGeometry imageAlignment;
  final BoxDecoration decoration;

  const ImageNetworkWidget({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.padding,
    this.child,
    this.fit = BoxFit.cover,
    this.imageAlignment = Alignment.center,
    this.decoration = const BoxDecoration(
      color: AppColors.gray,
    ),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      padding: padding,
      clipBehavior: Clip.antiAlias,
      decoration: decoration,
      child: Stack(
        fit: StackFit.expand,
        children: [
          imageUrl.isEmpty
              ? const Center(child: SkeletonLoader())
              : Image.network(
                  imageUrl,
                  fit: fit,
                  alignment: imageAlignment,
                  loadingBuilder: (BuildContext context, Widget child,
                      ImageChunkEvent? loadingProgress) {
                    if (loadingProgress == null) {
                      return child;
                    }
                    return const Center(child: SkeletonLoader());
                  },
                  errorBuilder: (BuildContext context, Object error,
                      StackTrace? stackTrace) {
                    return const Center(child: Icon(Icons.error));
                  },
                ),
          if (child != null) child!,
        ],
      ),
    );
  }
}
