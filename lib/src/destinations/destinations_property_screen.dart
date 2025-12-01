import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/pdf_screen.dart';
import 'package:pitchbook/components/slide_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/go_back.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/app_locatizations.dart';
import 'package:pitchbook/src/destinations/widgets/feature_item.dart';

import '../../components/webView_3d_vr_screen.dart';
import '../../constants/custom_snackbar.dart';

class DestinationsPropertyScreen extends StatefulWidget {
  final Map<String, dynamic> args;

  const DestinationsPropertyScreen(this.args, {super.key});

  @override
  State<DestinationsPropertyScreen> createState() =>
      _DestinationsPropertyScreenState();
}

class _DestinationsPropertyScreenState
    extends State<DestinationsPropertyScreen> {
  late Map<String, dynamic> cardTitles = {};
  late Map<String, dynamic> propertyCardTitles = {};
  late Map<String, dynamic> property = {};
  late Map<String, dynamic> _media;
  late Map<String, dynamic> _features;
  late final List<dynamic> _videos = [];
  late final List<dynamic> _vrVideos = [];
  bool isVirtualExperience =false;
  String countryNameVR="";

  @override
  void initState() {
    super.initState();
    cardTitles = widget.args['cardTitles'];
    propertyCardTitles = widget.args['propertyCardTitles'];
    property = widget.args['property'];
    _media = widget.args['property']['media'];
    _features = widget.args['property']['features'];

    _videos.addAll(
      widget.args['property']['media']['videos'].map((video) => {
            'video': video['video'], // here need to add firebase video link
            'cover': video['cover'],
            'title': '',
          }),
    );

    _vrVideos.addAll(
        (widget.args['property']['media']['ver_exp'] as List)
    );

    isVirtualExperience =
        widget.args['property']['media']['ver_exp'] != null &&
            widget.args['property']['media']['ver_exp'].isNotEmpty;

    // if(_vrVideos.isEmpty){
    //   print("====_media11 ${_media["ver_exp"]}" );
    //   print("====_media_vrVideos ${_vrVideos}" );
    // }
    // else{
    //   print("else====_media11 ${_media["ver_exp"]}" );
    //   print("else====_vrVideos_media11 ${_vrVideos}" );
    // }
  }

  getField(field) {
    return widget.args['property'][field] ?? '';
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    void onTapped(String path, Map<String, dynamic> title) async {
      final nav = Navigator.of(context);
      final lang = Localizations.localeOf(context).languageCode;
      final failedMsg = tr(context, 'Failed to load PDF', lang);

      try {
        String finalPath;

        if (path.startsWith('http')) {
          finalPath = path;
        } else if (path.endsWith('.pdf')) {
          finalPath = '${AppAPI.baseUrlGcp}$path';
        } else {
          // This is the async gap
          finalPath = await loadPdfFromAssets(path);
        }

        // ✅ Guard context after async gap
        if (!context.mounted) return;

        nav.push(
          MaterialPageRoute(
            builder: (context) => PdfScreen(
              pdfPath: finalPath,
              title: title,
            ),
          ),
        );
      } catch (e) {
        if (!context.mounted) return;
        CustomSnackBar(
          message: '$failedMsg: $e',
          context: context,
        );
      }
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          SizedBox(
            width: size.width,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                children: [
                  FadeInAnimation(
                    child: Container(
                      width: size.width,
                      height: size.height / 1.5,
                      alignment: Alignment.bottomCenter,
                      decoration: BoxDecoration(
                        image: DecorationImage(
                          image: NetworkImage('${AppAPI.baseUrlGcp}${property['image']}'),
                          fit: BoxFit.cover,
                          alignment: Alignment.topCenter,
                        ),
                      ),
                      child: Container(
                        padding: const EdgeInsets.all(20),
                        decoration: BoxDecoration(
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(8),
                            topRight: Radius.circular(8),
                          ),
                          color: AppColors.black.withValues(alpha: 0.8),
                        ),
                        child: Wrap(
                          spacing: 30,
                          alignment: WrapAlignment.center,
                          crossAxisAlignment: WrapCrossAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                               // print("===_media name ${_media['gallery']} ");
                               // print("===property name $property ");
                               // for (var p in property['name']) {
                               //   print("property: $p");
                               // }
                                _media['gallery'].length > 0
                                    ? Navigator.pushNamed(
                                        context,
                                        '/destination-gallery-Icon',
                                        arguments: {
                                          'assets': _media['gallery'],
                                          'placeName': property['name'],
                                          'title': cardTitles['Gallery'],
                                          'columns': 3,
                                          'gap': 20,
                                          'childRatio': 3 / 2
                                        },
                                      )
                                    : CustomSnackBar(
                                        message: tr(
                                            context,
                                            'errors.Content not available',
                                            lang),
                                        context: context,
                                      );
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                padding: const EdgeInsets.all(20),
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(50)),
                                child: SvgPicture.asset(
                                  AppIcons.imageIcon,
                                  width: 30,
                                  fit: BoxFit.contain,
                                  semanticsLabel: 'vr',
                                  placeholderBuilder: (context) =>
                                      const CircularProgressIndicator(),
                                ),
                              ),
                            ),
                            (_videos.isNotEmpty)?
                            InkWell(
                              onTap: () {
                                _media['videos'].length > 0
                                    ? Navigator.pushNamed(
                                        context,
                                        '/destination-videos',
                                        arguments: {
                                          'assets': _videos,
                                          'placeName': property['name'],
                                          'title':
                                              cardTitles['Destination Videos'],
                                          'columns': 3,
                                          'gap': 10,
                                          'childRatio': 3 / 1.7,
                                        },
                                      )
                                    : CustomSnackBar(
                                        message: tr(
                                            context,
                                            'errors.Content not available',
                                            lang),
                                        context: context,
                                      );
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                padding:
                                    const EdgeInsets.fromLTRB(22, 18, 18, 18),
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(50)),
                                child: SvgPicture.asset(
                                  AppIcons.playIcon,
                                  width: 30,
                                  fit: BoxFit.contain,
                                  semanticsLabel: 'vr',
                                  placeholderBuilder: (context) =>
                                      const CircularProgressIndicator(),
                                ),
                              ),
                            ):Container(),
                          //Latest
                            (isVirtualExperience)
                                ? InkWell(
                              onTap: () {
                                final verExp = widget.args['property']['media']['ver_exp'];

                                if (verExp.isNotEmpty) {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          WebView3dvrScreen(url: verExp[0]),
                                    ),
                                  );
                                } else {
                                  CustomSnackBar(
                                    message: tr(context,
                                        'errors.Content not available', lang),
                                    context: context,
                                  );
                                }
                              },
                              child: Container(
                                width: 60,
                                height: 60,
                                padding: const EdgeInsets.all(15),
                                decoration: BoxDecoration(
                                    color: AppColors.primary,
                                    borderRadius: BorderRadius.circular(50)),
                                child: SvgPicture.asset(
                                  AppIcons.vrIcon,
                                  width: 30,
                                  fit: BoxFit.contain,
                                ),
                              ),
                            )
                                : Container(),
                          ],
                        ),
                      ),
                    ),
                  ),
                  FadeInAnimation(
                    visibilityThreshold: 1,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(80, 100, 80, 0),
                      width: size.width / 1.2,
                      child: CustomText(
                        label: property['name'][lang],
                        type: 'h2',
                        textStyle: const TextStyle(color: AppColors.primary),
                        isSerif: true,
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                  FadeInAnimation(
                    visibilityThreshold: 0.3,
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(80, 30, 80, 40),
                      width: size.width / 1.2,
                      child: CustomText(
                        label: property['description'][lang],
                        textStyle: const TextStyle(color: AppColors.white),
                        textAlign: TextAlign.center,
                        maxLines: 7,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.fromLTRB(80, 20, 80, 80),
                    child: Wrap(
                      spacing: 20,
                      alignment: WrapAlignment.center,
                      crossAxisAlignment: WrapCrossAlignment.center,
                      children: [
                        SlideInAnimation(
                          distance: 0.3,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              _features["accommodation"].length > 0
                                  ? Navigator.pushNamed(
                                      context,
                                      '/destination-accommodation',
                                      arguments: {
                                        'assets': _features["accommodation"],
                                        'title':
                                            propertyCardTitles['Accommodation'],
                                        'columns': 3,
                                        'gap': 20,
                                        'childRatio': 3 / 1.7,
                                      },
                                    )
                                  : CustomSnackBar(
                                      message: tr(context,
                                          'errors.Content not available', lang),
                                      context: context,
                                    );
                            },
                            child: FeatureItem(
                              title: propertyCardTitles['Accommodation'][lang],
                              image: _features['accImage'],
                              width: size.width / 4,
                            ),
                          ),
                        ),
                        SlideInAnimation(
                          delay: const Duration(milliseconds: 100),
                          distance: 0.3,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              _features["facilities"].length > 0
                                  ? Navigator.pushNamed(
                                      context,
                                      '/destination-facilities',
                                      arguments: {
                                        'assets': _features["facilities"],
                                        'title':
                                            propertyCardTitles['Facilities'],
                                      },
                                    )
                                  : CustomSnackBar(
                                      message: tr(context,
                                          'errors.Content not available', lang),
                                      context: context,
                                    );
                            },
                            child: FeatureItem(
                              title: propertyCardTitles['Facilities'][lang],
                              image: _features['facImage'],
                              width: size.width / 4,
                            ),
                          ),
                        ),
                        (property['guestExp'] != "")?
                        SlideInAnimation(
                          delay: const Duration(milliseconds: 200),
                          distance: 0.3,
                          child: InkWell(
                            splashColor: Colors.transparent,
                            onTap: () {
                              onTapped('${AppAPI.baseUrlGcp}${property['guestExp']}', property['name']);

                              // _features["Guest Experiences"].length > 0
                              //     ? Navigator.pushNamed(
                              //         context,
                              //         '/destination-guest-exp',
                              //         arguments: {
                              //           'assets': _features["Guest Experiences"],
                              //           'title': propertyCardTitles['Guest Experiences'],
                              //         },
                              //       )
                              //     : CustomSnackBar(
                              //         message: tr(context, 'errors.Content not available', lang),
                              //         context: context,
                              //       );
                            },
                            child: FeatureItem(
                              title: propertyCardTitles['Guest Experiences']
                                  [lang],
                              image: _features['gueImage'],
                              width: size.width / 4,
                            ),
                          ),
                        ):Container(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
          const GoBack()
        ],
      ),
    );
  }
}
