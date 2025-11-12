import 'package:flutter/material.dart';
import 'package:pitchbook/components/video_player_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class VideoGridWidget extends StatefulWidget {
  final List<String> videoCovers;
  final List<String> videoUrls;
  final int columns;
  final double gap;
  final double scrollGapX;
  final double itemWidth;
  final Axis axis;
  final bool hasPopup;

  const VideoGridWidget({
    super.key,
    required this.videoCovers,
    required this.videoUrls,
    this.columns = 2,
    this.gap = 10,
    this.scrollGapX = 0,
    this.itemWidth = 300,
    this.axis = Axis.horizontal,
    this.hasPopup = false,
  });

  @override
  State<VideoGridWidget> createState() => _VideoGridWidgetState();
}

class _VideoGridWidgetState extends State<VideoGridWidget> {
  @override
  Widget build(BuildContext context) {
    if (widget.videoCovers.isEmpty) {
      return const Text('No data');
    }
    return SingleChildScrollView(
      scrollDirection: widget.axis,
      child: Wrap(
        spacing: widget.gap,
        direction: widget.axis,
        children: [
          SizedBox(
            width: widget.axis == Axis.horizontal ? widget.scrollGapX : 0,
          ),
          ...widget.videoCovers.asMap().entries.map(
                (entry) => GestureDetector(
                  onTap: () {
                    _showDialog(context, entry.value, entry.key);
                  },
                  child: Container(
                    alignment: Alignment.center,
                    clipBehavior: Clip.antiAlias,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    width: widget.itemWidth,
                    child: Stack(alignment: Alignment.center, children: [
                      Image.network('${AppAPI.baseUrlGcp}${entry.value}'),
                      const Icon(
                        Icons.play_circle_fill,
                        size: 40,
                        color: AppColors.white,
                      )
                    ]),
                  ),
                ),
              ),
          SizedBox(
            width: widget.axis == Axis.horizontal ? widget.scrollGapX : 0,
          ),
        ],
      ),
    );
  }

  void _showDialog(BuildContext context, String cover, int index) {
    Size size = MediaQuery.of(context).size;

    showDialog(
      barrierColor: AppColors.primary.withValues(alpha: 0.3),
      context: context,
      builder: (BuildContext context) {
        int currentIndex = index;

        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.fromLTRB(40, 20, 40, 20),
                    height: size.height,
                    alignment: Alignment.center,
                    child: VideoPlayerWidget(
                      videoUrls: widget.videoUrls,
                      currentIndex: currentIndex,
                      onIndexChanged: (index) {
                        setState(() {
                          currentIndex = index;
                        });
                      },
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    IconButton(
                      onPressed: () {
                        if (currentIndex > 0) {
                          setState(() {
                            currentIndex--;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.arrow_circle_left_rounded,
                        color: currentIndex > 0
                            ? AppColors.white
                            : AppColors.disabled,
                        size: 40,
                      ),
                    ),
                    Positioned(
                      bottom: 30,
                      child: CustomText(
                        label:
                            '${currentIndex + 1} of ${widget.videoUrls.length}',
                        textStyle: const TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    IconButton(
                      onPressed: () {
                        if (currentIndex < widget.videoUrls.length - 1) {
                          setState(() {
                            currentIndex++;
                          });
                        }
                      },
                      icon: Icon(
                        Icons.arrow_circle_right_rounded,
                        color: currentIndex != (widget.videoUrls.length - 1)
                            ? AppColors.white
                            : AppColors.disabled,
                        size: 40,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                )
              ],
            );
          },
        );
      },
    );
  }
}
