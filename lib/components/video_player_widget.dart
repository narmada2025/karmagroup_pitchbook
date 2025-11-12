import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerWidget extends StatefulWidget {
  final List<String> videoUrls;
  final int currentIndex;
  final Function(int)? onIndexChanged;

  const VideoPlayerWidget({
    super.key,
    required this.videoUrls,
    required this.currentIndex,
    required this.onIndexChanged,
  });

  @override
  State<VideoPlayerWidget> createState() => _VideoPlayerWidgetState();
}

class _VideoPlayerWidgetState extends State<VideoPlayerWidget> {
  late VideoPlayerController _controller;
  bool _isMuted = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoController(widget.videoUrls[widget.currentIndex]);
  }

  @override
  void didUpdateWidget(VideoPlayerWidget oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentIndex != widget.currentIndex) {
      _controller.dispose();
      _initializeVideoController(widget.videoUrls[widget.currentIndex]);
    }
  }

  void _initializeVideoController(String url) {
    _controller = VideoPlayerController.asset(url)
      ..initialize().then((_) {
        setState(() {
          _isPlaying = true;
          _controller.play();
        });
      });
    _controller.addListener(_onVideoPlayerStateChanged);
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
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          alignment: Alignment.center,
          height: double.infinity,
          child: _controller.value.isInitialized
              ? Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: Container(
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: VideoPlayer(_controller),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      left: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        height: 40,
                        decoration: const BoxDecoration(
                          color: Color.fromARGB(200, 0, 0, 0),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(10),
                            bottomRight: Radius.circular(10),
                          ),
                        ),
                        child: Row(
                          children: [
                            ValueListenableBuilder(
                              valueListenable: _controller,
                              builder:
                                  (context, VideoPlayerValue value, child) {
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
                                      backgroundColor:
                                          Color.fromARGB(255, 255, 255, 255),
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
                          ],
                        ),
                      ),
                    ),
                  ],
                )
              : const Center(child: LoadingComponent()),
        ),
      ],
    );
  }
}
