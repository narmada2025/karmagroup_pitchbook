import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:video_player/video_player.dart';

class CustomVideoPlayer extends StatefulWidget {
  final String videoUrl;

  const CustomVideoPlayer({super.key, required this.videoUrl});

  @override
  State<CustomVideoPlayer> createState() => _CustomVideoPlayerState();
}

class _CustomVideoPlayerState extends State<CustomVideoPlayer> {
  late VideoPlayerController _controller;
  bool _isMuted = false;
  bool _isPlaying = true;
  bool _isControllerInitialized = false;
  bool isFullScreen = false;

  @override
  void initState() {
    super.initState();
    _initializeVideoController(widget.videoUrl);
  }

  @override
  void didUpdateWidget(CustomVideoPlayer oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoUrl != widget.videoUrl) {
      _controller.dispose();
      _initializeVideoController(widget.videoUrl);
    }
  }

  Future<void> _initializeVideoController(String url) async {
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

  void toggleFullScreen() async{
    setState(() {
      isFullScreen = !isFullScreen;
    });

    if (isFullScreen) {
      // ENTER FULLSCREEN WITHOUT NAVIGATION
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);

      await SystemChrome.setPreferredOrientations([
        DeviceOrientation.landscapeLeft,
        DeviceOrientation.landscapeRight,
      ]);

      setState(() {
        isFullScreen = true;
      });
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge);
      SystemChrome.setPreferredOrientations([
        DeviceOrientation.portraitUp,
      ]);
    }
  }

  @override
  Widget build(BuildContext context) {
    return isFullScreen
        ? Scaffold(
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
          children: [
            Center(
              child: AspectRatio(
                aspectRatio: _controller.value.aspectRatio,
                child: VideoPlayer(_controller),
              ),
            ),

            // FULLSCREEN BOTTOM CONTROLS
            Positioned(
              bottom: 10,
              left: 2,
              right: 2,
              child: _buildControls(),
            ),
          ],
        ),
      ),
    )
        : Center(
      child: _isControllerInitialized
          ? Stack(
        children: [
          AspectRatio(
            aspectRatio: _controller.value.aspectRatio,
            child: VideoPlayer(_controller),
          ),

         //All Video Controls
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: _buildControls(),
          ),
        ],
      )
          : const LoadingComponent(),
    );

  }

  Widget _buildControls() {
    return Container(
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
              size: 30,
            ),
            onPressed: toggleFullScreen,
          ),
        ],
      ),
    );
  }

}


