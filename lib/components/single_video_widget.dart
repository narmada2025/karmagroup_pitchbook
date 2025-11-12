import 'package:flutter/material.dart';
import 'package:pitchbook/components/video_player_widget.dart';
import 'package:pitchbook/constants/app_data.dart';

class SingleVideoWidget extends StatelessWidget {
  final String videoUrl;
  final String coverImage;
  final bool showIcon;
  final VoidCallback? onTap;

  const SingleVideoWidget({
    super.key,
    required this.videoUrl,
    required this.coverImage,
    this.showIcon = true,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        _showVideoDialog(context);
      },
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.primary,
          borderRadius: BorderRadius.circular(10),
          image: DecorationImage(
            image: _getCoverImage(),
            fit: BoxFit.cover,
          ),
        ),
        child: showIcon
            ? const Center(
                child: Icon(
                  Icons.play_circle_fill,
                  color: Colors.white,
                  size: 80,
                ),
              )
            : null,
      ),
    );
  }

  ImageProvider _getCoverImage() {
    if (coverImage.startsWith('http://') || coverImage.startsWith('https://')) {
      return NetworkImage(coverImage);
    } else {
      return NetworkImage('${AppAPI.baseUrlGcp}$coverImage');
    }
  }

  void showVideoDialog(BuildContext context) {
    _showVideoDialog(context);
  }

  void _showVideoDialog(BuildContext context) {
    showDialog(
      barrierColor: AppColors.black.withValues(alpha: .5),
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          backgroundColor: Colors.transparent,
          child: SizedBox(
            width: MediaQuery.of(context).size.width,
            height: MediaQuery.of(context).size.height - 200,
            child: Stack(
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height - 200,
                  child: VideoPlayerWidget(
                    videoUrls: [videoUrl],
                    currentIndex: 0,
                    onIndexChanged: (index) {},
                  ),
                ),
                Positioned(
                  top: 10,
                  right: 10,
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
            ),
          ),
        );
      },
    );
  }
}
