import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/single_video_widget.dart';
import 'package:pitchbook/components/slide_in_animation.dart';
import 'package:pitchbook/components/video_grid_title_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../components/youtube_player_screen.dart';

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
                  AppColors.black.withValues(alpha: 0.0),
                  AppColors.black.withValues(alpha: 0.3)
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
                padding: const EdgeInsets.fromLTRB(40, 80, 40, 40),
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
                                  type: 'h7',
                                  textStyle: const TextStyle(
                                      color: AppColors.secondary,
                                      fontWeight: FontWeight.w400),
                                  isUppercase: true,
                                ),
                              ),
                              SizedBox(height: size.height * 0.022),
                              SlideInAnimation(
                                direction: SlideDirection.right,
                                delay: const Duration(milliseconds: 100),
                                distance: 0.2,
                                visibilityThreshold: 1,
                                child: CustomText(
                                  label: widget.data['title'][widget.lang],
                                  type: 'h3',
                                  textStyle: const TextStyle(color: AppColors.white,fontWeight: FontWeight.w400),
                                  isSerif: true,
                                ),
                              ),
                              SizedBox(height: size.height * 0.015),
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
                                  type: 'h7',
                                ),
                              ),
                              SizedBox(height: size.height * 0.022),
                              SlideInAnimation(
                                direction: SlideDirection.right,
                                delay: const Duration(milliseconds: 300),
                                distance: 0.2,
                                visibilityThreshold: 1,
                                child: CustomText(
                                  label: widget.data['description']
                                      [widget.lang],
                                  textStyle: const TextStyle(color: AppColors.white,fontWeight: FontWeight.w400),
                                ),
                              ),
                            ],
                          ),
                        ),

                        //Play Video
                        Flexible(
                          flex: 5,
                          child: FadeInAnimation(
                            child: Center(
                              child: IconButton(
                                onPressed: () {
                                  _showDialog(context);
                                  // SingleVideoWidget(
                                  //   videoUrl: videoUrl,
                                  //   coverImage: coverImage,
                                  // ).showVideoDialog(context);
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
              SizedBox(height: size.height * 0.04),
              SlideInAnimation(
                direction: SlideDirection.right,
                delay: const Duration(milliseconds: 500),
                distance: 0.2,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 43),
                      child: CustomText(
                        label: widget.data['videosTitle'][widget.lang],
                        type: 'h5',
                        textStyle: const TextStyle(
                            color: AppColors.white,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    SizedBox(height: size.height * 0.021),
                    _goodKarmaData.isNotEmpty
                        ? VideoGridTitleWidget(
                            key: const ValueKey('moments'),
                            data: _goodKarmaData,
                            lang: widget.lang,
                            columns: 3,
                            gap: 20,
                            scrollGapX: 26,
                            useGrid: false,
                            gridRatio: 3 / 2,
                            initialItemCount: 9,
                            loadMoreCount: 9,
                            textAlign: Alignment.bottomCenter,
                            titleBoxPadding:
                                const EdgeInsets.fromLTRB(0, 15, 20, 15),
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

  void _showDialog(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    showDialog(
      barrierColor: AppColors.black.withValues(alpha: .8),
      context: context,
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Center(
              child: Stack(
                children: [
                Container(
                width: size.width,
                padding: const EdgeInsets.symmetric(horizontal: 0),
                child: SingleChildScrollView(
                  child: SizedBox(
                    width: size.width * 0.5,
                    child: Column(
                      children: [
                        // Header text
                        Container(
                          width: size.width,
                          alignment: Alignment.center,
                          child: CustomText(
                            label: widget.data['title'][widget.lang],
                            type: 'h5',
                            isSerif: true,
                            maxLines: 2,
                            textAlign: TextAlign.center,
                            textStyle: const TextStyle(color: AppColors.white),
                          ),
                        ),

                        SizedBox(height: size.height * 0.025),

                        // YouTube player
                        Center(
                          child: SizedBox(
                            width: size.width,
                            child: AspectRatio(
                              aspectRatio: 16 / 9,
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(10),
                                child: YoutubePlayerScreen(
                                  videoId: YoutubePlayer.convertUrlToId(
                                      widget.data["media"]['videoUrl']) ??
                                      YoutubePlayer.convertUrlToId("GqsFT52pcTc")!,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: size.height * 0.031),
                      ],
                    ),
                  ),
                ),
              ),


              Positioned(
                    top: 10,
                    right: 30,
                    child: IconButton(
                      icon: const Icon(
                        Icons.close,
                        color: AppColors.white,
                        size: 30,
                      ),
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }

}
