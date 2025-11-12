import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pitchbook/components/gallery_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/go_back.dart';

class DestinationsGuestExpWidget extends StatefulWidget {
  final Map<String, dynamic> args;

  const DestinationsGuestExpWidget(
    this.args, {
    super.key,
  });

  @override
  State<DestinationsGuestExpWidget> createState() =>
      _DestinationsGuestExpWidgetState();
}

class _DestinationsGuestExpWidgetState
    extends State<DestinationsGuestExpWidget> {
  int _selectedGuestIndex = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    List<Map<String, dynamic>> getData() {
      List<Map<String, dynamic>> slideData = [];
      for (var asset in widget.args['assets']) {
        slideData.add({
          'title': asset['title'],
          'description': asset['description'],
          'image': asset['image'],
        });
      }
      return slideData;
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          getData().isNotEmpty
              ? GalleryWidget<Map<String, dynamic>>(
                  items: getData(),
                  onPageChanged: (int newIndex) {
                    setState(() {
                      _selectedGuestIndex = newIndex;
                    });
                  },
                  isSlider: true,
                  sliderDirection: Axis.vertical,
                  pageController: _pageController,
                  itemBuilder: (dynamic slideData) {
                    return Container(
                      width: size.width,
                      height: size.height,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${AppAPI.baseUrlGcp}${slideData['image']}'),
                          fit: BoxFit.cover,
                        ),
                      ),
                      child: Stack(
                        children: [
                          Positioned(
                            bottom: 0,
                            left: 0,
                            right: 0,
                            child: ClipRRect(
                              child: BackdropFilter(
                                filter:
                                    ImageFilter.blur(sigmaX: 10, sigmaY: 10),
                                child: Container(
                                  margin: const EdgeInsets.only(left: 60),
                                  padding: const EdgeInsets.fromLTRB(
                                      120, 30, 120, 80),
                                  color: AppColors.black.withValues(alpha: .4),
                                  child: Column(children: [
                                    CustomText(
                                      label: slideData['title'],
                                      type: 'h2',
                                      isSerif: true,
                                      textStyle: const TextStyle(
                                          color: AppColors.white),
                                    ),
                                    const SizedBox(height: 20),
                                    CustomText(
                                      label: slideData['description'],
                                      type: 'sm',
                                      textAlign: TextAlign.center,
                                      textStyle: const TextStyle(
                                          color: AppColors.white),
                                    ),
                                  ]),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const Center(
                  child: CustomText(
                    label: 'No images available..',
                    type: 'h6',
                    textStyle: TextStyle(color: AppColors.white),
                  ),
                ),
          const GoBack(),
          Positioned(
            top: MediaQuery.of(context).padding.top,
            left: 0,
            child: ClipRRect(
              child: BackdropFilter(
                filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
                child: Container(
                  alignment: Alignment.center,
                  width: 64,
                  height: size.height,
                  color: AppColors.black.withValues(alpha: 0.8),
                  child: Wrap(
                    alignment: WrapAlignment.end,
                    children: [
                      for (int i = 0; i < widget.args['assets'].length; i++)
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedGuestIndex = i;
                            });
                            _pageController.animateToPage(
                              i,
                              duration: const Duration(milliseconds: 500),
                              curve: Curves.ease,
                            );
                          },
                          child: Container(
                            width: double.infinity,
                            padding: const EdgeInsets.fromLTRB(11, 4, 11, 4),
                            decoration: BoxDecoration(
                              border: BorderDirectional(
                                  end: BorderSide(
                                color: _selectedGuestIndex == i
                                    ? AppColors.secondary
                                    : Colors.transparent,
                                width: 4,
                              )),
                            ),
                            child: CustomText(
                              label: (i + 1).toString().padLeft(2, '0'),
                              type: 'h4',
                              isSerif: true,
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: _selectedGuestIndex == i
                                    ? AppColors.white
                                    : AppColors.secondary
                                        .withValues(alpha: 0.8),
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
