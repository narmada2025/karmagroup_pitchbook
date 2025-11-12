import 'package:flutter/material.dart';
import 'package:pitchbook/components/error_alert.dart';
import 'package:video_player/video_player.dart';

class VideoWidget extends StatefulWidget {
  final double width;
  final String? url;
  final bool autoplay;
  final bool loop;
  final VideoPlayerController? controller;
  final Widget? cover;
  final bool showControls;

  const VideoWidget({
    super.key,
    required this.width,
    this.url,
    this.autoplay = false,
    this.loop = false,
    this.controller,
    this.cover,
    this.showControls = false,
  });

  @override
  State<VideoWidget> createState() => _VideoWidgetState();
}

class _VideoWidgetState extends State<VideoWidget> {
  late VideoPlayerController _controller;
  bool _isMuted = false;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    if (widget.controller != null) {
      _controller = widget.controller!;
    } else if (widget.url != null) {
      _controller = VideoPlayerController.asset(widget.url!)
        ..initialize().then((_) => setState(() {}));
    } else {
      throw Exception('Either url or controller must be provided');
    }
    if (widget.autoplay) {
      _controller.play();
      _isPlaying = true;
    }
    if (widget.loop) {
      _controller.setLooping(true);
    }

    _controller.addListener(() {
      if (_controller.value.hasError) {
        ErrorAlert errorAlert = ErrorAlert(
            error:
                'Error playing video: ${_controller.value.errorDescription}');
        errorAlert.showErrorDialog(context);
      }
      setState(() {
        _isPlaying = _controller.value.isPlaying;
      });
    });
  }

  @override
  void dispose() {
    if (widget.controller == null) {
      _controller.dispose();
    }
    super.dispose();
  }

  void _togglePlayPause() {
    setState(() {
      if (_controller.value.isPlaying) {
        _controller.pause();
      } else {
        _controller.play();
      }
    });
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      _controller.setVolume(_isMuted ? 0 : 1);
    });
  }

  String _formatDuration(Duration duration) {
    return '${duration.inMinutes.remainder(60).toString().padLeft(2, '0')}:${(duration.inSeconds.remainder(60) % 60).toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
          width: widget.width,
          child: VideoPlayer(_controller),
        ),
        if (widget.cover != null && !_isPlaying)
          Positioned.fill(child: widget.cover!),
        if (widget.showControls)
          Positioned.fill(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    IconButton(
                      onPressed: _toggleMute,
                      icon: Icon(
                        _isMuted
                            ? Icons.volume_off_outlined
                            : Icons.volume_up_outlined,
                        color: Colors.white,
                        size: 20,
                      ),
                    ),
                  ],
                ),
                Slider(
                  value: _controller.value.position.inSeconds.toDouble(),
                  min: 0,
                  max: _controller.value.duration.inSeconds.toDouble(),
                  onChanged: (value) {
                    setState(() {
                      _controller.seekTo(Duration(seconds: value.toInt()));
                    });
                  },
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '${_formatDuration(_controller.value.position)} / ${_formatDuration(_controller.value.duration)}',
                      style: const TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      onPressed: _togglePlayPause,
                      icon: Icon(
                        _controller.value.isPlaying
                            ? Icons.pause_circle_filled_outlined
                            : Icons.play_circle_fill_outlined,
                        color: Colors.white,
                        size: 40,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
      ],
    );
  }
}
