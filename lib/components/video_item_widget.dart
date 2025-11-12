import 'dart:developer';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:video_player/video_player.dart';

class VideoItemWidget extends StatefulWidget {
  final Map<String, dynamic> videoData;
  final double itemWidth;
  final Alignment textAlign;
  final Widget? icon;
  final BoxDecoration? titleBoxDecoration;
  final BoxDecoration? boxOverlay;
  final EdgeInsetsGeometry? titleBoxPadding;

  const VideoItemWidget({
    super.key,
    required this.videoData,
    required this.itemWidth,
    this.textAlign = Alignment.bottomLeft,
    this.titleBoxDecoration,
    this.boxOverlay,
    this.titleBoxPadding,
    this.icon,
  });

  @override
  State<VideoItemWidget> createState() => _VideoItemWidgetState();
}

class _VideoItemWidgetState extends State<VideoItemWidget> {
  final Map<String, Duration> _videoDurations = {};

  Future<Duration>? _videoDurationFuture;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      clipBehavior: Clip.antiAlias,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
      ),
      width: widget.itemWidth,
      child: Stack(
        alignment: Alignment.center,
        children: [
          Image(
            width: double.infinity,
            image: (widget.videoData["cover"] != null &&
                    widget.videoData["cover"]!.isNotEmpty)
                ? (widget.videoData["cover"]!.startsWith('http')
                    ? NetworkImage(
                        widget.videoData["cover"]!,
                      )
                    : NetworkImage('${AppAPI.baseUrlGcp}${widget.videoData["cover"]!}'))
                : NetworkImage('${AppAPI.baseUrlGcp}${'assets/thumb.jpg'}'),
            fit: BoxFit.cover,
          ),

          //Firebase video
          if (!widget.videoData["cover"]!.startsWith('http'))
            Positioned(
              top: 8,
              left: 8,
              child: FutureBuilder<Duration>(
                future: _videoDurationFuture ??=
                    _getVideoLength(widget.videoData['video']),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    final duration = snapshot.data!;
                    return Container(
                      padding: const EdgeInsets.fromLTRB(5, 3, 5, 3),
                      decoration: BoxDecoration(
                          color: AppColors.black.withValues(alpha: 0.8),
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        formattedDuration(duration),
                        style: const TextStyle(
                          color: AppColors.white,
                          fontSize: 12,
                        ),
                      ),
                    );
                  } else {
                    return const Text(
                      'Loading...',
                      style: TextStyle(
                        color: AppColors.white,
                        fontSize: 12,
                      ),
                    );
                  }
                },
              ),
            ),

          if (widget.videoData["title"] != null &&
              widget.videoData["title"]!.isNotEmpty)
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              top: 0,
              child: Container(
                alignment: widget.textAlign,
                decoration: widget.boxOverlay ??
                    BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.black.withValues(alpha: 0.8),
                          Colors.black.withValues(alpha: 0)
                        ],
                        begin: Alignment.bottomCenter,
                        end: Alignment.topCenter,
                      ),
                    ),
                child: Container(
                  width: double.infinity,
                  padding: widget.titleBoxPadding ??
                      const EdgeInsets.fromLTRB(10, 10, 10, 10),
                  decoration: widget.titleBoxDecoration,
                  child: CustomText(
                    label: widget.videoData['title'],
                    type: 'lg',
                    isSerif: true,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    textStyle: const TextStyle(color: AppColors.white),
                  ),
                ),
              ),
            ),
          Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: widget.icon ??
                  const Icon(
                    Icons.play_circle_fill,
                    size: 50,
                    color: AppColors.white,
                  ),
            ),
          ),
        ],
      ),
    );
  }

  // Future<Duration> _getVideoLength(String videoUrl) async {
  //   if (_videoDurations.containsKey(videoUrl)) {
  //     return _videoDurations[videoUrl]!;
  //   } else {
  //     final videoPlayerController = VideoPlayerController.asset(videoUrl);
  //     await videoPlayerController.initialize();
  //     final duration = videoPlayerController.value.duration;
  //     videoPlayerController.dispose();
  //     _videoDurations[videoUrl] = duration;
  //     return duration;
  //   }
  // }

  Future<Duration> _getVideoLength(String videoUrl) async {
    log("getVideoLength======= ");
    if (_videoDurations.containsKey(videoUrl)) {
      log("---if videos ${videoUrl}");
      return _videoDurations[videoUrl]!;
    } else {
      log("videoUrl======$videoUrl");
      // If URL has .firebasestorage.app, fetch the proper download URL from Firebase
      if (videoUrl.contains(".firebasestorage.app")) {
        try {
          // Extract the file path from the bad URL
          final decodedPath = Uri.decodeFull(Uri.parse(videoUrl).pathSegments.last);
          // In your case, file path will be like "videos%2Ffilename.mp4"
          final storagePath = decodedPath.replaceAll('%2F', '/');

          log("Fixing bad URL. Fetching from Firebase Storage: $storagePath");

          videoUrl = await FirebaseStorage.instance.ref(storagePath).getDownloadURL();
          log("==== $videoUrl");
        } catch (e) {
          log("Failed to fix Firebase URL: $e");
        }
      }

      final videoPlayerController = VideoPlayerController.networkUrl(Uri.parse(videoUrl));
      await videoPlayerController.initialize();
      final duration = videoPlayerController.value.duration;
      videoPlayerController.dispose();
      _videoDurations[videoUrl] = duration;
      return duration;
    }
  }

  String formattedDuration(Duration duration) {
    if (duration.inHours > 0) {
      return '${duration.inHours.toString().padLeft(2, '0')}:${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    } else {
      return '${(duration.inMinutes % 60).toString().padLeft(2, '0')}:${duration.inSeconds.remainder(60).toString().padLeft(2, '0')}';
    }
  }
}
