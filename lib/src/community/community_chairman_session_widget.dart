import 'package:flutter/material.dart';
import 'package:pitchbook/components/image_network_widget.dart';
import 'package:pitchbook/components/youtube_player_screen.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class CommunityChairmanSessionWidget extends StatefulWidget {
  final Map<String, dynamic> chairmanSession;

  const CommunityChairmanSessionWidget(
      {super.key, required this.chairmanSession});

  @override
  State<CommunityChairmanSessionWidget> createState() =>
      _CommunityChairmanSessionWidgetState();
}

class _CommunityChairmanSessionWidgetState
    extends State<CommunityChairmanSessionWidget> {
  int _selectedSession = 0;

  void setCurrentSession(int index) {
    setState(() {
      _selectedSession = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String thumbnail = '';
    String title = '';
    String subTitle = '';
    String videoUrl = '';

    if (widget.chairmanSession['chairman_categories'] != null &&
        _selectedSession <
            widget.chairmanSession['chairman_categories'].length) {
      thumbnail = widget.chairmanSession['chairman_categories']
          [_selectedSession]['thumbnail'];
      title = widget.chairmanSession['chairman_categories'][_selectedSession]
          ['title'];
      videoUrl = widget.chairmanSession['chairman_categories'][_selectedSession]
          ['video_content'];
      subTitle = 'Chairman Session';
    }
    return Container(
      width: size.width,
      padding: const EdgeInsets.all(60),
      child: Stack(
        children: [
          ImageNetworkWidget(
            decoration: BoxDecoration(
              color: AppColors.gray,
              borderRadius: BorderRadius.circular(6),
            ),
            imageUrl: thumbnail,
            width: size.width,
            height: 600,
          ),
          Container(
            width: size.width,
            height: 600,
            color: AppColors.black.withValues(alpha: .5),
          ),
          Positioned(
            left: 30,
            bottom: 40,
            child: SizedBox(
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CustomText(
                    label: subTitle,
                    type: 'md',
                    textStyle: const TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500),
                    isUppercase: true,
                  ),
                  const SizedBox(height: 10),
                  CustomText(
                    label: title.replaceAll("&amp;", "&"),
                    type: 'h1',
                    textStyle: const TextStyle(color: AppColors.white),
                    isSerif: true,
                  ),
                ],
              ),
            ),
          ),
          if (thumbnail != '')
            Positioned(
              top: 200,
              left: 0,
              right: 0,
              child: IconButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        color: AppColors.primary.withValues(alpha: .3),
                        width: size.width - 80,
                        padding: const EdgeInsets.fromLTRB(40, 40, 40, 40),
                        child: Stack(
                          alignment: Alignment.center,
                          children: [
                            Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CustomText(
                                  label: title.replaceAll("&amp;", "&"),
                                  type: 'h4',
                                  textStyle:
                                      const TextStyle(color: AppColors.white),
                                  isSerif: true,
                                ),
                                const SizedBox(height: 20),
                                Container(
                                  alignment: Alignment.center,
                                  width: size.width - 200,
                                  height: size.height - 220,
                                  decoration: BoxDecoration(
                                    color: AppColors.gray,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: YoutubePlayerScreen(
                                      videoId: YoutubePlayer.convertUrlToId(
                                          videoUrl)!,
                                      isUrl: true,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Positioned(
                              top: 0,
                              right: 20,
                              child: IconButton(
                                icon: const Icon(
                                  Icons.close,
                                  color: AppColors.primary,
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
                icon: const Icon(
                  Icons.play_circle_fill_outlined,
                  color: AppColors.white,
                  size: 80,
                ),
              ),
            )
        ],
      ),
    );
  }
}
