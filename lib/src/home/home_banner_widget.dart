import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/fade_in_scale_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

import '../../constants/loading_component.dart';

class HomeBannerWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String lang;

  const HomeBannerWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  State<HomeBannerWidget> createState() => _HomeBannerWidgetState();
}

class _HomeBannerWidgetState extends State<HomeBannerWidget>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _controller;
  late AnimationController _contentController;
  late Animation<double> _fadeAnimation;
  bool _isMuted = false;
  bool _isPlaying = true;
  bool _isDisplayPlayIcons = false;
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoController('${widget.data['video']}');
    print("widget.data['video'] ${widget.data['video']}");
  }

  void _onVideoPlayerStateChanged() {
    if (_controller.value.isInitialized) {
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    }
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoPlayerStateChanged);
    _controller.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _initializeVideoController(String url) {
    _controller = VideoPlayerController.networkUrl(Uri.parse('${AppAPI.baseUrlGcp}$url'));
    _controller.initialize().then((_) {
      setState(() {
        _isPlaying = true;
        _controller.play();
      });
    });
    _controller.addListener(_onVideoPlayerStateChanged);
    _controller.setLooping(true);
    _controller.setVolume(0);

    _contentController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(_contentController);
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        _contentController.forward();
      }
    });
  }

  void toggleFullScreen(BuildContext context) {
    setState(() {
      isFullScreen = !isFullScreen;
    });

    if (isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
      _showDialog(context);
    } else {
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      // SystemChrome.setPreferredOrientations([
      //   DeviceOrientation.portraitUp,
      //   DeviceOrientation.portraitDown,
      // ]);
  Navigator.pop(context);
    }
  }

  void _handleTap() {
    setState(() {
      _isDisplayPlayIcons = true;
    });
  }

  @override
  Widget build(BuildContext context) {
    return buildBodyWidget();
  }

  Widget buildBodyWidget() {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.black),
      ),
      child:
      Stack(
        children: [
          VisibilityDetector(
            key: const Key('home_video'),
            onVisibilityChanged: (VisibilityInfo info) {
              final visiblePercentage = info.visibleFraction * 100;

              if (visiblePercentage > 0) {
                if (mounted && !_controller.value.isPlaying) {
                  _controller.play();
                }
              } else {
                if (mounted && _controller.value.isPlaying) {
                  _controller.pause();
                }
              }
            },
            child:
            GestureDetector(
              onDoubleTap: () {
                toggleFullScreen(context);
              },
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child:_controller.value.isInitialized ?
                VideoPlayer(_controller): Container(),
              ),
            ) ,
          ),
          _isDisplayPlayIcons
              ? Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 50),
              height: size.height * 0.042,
              decoration: const BoxDecoration(
                color: Color.fromARGB(200, 0, 0, 0)
              ),
              child: Row(
                children: [
                  ValueListenableBuilder(
                    valueListenable: _controller,
                    builder: (context, VideoPlayerValue value, child) {
                      final hours = value.position.inHours
                          .toString()
                          .padLeft(2, '0');
                      final minutes = (value.position.inMinutes % 60)
                          .toString()
                          .padLeft(2, '0');
                      final seconds = value.position.inSeconds
                          .remainder(60)
                          .toString()
                          .padLeft(2, '0');
                      return Text(
                        '$hours:$minutes:$seconds',
                        style: const TextStyle(color: Colors.white),
                      );
                    },
                  ),
                  IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause : Icons.play_arrow,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        if (_controller.value.isPlaying) {
                          _controller.pause();
                        } else {
                          _controller.play();
                        }
                      });
                    },
                  ),
                  Expanded(
                    child: Center(
                      child: Transform.translate(
                        offset: const Offset(0, -10),
                        child: VideoProgressIndicator(
                          _controller,
                          padding: const EdgeInsets.only(top: 20),
                          allowScrubbing: true,
                          colors: const VideoProgressColors(
                            playedColor: AppColors.primary,
                            bufferedColor: AppColors.light,
                            backgroundColor: Color.fromARGB(255, 255, 255, 255),
                          ),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isMuted ? Icons.volume_off : Icons.volume_up,
                      color: Colors.white,
                    ),
                    onPressed: () {
                      setState(() {
                        _isMuted = !_isMuted;
                        _controller.setVolume(_isMuted ? 0 : 1);
                      });
                    },
                  ),
                  Text(
                    '${_controller.value.duration.inHours.toString().padLeft(2, '0')}:${(_controller.value.duration.inMinutes % 60).toString().padLeft(2, '0')}:${_controller.value.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
                    style: const TextStyle(color: Colors.white),
                  ),
                  IconButton(
                    icon: Icon(
                      isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
                      color: Colors.white,
                      size: size.height * 0.035,
                    ),
                    onPressed: () => toggleFullScreen(context),
                  ),
                ],
              ),
            ),
          )
              : Container(),
          Positioned(
            top: 120,
            left: 0,
            right: 0,
            child: GestureDetector(
              onTap: _handleTap,
              child: Center(
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: size.width,
                    color: AppColors.black.withValues(alpha: 0.05),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        FadeInAnimation(
                          delay: const Duration(milliseconds: 300),
                          initOpacity: 0,
                          child: Container(
                            width: 1,
                            height: 100,
                            color: AppColors.light,
                          ),
                        ),
                        SizedBox(height: size.height * 0.021),
                        FadeInScaleAnimation(
                          initScale: 2,
                          initOpacity: 0,
                          child: CustomText(
                            label: widget.data['subTitle'][widget.lang],
                            textStyle: const TextStyle(color: AppColors.light,fontWeight: FontWeight.w500),
                            isUppercase: true
                          ),
                        ),
                        FadeInScaleAnimation(
                          initScale: 2,
                          initOpacity: 0,
                          child: CustomText(
                            label: widget.data['title'][widget.lang],
                            type: 'xsm',
                            textStyle: const TextStyle(color: AppColors.white),
                            isSerif: true,
                          ),
                        ),
                        SizedBox(height: size.height * 0.021),
                        FadeInAnimation(
                          delay: const Duration(milliseconds: 300),
                          initOpacity: 0,
                          child: Container(
                            width: 1,
                            height: 100,
                            color: AppColors.light,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget customVideoPlayerWidget(String videoUrl, BuildContext context){
    return Stack(
      children: [
        GestureDetector(
          onDoubleTap: () {
            toggleFullScreen(context);
          },

          child: Center(
            child: AspectRatio(
              aspectRatio: _controller.value.aspectRatio,
              child: VideoPlayer(_controller),
            ),
          ),
        ),
        // FULLSCREEN BOTTOM CONTROLS
        Positioned(
          bottom: 20,
          left: 2,
          right: 2,
          child: _buildControls(context),
        ),
      ],
    );
  }

  Widget _buildControls(context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
      height: size.height * 0.07,
      decoration: const BoxDecoration(
        color: Color.fromARGB(200, 0, 0, 0),
      ),
      child: Row(
        children: [
          ValueListenableBuilder(
            valueListenable: _controller,
            builder: (context, VideoPlayerValue value, child) {
              final hours = value.position.inHours.toString().padLeft(2, '0');
              final minutes = (value.position.inMinutes % 60)
                  .toString()
                  .padLeft(2, '0');
              final seconds =
              value.position.inSeconds.remainder(60).toString().padLeft(2, '0');

              return Text(
                '$hours:$minutes:$seconds',
                style: const TextStyle(color: Colors.white),
              );
            },
          ),

          IconButton(
            icon: Icon(
              _isPlaying ? Icons.pause : Icons.play_arrow,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                if (_controller.value.isPlaying) {
                  _controller.pause();
                } else {
                  _controller.play();
                }
              });
            },
          ),

          Expanded(
            child: Center(
              child: Transform.translate(
                offset: const Offset(0, -10),
                child: VideoProgressIndicator(
                  _controller,
                  padding: const EdgeInsets.only(top: 20),
                  allowScrubbing: true,
                  colors: const VideoProgressColors(
                    playedColor: AppColors.primary,
                    bufferedColor: AppColors.light,
                    backgroundColor: Colors.white,
                  ),
                ),
              ),
            ),
          ),

          IconButton(
            icon: Icon(
              _isMuted ? Icons.volume_off : Icons.volume_up,
              color: Colors.white,
            ),
            onPressed: () {
              setState(() {
                _isMuted = !_isMuted;
                _controller.setVolume(_isMuted ? 0 : 1);
              });
            },
          ),

          Text(
            '${_controller.value.duration.inHours.toString().padLeft(2, '0')}:${(_controller.value.duration.inMinutes % 60).toString().padLeft(2, '0')}:${_controller.value.duration.inSeconds.remainder(60).toString().padLeft(2, '0')}',
            style: const TextStyle(color: Colors.white),
          ),

          IconButton(
            icon: Icon(
              isFullScreen ? Icons.fullscreen_exit : Icons.fullscreen,
              color: Colors.white,
              size: size.height * 0.035,
            ),
            onPressed: () {
              toggleFullScreen(context);
            },
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
            return Scaffold(
              backgroundColor: Colors.transparent,
              body: Center(
                child: SizedBox(
                  width: size.width,
                  height: size.height,
                  child: customVideoPlayerWidget(widget.data['video'],context),
                ),
              ),
            );
          },
        );
      },
    );
  }
}
