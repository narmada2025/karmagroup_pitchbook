// import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/fade_in_scale_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';

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

  @override
  void initState() {
    super.initState();

    _controller = VideoPlayerController.networkUrl(Uri.parse('${AppAPI.baseUrlGcp}${widget.data['video']}'));
    _controller.initialize().then((_) {
      if (mounted) {
        setState(() {
          _controller.play();
        });
      }
    });
    _controller.setLooping(true);
    _controller.setVolume(0);

    _contentController = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );
    _fadeAnimation =
        Tween<double>(begin: 1.0, end: 0.0).animate(_contentController);
    Future.delayed(const Duration(seconds: 5), () {
      if (mounted) {
        _contentController.forward();
      }
    });
  }

  // Future<void> loadVideo() async {
  //   final ref = FirebaseStorage.instance.ref("");
  //   final videoUrl = await ref.getDownloadURL();
  //
  //   _controller = VideoPlayerController.network(videoUrl);
  //   _initializeVideoPlayerFuture = _controller!.initialize().then((_) {
  //     setState(() {});
  //     _controller!.play(); // Autoplay
  //     _controller!.setLooping(true);
  //   });
  // }

  @override
  void dispose() {
    _controller.dispose();
    _contentController.dispose();
    super.dispose();
  }

  void _handleTap() {
    _contentController.reset();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _contentController.forward();
      }
    });
    setState(() {
      _contentController.value = 0.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      width: size.width,
      decoration: BoxDecoration(
        border: Border.all(width: 1, color: AppColors.black),
      ),
      child: Stack(
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
            child: _controller.value.isInitialized
                ? SizedBox(
                    child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: VideoPlayer(_controller),
                    ),
                  )
                : Container(),
          ),
          GestureDetector(
            onTap: _handleTap,
            child: Center(
              child: AspectRatio(
                aspectRatio: 16 / 9,
                child: FadeTransition(
                  opacity: _fadeAnimation,
                  child: Container(
                    width: size.width,
                    color: AppColors.black.withValues(alpha: 0.6),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            children: [
                              FadeInAnimation(
                                delay: const Duration(milliseconds: 300),
                                initOpacity: 0,
                                child: Container(
                                  width: 1,
                                  height: 100,
                                  color: AppColors.secondary,
                                ),
                              ),
                              const SizedBox(height: 20),
                              FadeInScaleAnimation(
                                initScale: 2,
                                initOpacity: 0,
                                child: CustomText(
                                  label: widget.data['subTitle'][widget.lang],
                                  textStyle: const TextStyle(
                                      color: AppColors.secondary),
                                  isUppercase: true,
                                ),
                              ),
                              FadeInScaleAnimation(
                                initScale: 2,
                                initOpacity: 0,
                                child: CustomText(
                                  label: widget.data['title'][widget.lang],
                                  type: 'xmd',
                                  textStyle:
                                      const TextStyle(color: AppColors.white),
                                  isSerif: true,
                                ),
                              ),
                              const SizedBox(height: 20),
                              FadeInAnimation(
                                delay: const Duration(milliseconds: 300),
                                initOpacity: 0,
                                child: Container(
                                  width: 1,
                                  height: 100,
                                  color: AppColors.secondary,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
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
}
