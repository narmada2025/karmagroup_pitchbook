import 'dart:math';

import 'package:flutter/material.dart';
import 'package:pitchbook/components/custom_video_player.dart';
import 'package:pitchbook/components/video_item_widget.dart';
import 'package:pitchbook/components/youtube_player_screen.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_btn.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../src/destinations/videos_fullscreen_view_widget.dart';


class VideoGridTitleWidget extends StatefulWidget {
  final List<dynamic> data;
  final int columns;
  final double gap;
  final double scrollGapX;
  final double itemWidth;
  final Axis axis;
  final bool hasPopup;
  final bool useGrid;
  final double gridRatio;
  final Alignment textAlign;
  final String? lang;
  final Widget? thumbIcon;
  final BoxDecoration? boxOverlay;
  final BoxDecoration? titleBoxDecoration;
  final EdgeInsetsGeometry? titleBoxPadding;

  final int initialItemCount;
  final int loadMoreCount;
  final bool isYoutube;
  final bool isUrl;

  const VideoGridTitleWidget({
    super.key,
    required this.data,
    this.columns = 2,
    this.gap = 10,
    this.scrollGapX = 0,
    this.itemWidth = 300,
    this.axis = Axis.horizontal,
    this.hasPopup = false,
    this.useGrid = false,
    this.gridRatio = 3 / 1.7,
    this.textAlign = Alignment.bottomLeft,
    this.thumbIcon,
    this.lang,
    this.boxOverlay,
    this.titleBoxDecoration,
    this.titleBoxPadding,
    this.initialItemCount = 10,
    this.loadMoreCount = 10,
    this.isYoutube = false,
    this.isUrl = false,
  });

  @override
  State<VideoGridTitleWidget> createState() => _VideoGridTitleWidgetState();
}

class _VideoGridTitleWidgetState extends State<VideoGridTitleWidget> {
  List<String> _videoUrls = [];
  List<String> _videoTitles = [];
  List<String> _videoCovers = [];
  int _itemCount = 0;

  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    extractVideoUrls();
    _itemCount = min(widget.initialItemCount, _videoUrls.length);
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    if (_scrollController.offset >=
            _scrollController.position.maxScrollExtent &&
        !_scrollController.position.outOfRange &&
        _itemCount < _videoUrls.length) {
      setState(() {
        _itemCount = min(_itemCount + widget.loadMoreCount, _videoUrls.length);
      });
    }
  }

  void extractVideoUrls() {
    setState(() {
      _videoUrls = widget.data.map<String>((video) => video['video'].toString()).toList();
      _videoCovers =
          widget.data.map<String>((video) => video['cover'].toString()).toList();
      _videoTitles = widget.data.map<String>((video) {
        if (video['title'] is Map) {
          return video['title'][widget.lang] ?? video['title'].values.first;
        } else {
          return video['title'].toString();
        }
      }).toList();
      _itemCount = widget.initialItemCount;
    });
  }

  void _loadMoreItems() {
    setState(() {
      _itemCount += widget.loadMoreCount;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (widget.data.isEmpty) {
      return const Text('No data');
    }
    return widget.useGrid
        ? Column(
            children: [
              GridView.count(
                controller: _scrollController,
                crossAxisCount: widget.columns,
                childAspectRatio: widget.gridRatio,
                mainAxisSpacing: widget.gap,
                crossAxisSpacing: widget.gap,
                shrinkWrap: true,
                children: [
                  ..._videoUrls.sublist(0, _itemCount).asMap().entries.map(
                    (entry) {
                      final videoIndex = entry.key;
                      final videoUrl = entry.value;
                      final videoCover = _videoCovers[videoIndex];
                      final videoTitle = _videoTitles[videoIndex];

                      final videoData = {
                        'video': videoUrl,
                        'title': videoTitle,
                        'cover': videoCover,
                      };
                      return GestureDetector(
                        onTap: () {
                          widget.isYoutube?
                          _showDialog(context, entry.key)
                          :
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>VideoFullScreenView(videoUrl:entry.value, index: videoIndex, data: widget.data, initialItemCount: widget.initialItemCount, isYoutube: widget.isYoutube,isUrl: widget.isUrl),
                            ),
                          );
                        },
                        child: VideoItemWidget(
                          videoData: videoData,
                          itemWidth: widget.itemWidth,
                          textAlign: widget.textAlign,
                          icon: widget.thumbIcon,
                          boxOverlay: widget.boxOverlay,
                          titleBoxDecoration: widget.titleBoxDecoration,
                          titleBoxPadding: widget.titleBoxPadding,
                        ),
                      );
                    },
                  ),
                ],
              ),
              if (_itemCount < _videoUrls.length)
                CustomBtn(
                  onPressed: _loadMoreItems,
                  label: 'Load More...',
                  btnType: BtnType.primary,
                  borderRadius: 50,
                )
            ],
          )
        : SingleChildScrollView(
            controller: _scrollController,
            scrollDirection: widget.axis,
            child: Wrap(
              spacing: widget.gap,
              direction: widget.axis,
              children: [
                SizedBox(
                  width: widget.axis == Axis.horizontal ? widget.scrollGapX : 0,
                ),
                ..._videoUrls.sublist(0, _itemCount).asMap().entries.map(
                  (entry) {
                    final videoIndex = entry.key;
                    final videoUrl = entry.value;
                    final videoCover = _videoCovers[videoIndex];
                    final videoTitle = _videoTitles[videoIndex];

                    final videoData = {
                      'video': videoUrl,
                      'title': videoTitle,
                      'cover': videoCover,
                    };
                    return GestureDetector(
                      onTap: () {
                        widget.isYoutube?
                        _showDialog(context, entry.key)
                       : Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>VideoFullScreenView(videoUrl:entry.value, index: videoIndex, data: widget.data, initialItemCount: widget.initialItemCount, isYoutube: widget.isYoutube,isUrl: widget.isUrl),
                          ),
                        );
                      },
                      child: VideoItemWidget(
                        videoData: videoData,
                        itemWidth: widget.itemWidth,
                        textAlign: widget.textAlign,
                        icon: widget.thumbIcon,
                        boxOverlay: widget.boxOverlay,
                        titleBoxDecoration: widget.titleBoxDecoration,
                        titleBoxPadding: widget.titleBoxPadding,
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: widget.axis == Axis.horizontal ? widget.scrollGapX : 0,
                ),
              ],
            ),
          );
  }

  void _showDialog(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;

    showDialog(
      barrierColor: AppColors.black.withValues(alpha: .8),
      context: context,
      builder: (BuildContext context) {
        int currentIndex = index;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter setState) {
            return Stack(
              children: [
                Center(
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: [
                          Flexible(
                            flex: 1,
                            child: IconButton(
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
                          ),
                        SizedBox(
                          width: size.width * 0.88,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(
                                height: 20,
                              ),
                              Container(
                                width: size.width * 0.6,
                                alignment: Alignment.center,
                                child: CustomText(
                                  label: _videoTitles[currentIndex],
                                  type: 'h5',
                                  isSerif: true,
                                  maxLines: 2,
                                  textAlign: TextAlign.center,
                                  textStyle:
                                      const TextStyle(color: AppColors.white),
                                ),
                              ),

                              //display Video player
                              Expanded(
                                child: Container(
                                  // padding:
                                  //     const EdgeInsets.fromLTRB(40, 20, 40, 20),
                                  height: size.height,
                                  alignment: Alignment.center,
                                  child: widget.isYoutube
                                      ? YoutubePlayerScreen(
                                          videoId: widget.isUrl
                                              ? YoutubePlayer.convertUrlToId(
                                                  _videoUrls[currentIndex])!
                                              : _videoUrls[currentIndex],
                                    // isUrl: false,
                                        )
                                      : CustomVideoPlayer(
                                          videoUrl: _videoUrls[currentIndex],
                                        ),
                                ),
                              ),

                              CustomText(
                                label:
                                    '${currentIndex + 1} of ${_videoUrls.length}',
                                textStyle: const TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                              SizedBox(height: size.height * 0.021),
                            ],
                          ),
                        ),
                        Flexible(
                          flex: 1,
                          child: IconButton(
                            onPressed: () {
                              if (currentIndex < _videoUrls.length - 1) {
                                setState(() {
                                  currentIndex++;
                                });
                              }
                            },
                            icon: Icon(
                              Icons.arrow_circle_right_rounded,
                              color: currentIndex != (_videoUrls.length - 1)
                                  ? AppColors.white
                                  : AppColors.disabled,
                              size: 40,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 30,
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
            );
          },
        );
      },
    );
  }
}
