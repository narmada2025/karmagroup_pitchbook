import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../../components/youtube_player_screen.dart';
import '../../constants/app_data.dart';
import '../../constants/custom_text.dart';
import '../../constants/loading_component.dart';

class VideoFullScreenView extends StatefulWidget {
  final String videoUrl;
  final int index;
  final List<dynamic> data;
  final int initialItemCount;
  final String? lang;
  final bool isYoutube;
  final bool isUrl;

  const VideoFullScreenView({super.key,
    required this.videoUrl, required this.index, required this.data, required this.initialItemCount, this.lang, required this.isYoutube, required this.isUrl});

  @override
  State<VideoFullScreenView> createState() => _VideoFullScreenViewState();
}

class _VideoFullScreenViewState extends State<VideoFullScreenView> {
  late VideoPlayerController _controller;
  bool _isMuted = false;
  bool _isPlaying = true;
  bool isFullScreen = false;
  bool _isControllerInitialized = false;
  List<String> _videoTitles = [];
  List<String> _videoUrls = [];
  List<String> _videoCovers = [];
  int _itemCount = 0;

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

  void toggleFullScreen() {
    setState(() {
      isFullScreen = !isFullScreen;
    });

    if (isFullScreen) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);
    } else {
      // SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      // SystemChrome.setPreferredOrientations([
      //   DeviceOrientation.portraitUp,
      //   DeviceOrientation.portraitDown,
      // ]);
    }
  }

  @override
  void initState() {
    super.initState();
    extractVideoUrls();
    _initializeVideoController(widget.videoUrl);
  }

  @override
  void didUpdateWidget(VideoFullScreenView oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller.dispose();
      _initializeVideoController(widget.videoUrl);
    }
  }

  Future<void> _initializeVideoController(String url) async {
    print("====GoodKarma url $url");
    if (url.startsWith('http')) {
      // Fix Firebase Storage incorrect domain if needed
      if (url.contains(".firebasestorage.app")) {
        final decodedPath = Uri.decodeFull(Uri.parse(url).pathSegments.last);
        final storagePath = decodedPath.replaceAll('%2F', '/');
        url = await FirebaseStorage.instance.ref(storagePath).getDownloadURL();
      }

      _controller = VideoPlayerController.networkUrl(Uri.parse(url))
        ..initialize().then((_) {
          setState(() {
            _isPlaying = true;
            _controller.play();
            _isControllerInitialized = true;
          });
        });
    } else {
      _controller = VideoPlayerController.asset(url)
        ..initialize().then((_) {
          setState(() {
            _isPlaying = true;
            _controller.play();
            _isControllerInitialized = true;
          });
        });
    }

    _controller.addListener(_onVideoPlayerStateChanged);
  }
  void _onVideoPlayerStateChanged() {
    setState(() {
      _isPlaying = _controller.value.isPlaying;
    });
  }

  @override
  void dispose() {
    _controller.removeListener(_onVideoPlayerStateChanged);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    int currentIndex = widget.index;

    return
      Scaffold(
        backgroundColor: AppColors.black,
        body:
        _isControllerInitialized?
            Center(
              child:
                  !isFullScreen?
              Stack(
                children: [
                  Center(
                    child: Container(
                      width: size.width,
                      padding: const EdgeInsets.symmetric(horizontal: 20,vertical: 50),
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
                                      padding:
                                      const EdgeInsets.fromLTRB(40, 20, 40, 20),
                                      height: size.height,
                                      alignment: Alignment.center,
                                      child: widget.isYoutube
                                          ? YoutubePlayerScreen(
                                        videoId: widget.isUrl
                                            ? YoutubePlayer.convertUrlToId(
                                            _videoUrls[currentIndex])!
                                            : _videoUrls[currentIndex],
                                        isUrl: true,
                                      )
                                          : customVideoPlayerWidget(_videoUrls[currentIndex])

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
              )
                      :Center(
                    child: Container(
                        padding: const EdgeInsets.fromLTRB(20, 0, 20, 70),
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
                            : customVideoPlayerWidget(_videoUrls[currentIndex])

                    ),
                  ),
            ):const LoadingComponent()
      );

  }

  Widget _buildControls() {
    Size size = MediaQuery.of(context).size;
    return Container(
      padding: EdgeInsets.symmetric(horizontal: size.width * 0.08),
      height: size.height * 0.07,
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
            onPressed: toggleFullScreen,
          ),
        ],
      ),
    );
  }

  Widget customVideoPlayerWidget(String videoUrl){
    return Stack(
      children: [
        GestureDetector(
            onDoubleTap: () {
              toggleFullScreen();
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
          child: _buildControls(),
        ),
      ],
    );
  }
}
