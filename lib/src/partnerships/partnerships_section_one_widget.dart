import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/src/app_locatizations.dart';

class PartnershipsSectionOneWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String lang;

  const PartnershipsSectionOneWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  State<PartnershipsSectionOneWidget> createState() =>
      _PartnershipsSectionOneWidgetState();
}

class _PartnershipsSectionOneWidgetState
    extends State<PartnershipsSectionOneWidget> {
  int _index = 0;
  int _currentSlide = 0;

  final PageController _pageController = PageController(viewportFraction: 0.85);

  @override
  void initState() {
    super.initState();
    _index = (widget.data['carousel'].length / 2) > 3
        ? 3
        : (widget.data['carousel'].length / 2).toInt();
  }

  void _changeLogo(int index) {
    setState(() {
      _index = index;
      _currentSlide = 0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      constraints: BoxConstraints(minWidth: size.width, minHeight: size.height),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          FadeInAnimation(
            visibilityThreshold: 1,
            delay: const Duration(milliseconds: 700),
            child: Container(
              width: size.width / 1.8,
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
            delay: const Duration(milliseconds: 800),
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
          FadeInAnimation(
            visibilityThreshold: 1,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                  direction: Axis.horizontal,
                  spacing: 60,
                  crossAxisAlignment: WrapCrossAlignment.center,
                  children: [
                    ...widget.data['carousel'] != null
                        ? widget.data['carousel']
                            .asMap()
                            .entries
                            .map<Widget>((entry) {
                            return InkWell(
                              splashColor: Colors.transparent,
                              onTap: () => _changeLogo(entry.key),
                              child: AnimatedContainer(
                                duration: const Duration(milliseconds: 300),
                                height: _index == entry.key ? 100 : 90,
                                child: Opacity(
                                  opacity: _index == entry.key ? 1 : 0.5,
                                  child: Image.network(
                                    '${AppAPI.baseUrlGcp}${entry.value['image']}',
                                  ),
                                ),
                              ),
                            );
                          }).toList()
                        : [
                            NoData(
                                title: tr(
                                    context,
                                    'errors.Content not available',
                                    widget.lang))
                          ],
                  ]),
            ),
          ),
          widget.data['carousel'][_index]['slides'].length != 0
              ? FadeInAnimation(
                  visibilityThreshold: 0.4,
                  child: Container(
                    height: 580,
                    color: AppColors.black,
                    padding: const EdgeInsets.fromLTRB(0, 50, 0, 50),
                    alignment: Alignment.topCenter,
                    child: Stack(
                      alignment: Alignment.topCenter,
                      children: [
                        PageView.builder(
                          controller: _pageController,
                          onPageChanged: (index) {
                            setState(() {
                              _currentSlide = index;
                            });
                          },
                          itemCount:
                              widget.data['carousel'][_index]['slides'].length,
                          itemBuilder: (context, index) {
                            return Container(
                              margin: const EdgeInsets.only(right: 20),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              clipBehavior: Clip.antiAlias,
                              child: Stack(
                                alignment: Alignment.bottomCenter,
                                children: [
                                  Image.network(
                                    '${AppAPI.baseUrlGcp}${widget.data['carousel'][_index]['slides']
                                    [index]['image']!}',
                                    height: double.infinity,
                                    fit: BoxFit.fill,
                                  ),
                                  const SizedBox(height: 30),
                                  ClipRRect(
                                    child: BackdropFilter(
                                      filter: ImageFilter.blur(
                                          sigmaX: 5.0, sigmaY: 5.0),
                                      child: Container(
                                        padding: const EdgeInsets.fromLTRB(
                                            80, 30, 80, 70),
                                        color: AppColors.black
                                            .withValues(alpha: .6),
                                        child: Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            CustomText(
                                              label: widget.data['carousel']
                                                      [_index]['slides'][index]
                                                  ['title']![widget.lang],
                                              type: 'h6',
                                              textStyle: const TextStyle(
                                                  color: AppColors.white),
                                              textAlign: TextAlign.center,
                                            ),
                                            const SizedBox(
                                              height: 10,
                                            ),
                                            CustomText(
                                              label: widget.data['carousel']
                                                      [_index]['slides'][index]
                                                  ['description']![widget.lang],
                                              textStyle: const TextStyle(
                                                  color: AppColors.white),
                                              textAlign: TextAlign.center,
                                              overflow: TextOverflow.visible,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                ],
                              ),
                            );
                          },
                        ),
                        if (widget.data['carousel'][_index]['slides'].length >
                            1)
                          Positioned(
                            bottom: 20,
                            left: 0,
                            right: 0,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                  widget.data['carousel'][_index]['slides']
                                      .length, (index) {
                                return Container(
                                  width: 10,
                                  height: 10,
                                  margin: const EdgeInsets.all(5),
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: _currentSlide == index
                                        ? AppColors.primary
                                        : AppColors.white,
                                  ),
                                );
                              }),
                            ),
                          )
                      ],
                    ),
                  ),
                )
              : NoData(
                  title:
                      tr(context, 'errors.Content not available', widget.lang)),
        ],
      ),
    );
  }
}
