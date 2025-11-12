import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';

class LoadingComponent extends StatelessWidget {
  final String text;
  final Axis direction;
  final Alignment alignment;
  final double? width;
  final double? height;
  final double padding;
  final double margin;
  final BoxDecoration? decoration;
  final TextStyle? textStyle;
  final TextAlign? textAlign;

  const LoadingComponent({
    super.key,
    this.text = 'Loading...',
    this.direction = Axis.vertical,
    this.alignment = Alignment.center,
    this.width,
    this.height,
    this.padding = 40,
    this.margin = 0,
    this.decoration,
    this.textStyle,
    this.textAlign,
  });

  @override
  Widget build(BuildContext context) {
    const image = 'assets/images/Karma Group.png';
    return Center(
      child: Container(
        padding: EdgeInsets.all(padding),
        margin: EdgeInsets.all(margin),
        decoration: decoration,
        width: width,
        height: height,
        alignment: alignment,
        child: Wrap(
          direction: direction,
          crossAxisAlignment: WrapCrossAlignment.center,
          spacing: 16,
          children: [
            Image.asset(
              image,
              width: 200,
            ),
            const CircularProgressIndicator(
              strokeWidth: 4,
              backgroundColor: AppColors.light,
              valueColor: AlwaysStoppedAnimation(AppColors.primary),
            ),
            Text(
              text,
              textAlign: textAlign,
              style: const TextStyle(fontSize: 14, color: Colors.white)
                  .merge(textStyle),
            ),
          ],
        ),
      ),
    );
  }
}
