import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YoutubePlayerScreen extends StatefulWidget {
  final String videoId;
  final bool isUrl;

  const YoutubePlayerScreen({
    super.key,
    required this.videoId,
    this.isUrl = false,
  });

  @override
  State<YoutubePlayerScreen> createState() => _YoutubePlayerScreenState();
}

class _YoutubePlayerScreenState extends State<YoutubePlayerScreen> {
  late YoutubePlayerController _controller;
  bool _isLoading = true;
  bool _isMuted = false;
  Duration? _videoDuration;

  late final bool isUrl;
  @override
  void initState() {
    super.initState();

    _initializeController(widget.videoId);
  }

  void _initializeController(String videoId) {
    final id = widget.isUrl
        ? YoutubePlayer.convertUrlToId(videoId) ?? ""
        : videoId;  //old one where video was not playing Narmada

    // final id = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=$videoId");
    log("=====youtubeId $id --- ${widget.isUrl}");
    if (id.isEmpty) {
      log("[ERROR] Invalid YouTube URL: $videoId");
      return;
    }
    _controller = YoutubePlayerController(
      initialVideoId: id,
      flags: const YoutubePlayerFlags(
        autoPlay: true,
        mute: false,
        disableDragSeek: false,
        loop: false,
        hideControls: true,
        enableCaption: true,
      ),
    );

    _controller.addListener(_onPlayerStateChange);
  }

  @override
  void didUpdateWidget(YoutubePlayerScreen oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.videoId != widget.videoId) {
      _controller.removeListener(_onPlayerStateChange);
      _controller.dispose();
      setState(() {
        _isLoading = true;
      });
      _initializeController(widget.videoId);
    }
  }

  void _onPlayerStateChange() {
    if (_controller.value.isReady && mounted && !_controller.value.isFullScreen) {
      setState(() {
        _isLoading = false;

        _videoDuration = _controller.metadata.duration;
      });
    }
  }

  void _togglePlayPause() {
    if (_controller.value.isPlaying) {
      _controller.pause();
    } else {
      _controller.play();
    }
    setState(() {});
  }

  void _toggleMute() {
    setState(() {
      _isMuted = !_isMuted;
      if (_isMuted) {
        _controller.mute();
      } else {
        _controller.unMute();
      }
    });
  }

  void _onSeekChanged(double value) {
    final position = Duration(seconds: value.toInt());
    _controller.seekTo(position);
  }

  @override
  void dispose() {
    _controller.removeListener(_onPlayerStateChange);
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          // AspectRatio(
          // aspectRatio: _controller.value.aspectRatio,
          //   child: VideoPlayer(_controller),
          // ),
          Center(
            child: YoutubePlayer(
              key: ObjectKey(_controller),
              controller: _controller,
              showVideoProgressIndicator: true,
              progressIndicatorColor: AppColors.primary,
              onReady: () {
                setState(() {
                  _isLoading = false;
                });
              },
            ),
          ),
          if (_isLoading)
            Center(
              child: LoadingComponent(
                width: double.infinity,
                height: double.infinity,
                decoration:
                BoxDecoration(color: AppColors.black.withValues(alpha: .5)),
              ),
            ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              color: AppColors.black.withAlpha(40),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  IconButton(
                    icon: Icon(
                      _controller.value.isPlaying
                          ? Icons.pause
                          : Icons.play_arrow,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: _togglePlayPause,
                  ),
                  Expanded(
                    child: Slider(
                      thumbColor: AppColors.primary,
                      activeColor: AppColors.primary,
                      value: _controller.value.position.inSeconds.toDouble(),
                      min: 0.0,
                      max: _videoDuration?.inSeconds.toDouble() ?? 1.0,
                      onChanged: (value) {
                        _onSeekChanged(value);
                      },
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      _isMuted ? Icons.volume_off : Icons.volume_up,
                      color: Colors.white,
                      size: 30,
                    ),
                    onPressed: _toggleMute,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
