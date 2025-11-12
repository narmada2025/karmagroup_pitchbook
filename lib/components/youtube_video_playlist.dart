import 'package:flutter/material.dart';
import 'package:pitchbook/components/video_grid_title_widget.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';

class YoutubeVideoPlaylist extends StatefulWidget {
  final String playlistId;

  const YoutubeVideoPlaylist({
    super.key,
    required this.playlistId,
  });

  @override
  State<YoutubeVideoPlaylist> createState() => _YoutubeVideoPlaylistState();
}

class _YoutubeVideoPlaylistState extends State<YoutubeVideoPlaylist> {
  List<Map<String, dynamic>> moments = [];
  bool isLoading = true;
  final playlistCache = PlaylistCache();

  @override
  void initState() {
    super.initState();
    _fetchMoments();
  }

  Future<void> _fetchMoments() async {
    try {
      List<Map<String, dynamic>> items =
          await playlistCache.fetchPlaylistItems(widget.playlistId);
      setState(() {
        moments = items;
        isLoading = false;
      });
    } catch (e) {
      // print('Failed to load moments: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const Center(child: LoadingComponent())
        : VideoGridTitleWidget(
            key: ValueKey('youtube$moments.length'),
            data: moments,
            columns: 3,
            gap: 20,
            scrollGapX: 0,
            useGrid: true,
            gridRatio: 3 / 1.6,
            initialItemCount: 9,
            loadMoreCount: 9,
            isYoutube: true,
            textAlign: Alignment.bottomCenter,
            titleBoxPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
            titleBoxDecoration: const BoxDecoration(
              color: Color.fromARGB(71, 0, 0, 0),
            ),
          );
  }
}
