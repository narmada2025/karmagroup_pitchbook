import 'package:flutter/material.dart';
import 'package:pitchbook/components/gallery_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/go_back.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/src/app_locatizations.dart';

class DestinationsFacilitiesWidget extends StatefulWidget {
  final Map<String, dynamic> args;

  const DestinationsFacilitiesWidget(
    this.args, {
    super.key,
  });

  @override
  State<DestinationsFacilitiesWidget> createState() =>
      _DestinationsFacilitiesWidgetState();
}

class _DestinationsFacilitiesWidgetState
    extends State<DestinationsFacilitiesWidget> {
  int _selectedFacilityIndex = 0;
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(viewportFraction: 0.86);
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    String title = '';
    String description = '';

    if (widget.args['assets'] != null &&
        _selectedFacilityIndex < widget.args['assets'].length) {
      title = widget.args['assets'][_selectedFacilityIndex]['title'];
      description =
          widget.args['assets'][_selectedFacilityIndex]['description'];
    }

    List<String> getImages() {
      if (widget.args['assets'] != null &&
          _selectedFacilityIndex < widget.args['assets'].length) {
        return widget.args['assets'][_selectedFacilityIndex]['images']
            .cast<String>();
      } else {
        List<String> imageUrls = [];
        if (widget.args['assets'] != null) {
          for (var asset in widget.args['assets']) {
            imageUrls.addAll(asset['images'].cast<String>());
          }
        }
        return imageUrls;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(children: [
        Container(
          width: size.width,
          height: size.height,
          padding: const EdgeInsets.fromLTRB(0, 80, 0, 0),
          child: widget.args['assets'] != null
              ? Column(
                  children: [
                    const SizedBox(height: 60),
                    if (title != '')
                      CustomText(
                        label: title,
                        type: 'h5',
                        isSerif: true,
                        textStyle: const TextStyle(color: AppColors.primary),
                      ),
                    if (description != '') const SizedBox(height: 10),
                    if (description != '')
                      CustomText(
                        label: description,
                        type: 'sm',
                        textStyle: const TextStyle(color: AppColors.secondary),
                      ),
                    if (description != '') const SizedBox(height: 20),
                    SizedBox(
                      width: size.width,
                      height: size.height / 1.4,
                      child: getImages().isNotEmpty
                          ? GalleryWidget<String>(
                              items: getImages(),
                              gap: 20,
                              viewportFraction: 0.86,
                              pageController: _pageController,
                              itemBuilder: (String imageUrl) {
                                return Image.network(
                                  '${AppAPI.baseUrlGcp}$imageUrl',
                                  fit: BoxFit.cover,
                                  width: size.width,
                                );
                              },
                              isSlider: true,
                            )
                          : NoData(
                              title: tr(
                                  context, 'errors.No Images available', lang)),
                    ),
                  ],
                )
              : Center(
                  child: CustomText(
                  label: tr(context, 'errors.Content not available', lang),
                  type: 'h6',
                  textStyle: const TextStyle(color: AppColors.white),
                )),
        ),
        GoBack(
          title: widget.args['title'][lang],
          isSerif: true,
        ),
        Positioned(
          top: 75,
          right: 80,
          child: Container(
            alignment: Alignment.centerRight,
            width: size.width / 1.5,
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Wrap(
                spacing: 14,
                children: [
                  for (int i = 0; i < (widget.args['assets']?.length ?? 0); i++)
                    GestureDetector(
                      onTap: () {
                        setState(() {
                          _selectedFacilityIndex = i;
                          _pageController.animateToPage(
                            0,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                          );
                        });
                      },
                      child: Container(
                        padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: AppColors.primary, width: 0.5),
                          borderRadius: BorderRadius.circular(30),
                          color: _selectedFacilityIndex == i
                              ? AppColors.primary
                              : Colors.transparent,
                        ),
                        child: CustomText(
                            label: widget.args['assets'][i]['category']
                                    ?[lang] ??
                                '',
                            type: 'sm',
                            textStyle: TextStyle(
                              fontWeight: FontWeight.w500,
                              color: _selectedFacilityIndex == i
                                  ? AppColors.white
                                  : AppColors.primary,
                            )),
                      ),
                    ),
                ],
              ),
            ),
          ),
        ),
      ]),
    );
  }
}
