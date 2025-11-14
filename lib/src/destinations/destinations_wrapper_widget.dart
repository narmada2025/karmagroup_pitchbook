import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/slide_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_snackbar.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/src/app_locatizations.dart';
import 'package:pitchbook/src/destinations/widgets/country_item.dart';
import 'package:pitchbook/src/destinations/widgets/main_media_item.dart';
import 'package:pitchbook/src/destinations/widgets/place_item.dart';
import 'package:pitchbook/src/destinations/widgets/property_item.dart';

import '../../components/webView_3d_vr_screen.dart';

class DestinationsWrapperWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String lang;

  const DestinationsWrapperWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  State<DestinationsWrapperWidget> createState() =>
      _DestinationsWrapperWidgetState();
}

class _DestinationsWrapperWidgetState extends State<DestinationsWrapperWidget> {
  int _selectedDestination = 0;
  int _selectedPlace = 0;
  String _selectedThumbGallery = '';
  String _selectedThumbVideo = '';
  String _selectedThumbVe = '';
  String _selectedPlaceName = '';
  String _selectedPlaceImage = '';

  bool _hasCountries = false;
  bool _hasPlaces = false;
  bool _hasProperties = false;

  bool _isLoading = true;
  bool _placeAnimate = true;

  // Map<String, dynamic> data = {};
  List<dynamic> allGallery = [];
  List<dynamic> allVideos = [];
  List<dynamic> allVr = [];

  //Latest for Virtual experience
  bool isVirtualExperience =false;
  String countryNameVR="";

  @override
  void initState() {
    super.initState();
    _updateAllGallery();
    _updatePlaceDetails(_selectedDestination, _selectedPlace);
    _isLoading = false;
  }
  //
  // Future<void> _loadJsonData() async {
  //   final destinations = await loadJsonFromAssets(AppAPI.destinations);
  //   setState(() {
  //     data = destinations;
  //     _updateAllGallery();
  //     _updatePlaceDetails(_selectedDestination, _selectedPlace);
  //     _isLoading = false;
  //   });
  // }

  void _changeDestination(int index) {
    setState(() {
      _selectedDestination = index;
      _selectedPlace = 0;
      _updateAllGallery();
      _updatePlaceDetails(_selectedDestination, _selectedPlace);
      _placeAnimate = false;
      isVirtualExperience = false;
    });
  }

  //Latest
  void _changePlace(int index) {
    setState(() {
      _selectedPlace = index;
      _updateAllGallery();
      _updatePlaceDetails(_selectedDestination, _selectedPlace);

      final place = widget.data['countries'][_selectedDestination]['places'][_selectedPlace];

      final verExp = place['properties'][0]['media']?['ver_exp'] ?? [];
      isVirtualExperience = verExp.isNotEmpty;
    });
  }

  void _updatePlaceDetails(selectedDestination, selectedPlace) {
    if (widget.data['countries'] != null &&
        widget.data['countries'].length > 0) {
      _selectedDestination = selectedDestination;
      if (widget.data['countries'][_selectedDestination]['places'] != null &&
          widget.data['countries'][_selectedDestination]['places'].length > 0) {
        _selectedPlace = selectedPlace;
        _selectedThumbGallery = widget.data['countries'][_selectedDestination]
            ['places'][selectedPlace]['thumbGallery'];
        _selectedThumbVideo = widget.data['countries'][_selectedDestination]
            ['places'][selectedPlace]['thumbVideo'];
        _selectedThumbVe = widget.data['countries'][_selectedDestination]
            ['places'][selectedPlace]['thumbVe'];  // firebase
        _selectedPlaceImage = widget.data['countries'][_selectedDestination]
            ['places'][selectedPlace]['image'];
        _selectedPlaceName = widget.data['countries'][_selectedDestination]
            ['places'][selectedPlace]['name'][widget.lang];
      }
    }
  }

  void _updateAllGallery() {
    allGallery.clear();
    allVideos.clear();
    allVr.clear();

    for (var property in widget.data['countries'][_selectedDestination]
        ['places'][_selectedPlace]['properties']) {
      allGallery.addAll(property['media']['gallery']);

      allVideos.addAll(
        property['media']['videos'].map((video) => {
              'video': video['video'],
              'cover': video['cover'],
              'title': '',
            }),
      );

      if (property['media']['ver_exp'] != null) {
        allVr.addAll(property['media']['ver_exp']);
      }

    }
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    _hasCountries = widget.data['countries'] != null;
    _hasPlaces = _hasCountries &&
        widget.data['countries'][_selectedDestination]['places'] != null;
    _hasProperties = _hasPlaces &&
        widget.data['countries'][_selectedDestination]['places'][_selectedPlace]
                ['properties'] !=
            null;

    return SizedBox(
      width: size.width,
      child: _isLoading
          ? const LoadingComponent()
          : Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisSize: MainAxisSize.max,
              children: [
                _hasCountries
                    ? FadeInAnimation(
                        delay: const Duration(milliseconds: 700),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 80),
                          child: Row(mainAxisSize: MainAxisSize.min, children: [
                            ...widget.data['countries']
                                .asMap()
                                .entries
                                .map<Widget>((entry) {
                              return CountryItem(
                                lang: widget.lang,
                                country: entry.value,
                                index: entry.key,
                                onTap: _changeDestination,
                                isSelected: _selectedDestination == entry.key,
                              );
                            }).toList(),
                          ]),
                        ),
                      )
                    : NoData(
                        title: tr(
                            context, 'errors.No Countries found', widget.lang)),

                //update here Latest
                _hasPlaces
                    ? SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: Wrap(direction: Axis.horizontal, children: [
                          ...widget.data['countries'][_selectedDestination]
                                  ['places']
                              .asMap()
                              .entries
                              .map<Widget>((entry) {
                            return PlaceItem(
                              lang: widget.lang,
                              place: entry.value,
                              index: entry.key,
                              onTap: _changePlace,
                              destination: _selectedDestination,
                              animate: _placeAnimate,
                              isSelected: _selectedPlace == entry.key,
                              placeCount: widget
                                  .data['countries'][_selectedDestination]
                                      ['places']
                                  .length,
                            );
                          }).toList(),
                        ]),
                      )
                    : NoData(
                        title:
                            tr(context, 'errors.No place found', widget.lang)),

                _hasProperties
                    ? FadeInAnimation(
                        visibilityThreshold: 0.3,
                        child: Container(
                          decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: NetworkImage('${AppAPI.baseUrlGcp}$_selectedPlaceImage'),
                                  fit: BoxFit.cover,
                                  alignment: Alignment.topCenter)),
                          child: Container(
                            width: size.width,
                            padding: const EdgeInsets.symmetric(vertical: 80),
                            decoration: BoxDecoration(
                              gradient: LinearGradient(
                                colors: [
                                  AppColors.black.withValues(alpha: 0.2),
                                  AppColors.black.withValues(alpha: 0.2)
                                ],
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                              ),
                            ),
                            child: Column(
                              crossAxisAlignment: widget
                                          .data['countries']
                                              ?[_selectedDestination]?['places']
                                              ?[_selectedPlace]?['properties']
                                          ?.length >
                                      4
                                  ? CrossAxisAlignment.start
                                  : CrossAxisAlignment.center,
                              children: [
                                Center(
                                  child: CustomText(
                                    label:
                                        '${widget.data["properties_title"][widget.lang]}$_selectedPlaceName',
                                    type: 'h3',
                                    isSerif: true,
                                    textStyle:
                                        const TextStyle(color: AppColors.white),
                                  ),
                                ),
                                const SizedBox(
                                  height: 80,
                                ),
                                SingleChildScrollView(
                                  scrollDirection: Axis.horizontal,
                                  child: Wrap(spacing: 20, children: [
                                    const SizedBox(
                                      width: 80,
                                    ),
                                    ...widget.data['countries']
                                            [_selectedDestination]['places']
                                            [_selectedPlace]['properties']
                                        .asMap()
                                        .entries
                                        .map<Widget>((entry) {
                                      int index = entry.key;
                                      var property = entry.value;

                                      return GestureDetector(
                                        onTap: () {
                                          Navigator.pushNamed(
                                            context,
                                            '/destination-property',
                                            arguments: {
                                              'property': property,
                                              'cardTitles':
                                                  widget.data['cardTitles'],
                                              'propertyCardTitles': widget
                                                  .data['propertyCardTitles'],
                                              'lang': widget.lang
                                            },
                                          );
                                        },
                                        child: index < 4
                                            ? SlideInAnimation(
                                                visibilityThreshold: 0.3,
                                                direction: SlideDirection.right,
                                                delay: Duration(
                                                    milliseconds: 100 * index),
                                                child: PropertyItem(
                                                  title: property['name']
                                                      [widget.lang],
                                                  image: property['thumbBg'],
                                                  propertyCount: widget
                                                      .data['countries']
                                                          [_selectedDestination]
                                                          ['places']
                                                          [_selectedPlace]
                                                          ['properties']
                                                      .length,
                                                ),
                                              )
                                            : PropertyItem(
                                                title: property['name']
                                                    [widget.lang],
                                                image: property['thumbBg'],
                                                propertyCount: widget
                                                    .data['countries']
                                                        [_selectedDestination]
                                                        ['places']
                                                        [_selectedPlace]
                                                        ['properties']
                                                    .length,
                                              ),
                                      );
                                    }).toList(),
                                    const SizedBox(
                                      width: 80,
                                    ),
                                  ]),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    : NoData(
                        title: tr(context, 'errors.No Properties found',
                            widget.lang)),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.fromLTRB(80, 80, 80, 120),
                    child: Wrap(
                      spacing: 40,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SlideInAnimation(
                          child: MainMediaItem(
                            width: size.width / 4,
                            thumb: _selectedThumbGallery,
                            title: widget.data["cardTitles"]['Gallery']
                                [widget.lang],
                            onTap: () {
                              allGallery.isNotEmpty
                                  ? Navigator.pushNamed(
                                      context,
                                      '/destination-gallery',
                                      arguments: {
                                        'assets': allGallery,
                                        'placeName': widget.data['countries']
                                                [_selectedDestination]['places']
                                            [_selectedPlace]['name'],
                                        'title': widget.data["cardTitles"]
                                            ['Gallery'],
                                        'columns': 3,
                                        'gap': 20,
                                        'childRatio': 3 / 1.7,
                                      },
                                    )
                                  : CustomSnackBar(
                                      message: tr(
                                          context,
                                          'errors.Content not available',
                                          widget.lang),
                                      context: context,
                                    );
                            },
                          ),
                        ),
                        SlideInAnimation(
                          delay: const Duration(milliseconds: 100),
                          child: MainMediaItem(
                            width: size.width / 4,
                            thumb: _selectedThumbVideo,
                            title: widget.data["cardTitles"]
                                ['Destination Videos'][widget.lang],
                            onTap: () {
                              allVideos.isNotEmpty
                                  ? Navigator.pushNamed(
                                      context,
                                      '/destination-videos',
                                      arguments: {
                                        'assets': allVideos,
                                        'placeName': widget.data['countries']
                                                [_selectedDestination]['places']
                                            [_selectedPlace]['name'],
                                        'title': widget.data["cardTitles"]
                                            ['Destination Videos'],
                                        'columns': 3,
                                        'gap': 10,
                                        'childRatio': 3 / 1.7,
                                      },
                                    )
                                  : CustomSnackBar(
                                      message: tr(
                                          context,
                                          'errors.Content not available',
                                          widget.lang),
                                      context: context,
                                    );
                            },
                          ),
                        ),

                        //update this when ver_exp data added to properties //Latest
                        (isVirtualExperience)?
                        SlideInAnimation(
                          delay: const Duration(milliseconds: 200),
                          child: MainMediaItem(
                            width: size.width / 4,
                            thumb: _selectedThumbVe,
                            title: widget.data["cardTitles"]
                                ['Virtual Experience'][widget.lang],
                            onTap: () {
                              final verExp = widget.data['countries']
                              [_selectedDestination]['places']
                              [_selectedPlace]['properties'][0]['media']?['ver_exp'] ?? [];

                              if (verExp.isNotEmpty) {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (_) => WebView3dvrScreen(url: verExp[0]),
                                  ),
                                );
                              } else {
                                CustomSnackBar(
                                  message: tr(context, 'errors.Content not available', widget.lang),
                                  context: context,
                                );
                              }
                            },
                          ),
                        ):Container(),
                      ],
                    ),
                  ),
                ),
              ],
            ),
    );
  }
}
