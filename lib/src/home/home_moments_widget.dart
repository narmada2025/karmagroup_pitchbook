import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/single_video_widget.dart';
import 'package:pitchbook/components/slide_in_animation.dart';
import 'package:pitchbook/components/video_grid_title_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/helpers/helper.dart';

class HomeMomentsWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String lang;

  const HomeMomentsWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  State<HomeMomentsWidget> createState() => _HomeMomentsWidgetState();
}

class _HomeMomentsWidgetState extends State<HomeMomentsWidget> {
  List<dynamic> _goodKarmaData = [];

  Future<void> _loadJsonData() async {
    final data = await loadJsonFromAssets(AppAPI.moments);
    setState(() {
      _goodKarmaData = data['videos'];
      log("====_goodKarmaData  $_goodKarmaData");
    });
  }

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    String videoUrl = widget.data["media"]['videoUrl'];
    String coverImage = widget.data["media"]['coverImage'];

    return Container(
      width: size.width,
      height: size.height,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.black),
      ),
      child: Stack(
        children: [
          FadeInAnimation(
            child: SingleVideoWidget(
              videoUrl: videoUrl,
              coverImage: coverImage,
              showIcon: false,
            ),
          ),
          Container(
            width: size.width,
            height: size.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: [
                  AppColors.black.withValues(alpha: 0.9),
                  AppColors.black.withValues(alpha: 0.4)
                ],
                begin: Alignment.centerLeft,
                end: Alignment.centerRight,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.fromLTRB(80, 80, 80, 40),
                child: Column(
                  children: [
                    Row(
                      children: [
                        Flexible(
                          flex: 7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SlideInAnimation(
                                direction: SlideDirection.right,
                                distance: 0.2,
                                visibilityThreshold: 1,
                                child: CustomText(
                                  label: widget.data['subTitle'][widget.lang],
                                  type: 'h6',
                                  textStyle: const TextStyle(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.w500),
                                  isUppercase: true,
                                ),
                              ),
                              const SizedBox(height: 20),
                              SlideInAnimation(
                                direction: SlideDirection.right,
                                delay: const Duration(milliseconds: 100),
                                distance: 0.2,
                                visibilityThreshold: 1,
                                child: CustomText(
                                  label: widget.data['title'][widget.lang],
                                  type: 'h2',
                                  textStyle:
                                      const TextStyle(color: AppColors.white),
                                  isSerif: true,
                                ),
                              ),
                              const SizedBox(height: 15),
                              SlideInAnimation(
                                direction: SlideDirection.right,
                                delay: const Duration(milliseconds: 200),
                                distance: 0.2,
                                visibilityThreshold: 1,
                                child: CustomText(
                                  label: widget.data['hashtag'][widget.lang],
                                  textStyle: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600),
                                  type: 'h6',
                                ),
                              ),
                              const SizedBox(height: 20),
                              SlideInAnimation(
                                direction: SlideDirection.right,
                                delay: const Duration(milliseconds: 300),
                                distance: 0.2,
                                visibilityThreshold: 1,
                                child: CustomText(
                                  label: widget.data['description']
                                      [widget.lang],
                                  textStyle:
                                      const TextStyle(color: AppColors.white),
                                ),
                              ),
                              // const SizedBox(height: 20),
                              // SlideInAnimation(
                              //   direction: SlideDirection.right,
                              //   delay: const Duration(milliseconds: 400),
                              //   distance: 0.2,
                              //   visibilityThreshold: 1,
                              //   child: SizedBox(
                              //     width: 200,
                              //     child: Row(
                              //       children: [
                              //         SvgPicture.asset(
                              //           AppIcons.calendarIcon,
                              //           width: 30,
                              //           fit: BoxFit.contain,
                              //           semanticsLabel: 'calendar',
                              //           placeholderBuilder: (context) =>
                              //               const CircularProgressIndicator(),
                              //         ),
                              //         const SizedBox(width: 16),
                              //         CustomText(
                              //           label: widget.data['date'][widget.lang],
                              //           textStyle: const TextStyle(
                              //               color: AppColors.secondary),
                              //         ),
                              //       ],
                              //     ),
                              //   ),
                              // ),
                            ],
                          ),
                        ),

                        //Play Video
                        Flexible(
                          flex: 3,
                          child: FadeInAnimation(
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  SingleVideoWidget(
                                    videoUrl: videoUrl,
                                    coverImage: coverImage,
                                  ).showVideoDialog(context);
                                },
                                icon: const Icon(
                                  Icons.play_circle_fill_outlined,
                                  color: AppColors.white,
                                  size: 80,
                                ),
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              ),
              SlideInAnimation(
                direction: SlideDirection.right,
                delay: const Duration(milliseconds: 500),
                distance: 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 70),
                      child: CustomText(
                        label: widget.data['videosTitle'][widget.lang],
                        type: 'h5',
                        textStyle: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    const SizedBox(height: 20),
                    _goodKarmaData.isNotEmpty
                        ? VideoGridTitleWidget(
                            key: const ValueKey('moments'),
                            data: _goodKarmaData,
                            lang: widget.lang,
                            columns: 3,
                            gap: 20,
                            scrollGapX: 55,
                            useGrid: false,
                            gridRatio: 3 / 2,
                            initialItemCount: 9,
                            loadMoreCount: 9,
                            textAlign: Alignment.bottomCenter,
                            titleBoxPadding:
                                const EdgeInsets.fromLTRB(20, 15, 20, 15),
                            titleBoxDecoration: const BoxDecoration(
                              color: Color.fromARGB(71, 0, 0, 0),
                            ),
                          )
                        : const NoData(title: 'No data found...'),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
