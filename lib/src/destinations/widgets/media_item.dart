import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class MediaItem extends StatelessWidget {
  final Map<String, dynamic> media;
  final Function onTap;

  const MediaItem({
    super.key,
    required this.media,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Flexible(
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: InkWell(
          onTap: () => onTap(),
          child: Stack(
            alignment: Alignment.bottomCenter,
            children: [
              Image.network('${AppAPI.baseUrlGcp}${media['thumb']}'),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(40),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.black.withValues(alpha: 0.5),
                      AppColors.black.withValues(alpha: 0.0)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0.2, 1.0],
                  ),
                ),
                child: CustomText(
                  label: media['name'],
                  type: 'h4',
                  isSerif: true,
                  textAlign: TextAlign.center,
                  textStyle: const TextStyle(color: AppColors.white),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
