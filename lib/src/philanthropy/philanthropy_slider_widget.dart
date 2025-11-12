import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class PhilanthropySliderWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String lang;

  const PhilanthropySliderWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  State<PhilanthropySliderWidget> createState() =>
      _PhilanthropySliderWidgetState();
}

class _PhilanthropySliderWidgetState extends State<PhilanthropySliderWidget> {
  int _currentPage = 0;
  final PageController _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.fromLTRB(0, 50, 0, 100),
      child: Column(
        children: [
          SizedBox(
            width: size.width,
            height: 700,
            child: PageView.builder(
              controller: _pageController,
              onPageChanged: (index) {
                setState(() {
                  _currentPage = index;
                });
              },
              itemCount: widget.data['carousel'].length,
              itemBuilder: (context, index) {
                return FadeInAnimation(
                  visibilityThreshold: 0.3,
                  initOpacity: index != 0 ? 1 : 0,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Image.network(
                        width: size.width,
                        height: size.height * 0.5,
                        '${AppAPI.baseUrlGcp}${widget.data['carousel'][index]['image']!}',
                        fit: BoxFit.cover,
                      ),
                      const SizedBox(height: 30),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: CustomText(
                          label: widget.data['carousel'][index]
                              ['title']![widget.lang],
                          type: 'h3',
                          textStyle: const TextStyle(color: AppColors.white),
                          isSerif: true,
                          textAlign: TextAlign.center,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 80),
                        child: CustomText(
                          label: widget.data['carousel'][index]
                              ['description']![widget.lang],
                          textStyle: const TextStyle(color: AppColors.white),
                          textAlign: TextAlign.center,
                          overflow: TextOverflow.visible,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(widget.data['carousel'].length, (index) {
              return Container(
                width: 10,
                height: 10,
                margin: const EdgeInsets.all(5),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _currentPage == index
                      ? AppColors.primary
                      : AppColors.primary.withValues(alpha: 0.4),
                ),
              );
            }),
          ),
        ],
      ),
    );
  }
}
