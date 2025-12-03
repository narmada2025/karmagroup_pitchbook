import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:pitchbook/components/image_network_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class EventCardWidget extends StatelessWidget {
  final String image;
  final String title;
  final String date;
  final String month;
  final double width;
  final double height;
  final double radius;
  final String? isSold;
  final String location;
  final VoidCallback onTap;
  final String? isLastSpot;

  const EventCardWidget({
    super.key,
    required this.image,
    required this.title,
    required this.date,
    required this.month,
    required this.width,
    this.height = 350,
    this.radius = 10,
    required this.onTap,
    required this.location,
    required this.isSold,
    required this.isLastSpot,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      splashColor: Colors.transparent,
      onTap: onTap,
      child: Container(
        height: height,
        clipBehavior: Clip.antiAlias,
        decoration: BoxDecoration(
          color: AppColors.gray,
          borderRadius: BorderRadius.circular(10),
        ),
        width: width,
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            ImageNetworkWidget(
              imageUrl: image,
              height: height,
              fit: BoxFit.fitHeight,
            ),
            Positioned(
              top: 0,
              child: Transform.translate(
                offset: const Offset(0, 0),
                child: SvgPicture.asset(
                  AppIcons.notch,
                  height: 20,
                  fit: BoxFit.contain,
                  semanticsLabel: 'notch',
                ),
              ),
            ),
            if (isSold != null && isSold == '1')
              Container(
                width: double.infinity,
                height: height,
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 30),
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      AppColors.black.withValues(alpha: 0.5),
                      AppColors.black.withValues(alpha: 0.5)
                    ],
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    stops: const [0.2, 1.0],
                  ),
                ),
                child: SizedBox(
                    width: 80, child: Image.network('${AppAPI.baseUrlGcp}${AppIcons.sold.toString()}')),
              ),
            Container(
              width: double.infinity,
              height: height,
              padding: const EdgeInsets.all(30),
              alignment: Alignment.bottomLeft,
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
              child: Wrap(
                runSpacing: 10,
                children: [
                  Wrap(
                    direction: Axis.horizontal,
                    spacing: 6,
                    crossAxisAlignment: WrapCrossAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on_rounded,
                        color: Colors.white,
                        size: 16,
                      ),
                      CustomText(
                        label: location,
                        type: 'xs',
                        isUppercase: true,
                        textStyle: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w400,
                            height: 1.2),
                      ),
                    ],
                  ),
                  CustomText(
                    label: title,
                    maxLines: 2,
                    isUppercase: true,
                    textStyle: const TextStyle(
                        color: AppColors.white,
                        fontWeight: FontWeight.w700,
                        height: 1.2),
                  ),
                ],
              ),
            ),
            if (isLastSpot != null && isLastSpot == '1' && isSold == '0')
            Positioned(
              top: 0,
              left: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 10, 10, 14),
                child: Wrap(
                  direction: Axis.horizontal,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  children: [
                    Image.asset("assets/images/lastspot.png",height: 17),
                    const CustomText(
                      label: 'Last Spots',
                      type: 'xs',
                      isUppercase: true,
                      textStyle: TextStyle(
                          color: AppColors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(
              top: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 14),
                color: AppColors.black.withValues(alpha: 0.5),
                child: Wrap(
                  direction: Axis.vertical,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  spacing: 6,
                  children: [
                    CustomText(
                      label: date,
                      type: 'h3',
                      isSerif: true,
                      textStyle: const TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                    CustomText(
                      label: month.substring(0, 3),
                      type: 'sm',
                      isUppercase: true,
                      textStyle: const TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
