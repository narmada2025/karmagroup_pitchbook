import 'package:flutter/material.dart';

class NetworkImageWithPlaceholder extends StatelessWidget {
  final String imageUrl;
  final double width;

  const NetworkImageWithPlaceholder(
      {super.key, required this.imageUrl, required this.width});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1)),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return Image.network(
            imageUrl,
            width: width,
            fit: BoxFit.cover,
            color: Colors.black.withValues(alpha: .5),
            colorBlendMode: BlendMode.multiply,
            loadingBuilder: (BuildContext context, Widget child,
                ImageChunkEvent? loadingProgress) {
              if (loadingProgress == null) {
                return child;
              }
              return Center(
                child: CircularProgressIndicator(
                  value: loadingProgress.expectedTotalBytes != null
                      ? loadingProgress.cumulativeBytesLoaded /
                          loadingProgress.expectedTotalBytes!
                      : null,
                ),
              );
            },
            errorBuilder:
                (BuildContext context, Object error, StackTrace? stackTrace) {
              return const Center(
                child: Icon(
                  Icons.error,
                  color: Colors.red,
                ),
              );
            },
          );
        }
      },
    );
  }
}
