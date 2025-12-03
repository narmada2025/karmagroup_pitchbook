import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/constants/no_internet.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/app_locatizations.dart';
import 'package:pitchbook/src/community/community_banner_widget.dart';
import 'package:pitchbook/src/community/community_chairman_session_widget.dart';
import 'package:pitchbook/src/community/community_curated_events_widget.dart';
import 'package:pitchbook/src/community/community_event_images_widget.dart';
import 'package:pitchbook/src/community/community_featured_stories_widget.dart';
import 'package:pitchbook/src/community/community_press_features_widget.dart';

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  Map<String, dynamic> data = {};
  Future<void>? _fetchDataFuture;
  Map<String, dynamic> _chairmanSessionFeaturedStories = {};
  List<dynamic> _eventGallery = [];
  Map<String, dynamic> _events = {};
  bool _isConnected = true;
  List<dynamic> _press = [];

  @override
  void initState() {
    super.initState();
    _fetchDataFuture = _checkInternetAndFetchData();
    _loadJsonData();
  }

  Future<void> _loadJsonData() async {
    final jsonData = await loadJsonFromAssets(AppAPI.community);
    setState(() {
      data = jsonData;
    });
  }

  Future<void> _checkInternetAndFetchData() async {
    bool isConnected = await checkInternetAvailability();
    setState(() {
      _isConnected = isConnected;
    });
    if (isConnected) {
      await _fetchData();
    }
  }

  Future<void> _fetchData() async {
    final chairmanSessionFeaturedStories =
        await fetchAPIData(AppAPI.chairmanSessionFeaturedStories);

    final eventData = await fetchAPIData(AppAPI.events);

    final galleryData = await fetchAPIData(AppAPI.eventGallery, isMap: true);

    final pressData = await fetchAPIData(AppAPI.press, isMap: true);

    for (var imageData in galleryData) {
      String imageUrl = imageData["url"];
      String largeImageUrl = imageData["sizes"]["large"];

      final imageProvider = NetworkImage(imageUrl);
      final largeImageProvider = NetworkImage(largeImageUrl);
      if (!mounted) return;
      precacheImage(imageProvider, context);
      precacheImage(largeImageProvider, context);
    }
    setState(() {
      _chairmanSessionFeaturedStories = chairmanSessionFeaturedStories;
      log("_chairmanSessionFeaturedStories $_chairmanSessionFeaturedStories");
      _events = eventData;
      _eventGallery = galleryData;
      _press = pressData;
    });
  }

  void _reloadPage() {
    setState(() {
      _fetchDataFuture = _checkInternetAndFetchData();
    });
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    return Scaffold(
        backgroundColor: AppColors.black,
        body: Stack(
          children: [
            SingleChildScrollView(
                child: Column(
              mainAxisSize: MainAxisSize.max,
              children: [
                if (data['banner'] != null)
                  CommunityBannerWidget(data: data['banner'], lang: lang),
                if (!_isConnected)
                  NoInternet(
                    onRefresh: _reloadPage,
                  ),
                FutureBuilder<void>(
                  future: _fetchDataFuture,
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: LoadingComponent());
                    } else if (snapshot.hasError) {
                      return Center(
                          child: NoData(
                              title: tr(context, 'errors.Error fetching data',
                                  lang)));
                    } else {
                      return Column(
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          if (_isConnected)
                            CommunityChairmanSessionWidget(
                              chairmanSession: _chairmanSessionFeaturedStories,
                            ),
                          if (_isConnected)
                            CommunityCuratedEventsWidget(
                              events: _events,
                              data: data['events'],
                              lang: lang,
                            ),
                          if (_isConnected)
                            CommunityEventImagesWidget(
                              galleryData: _eventGallery,
                              data: data['events'],
                              lang: lang,
                            ),
                          if (_isConnected)
                            CommunityFeaturedStoriesWidget(
                              stories: _chairmanSessionFeaturedStories,
                              data: data['events'],
                              lang: lang,
                            ),
                          if (_isConnected)
                            CommunityPressFeaturesWidget(
                              press: _press,
                              data: data['events'],
                              lang: lang,
                            ),
                        ],
                      );
                    }
                  },
                ),
              ],
            )),
            Positioned(
              top: 40,
              right: 20,
              child: IconButton(
                color: Colors.white,
                icon: const Icon(Icons.refresh),
                onPressed: _reloadPage,
              ),
            ),
          ],
        ));
  }
}
