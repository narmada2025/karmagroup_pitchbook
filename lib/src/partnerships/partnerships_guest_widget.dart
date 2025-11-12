import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/masonry_image_grid.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class PartnershipsGuestWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String lang;

  const PartnershipsGuestWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  State<PartnershipsGuestWidget> createState() =>
      _PartnershipsGuestWidgetState();
}

class _PartnershipsGuestWidgetState extends State<PartnershipsGuestWidget> {
  int _currentGuests = 0;

  void _changeLogo(int index) {
    setState(() {
      _currentGuests = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    // print("partnershipScren============ ${widget.data['location'][_currentGuests]['celebrities']}");
    Size size = MediaQuery.of(context).size;

    return SizedBox(
      width: size.width,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FadeInAnimation(
            visibilityThreshold: 1,
            child: Container(
              width: size.width,
              padding: const EdgeInsets.fromLTRB(60, 80, 60, 0),
              child: CustomText(
                label: widget.data['title'][widget.lang],
                type: 'h2',
                textStyle: const TextStyle(color: AppColors.primary),
                textAlign: TextAlign.center,
                isSerif: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeInAnimation(
            visibilityThreshold: 0.8,
            child: Container(
              width: size.width,
              padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
              child: CustomText(
                label: widget.data['description'][widget.lang],
                textStyle: const TextStyle(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 60),
          SizedBox(
            width: size.width - 200,
            child: MasonryImageGrid(
              imageUrls: widget.data['location'][_currentGuests]['celebrities']
                  .map<String>((celebrity) => celebrity as String)
                  .toList(),
            ),
          ),
          const SizedBox(height: 150),
        ],
      ),
    );
  }
}
