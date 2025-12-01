import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/video_grid_title_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/good_karma/widgets/good_karma_item.dart';

class GoodKarmaShowcaseWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String lang;

  const GoodKarmaShowcaseWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  State<GoodKarmaShowcaseWidget> createState() =>
      _GoodKarmaShowcaseWidgetState();
}

class _GoodKarmaShowcaseWidgetState extends State<GoodKarmaShowcaseWidget> {
  int _selectedIndex = 0;
  List<Map<String, dynamic>> _selectedData = [];

  Map<String, dynamic> _chairmanStories = {};
  List<Map<String, dynamic>> allVideos = [];

  List<Map<String, dynamic>> moments = [];
  List<Map<String, dynamic>> experiences = [];
  List<Map<String, dynamic>> resort = [];

  bool isLoading = true;
  bool isMomentsLoading = true;
  bool isExperiencesLoading = true;
  bool isResortLoading = true;
  bool isChairmanStoriesLoading = true;

  final playlistCache = PlaylistCache();

  @override
  void initState() {
    super.initState();
    _fetchData();
  }

  Future<void> _fetchData() async {
    try {
      // final goodKarmaDataFetched = await loadJsonFromAssets(AppAPI.goodKarma);
      // setState(() {
      //   _category = goodKarmaDataFetched;
      // });

      final chairmanStoriesData =
          await fetchAPIData(AppAPI.chairmanSessionFeaturedStories);
      setState(() {
        _chairmanStories = chairmanStoriesData ?? {};
        isChairmanStoriesLoading = false;
      });

      allVideos.clear();
      if (_chairmanStories['chairman_categories'] != null) {
        for (var item in _chairmanStories['chairman_categories']) {
          allVideos.add({
            'video': item['video_content'] ?? '',
            'cover': item['thumbnail'] ?? '',
            'title': item['title'] ?? '',
          });
        }
      }

      final momentsData = await playlistCache
          .fetchPlaylistItems('PL4pM9BzbCWHZc0xAf81wUWW_aY-xjQFPs');
      // log("===fetchData $momentsData");
      setState(() {
        moments = momentsData;
        _selectedData = moments;
        isMomentsLoading = false;
      });

      final experiencesData = await playlistCache
          .fetchPlaylistItems('PL4pM9BzbCWHaKMJZfCqdIDTu-iimB-1zf');
      setState(() {
        experiences = experiencesData;
        isExperiencesLoading = false;
      });

      final resortData = await playlistCache
          .fetchPlaylistItems('PL4pM9BzbCWHb__w9LCIZk-99wbs-VonWL');
      setState(() {
        resort = resortData;
        isResortLoading = false;
      });

      if (!mounted) return;

      setState(() {
        isLoading = false;
      });
    } catch (e) {
      if (!mounted) return;
      setState(() {
        isLoading = false;
      });
    }
  }

  void _changeSelected(int index) {
    if (!mounted) return;

    setState(() {
      _selectedIndex = index;
      if (_selectedIndex == 0) {
        _selectedData = moments;
      } else if (_selectedIndex == 1) {
        _selectedData = allVideos;
      } else if (_selectedIndex == 2) {
        _selectedData = experiences;
      } else if (_selectedIndex == 3) {
        _selectedData = resort;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return isLoading
        ? const FadeInAnimation(
            delay: Duration(milliseconds: 700),
            child: Center(child: LoadingComponent()))
        : Column(
            mainAxisSize: MainAxisSize.max,
            children: [
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    if (widget.data['categories'] != null)
                      ...widget.data['categories']
                          .asMap()
                          .entries
                          .map<Widget>((entry) {
                        return ConciergeItem(
                          title: entry.value['title'][widget.lang] ?? '',
                          image: entry.value['image'] ?? '',
                          index: entry.key,
                          onTap: _changeSelected,
                          isSelected: _selectedIndex == entry.key,
                          placeCount: widget.data['categories'].length,
                        );
                      }).toList()
                    else
                      const LoadingComponent(),
                  ],
                ),
              ),
              if (_selectedData.isNotEmpty)
                Container(
                  padding: const EdgeInsets.fromLTRB(80, 80, 80, 120),
                  child: VideoGridTitleWidget(
                    key: ValueKey('youtube$_selectedIndex'),
                    data: _selectedData,
                    columns: 3,
                    gap: 20,
                    scrollGapX: 0,
                    useGrid: true,
                    gridRatio: 3 / 1.6,
                    initialItemCount: 9,
                    loadMoreCount: 9,
                    isYoutube: true,
                    isUrl: _selectedIndex == 1 ? true : false,
                    textAlign: Alignment.bottomCenter,
                    titleBoxPadding: const EdgeInsets.fromLTRB(20, 15, 20, 15),
                    titleBoxDecoration: const BoxDecoration(
                      color: Color.fromARGB(71, 0, 0, 0),
                    ),
                  ),
                )
              else
                const LoadingComponent(),
            ],
          );
  }
}
