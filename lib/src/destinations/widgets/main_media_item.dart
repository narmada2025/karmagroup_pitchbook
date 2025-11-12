import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class MainMediaItem extends StatelessWidget {
  final String thumb;
  final String title;
  final Function onTap;
  final double width;

  const MainMediaItem({
    super.key,
    required this.thumb,
    required this.title,
    required this.onTap,
    this.width = 300,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      child: InkWell(
        splashColor: Colors.transparent,
        onTap: () => onTap(),
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network(
              '${AppAPI.baseUrlGcp}$thumb',
              fit: BoxFit.fitWidth,
            ),
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
                label: title,
                type: 'h4',
                isSerif: true,
                textAlign: TextAlign.center,
                textStyle: const TextStyle(color: AppColors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
