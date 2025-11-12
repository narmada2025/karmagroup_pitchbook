import 'package:flutter/material.dart';
import 'package:pitchbook/components/gallery_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_btn.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/go_back.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/src/app_locatizations.dart';

enum ViewType { grid, slider }

class DestinationsAccommodationWidget extends StatefulWidget {
  final Map<String, dynamic> args;
  final ViewType viewType;

  const DestinationsAccommodationWidget(
    this.args, {
    super.key,
    this.viewType = ViewType.grid,
  });

  @override
  State<DestinationsAccommodationWidget> createState() =>
      _DestinationsAccommodationWidgetState();
}

class _DestinationsAccommodationWidgetState
    extends State<DestinationsAccommodationWidget> {
  int _selectedAccommodationIndex = -1;
  bool _isGridView = true;
  bool showAllItems = true;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    void toggleView() {
      setState(() {
        _isGridView = !_isGridView;
      });
    }

    List<String> getImages() {
      if (_selectedAccommodationIndex != -1) {
        return widget.args['assets'][_selectedAccommodationIndex]['images']
            .cast<String>();
      } else {
        List<String> imageUrls = [];
        for (var asset in widget.args['assets']) {
          imageUrls.addAll(asset['images'].cast<String>());
        }
        return imageUrls;
      }
    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(children: [
        Container(
          constraints:
              BoxConstraints(minWidth: size.width, minHeight: size.height),
          padding: _isGridView
              ? const EdgeInsets.fromLTRB(80, 140, 80, 0)
              : const EdgeInsets.fromLTRB(0, 120, 0, 0),
          child: _isGridView
              ? SingleChildScrollView(
                  scrollDirection:
                      _isGridView ? Axis.vertical : Axis.horizontal,
                  child: getImages().isNotEmpty
                      ? Column(
                          children: [
                            GalleryWidget<String>(
                              items: getImages(),
                              columns: widget.args['columns'],
                              childRatio: 3 / 1.65,
                              bottomSpace: 80,
                              itemBuilder: (String imageUrl) {
                                return Image.network('${AppAPI.baseUrlGcp}$imageUrl');
                              },
                              hasPopup: true,
                              showAllItems: showAllItems,
                            ),
                            if (!showAllItems)
                              CustomBtn(
                                  label: tr(context, 'labels.view_all', lang),
                                  btnType: BtnType.primary,
                                  onPressed: () {
                                    setState(() {
                                      showAllItems = !showAllItems;
                                    });
                                  }),
                            if (!showAllItems)
                              const SizedBox(
                                height: 80,
                              )
                          ],
                        )
                      : NoData(
                          title: tr(
                              context, 'errors.Content not available', lang)),
                )
              : getImages().isNotEmpty
                  ? GalleryWidget<String>(
                      items: getImages(),
                      gap: 20,
                      bottomSpace: 80,
                      itemBuilder: (String imageUrl) {
                        return Image.network(
                          '${AppAPI.baseUrlGcp}$imageUrl',
                          height: size.height / 1.3,
                        );
                      },
                      isSlider: true,
                      viewportFraction: 0.86,
                    )
                  : NoData(
                      title: tr(context, 'errors.Content not available', lang)),
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
            width: size.width / 2,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              mainAxisSize: MainAxisSize.max,
              children: [
                GestureDetector(
                  onTap: toggleView,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    child: Icon(
                      _isGridView
                          ? Icons.view_carousel_outlined
                          : Icons.grid_view,
                      color: AppColors.primary,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 34,
                ),
                Flexible(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Wrap(
                      crossAxisAlignment: WrapCrossAlignment.end,
                      spacing: 14,
                      children: [
                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _selectedAccommodationIndex = -1;
                            });
                          },
                          child: Container(
                            padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: AppColors.primary, width: 0.5),
                              borderRadius: BorderRadius.circular(30),
                              color: _selectedAccommodationIndex == -1
                                  ? AppColors.primary
                                  : Colors.transparent,
                            ),
                            child: CustomText(
                              label: tr(context, 'labels.all', lang),
                              type: 'sm',
                              textStyle: TextStyle(
                                fontWeight: FontWeight.w500,
                                color: _selectedAccommodationIndex == -1
                                    ? AppColors.white
                                    : AppColors.primary,
                              ),
                            ),
                          ),
                        ),
                        for (int i = 0;
                            i < (widget.args['assets']?.length ?? 0);
                            i++)
                          GestureDetector(
                            onTap: () {
                              setState(() {
                                _selectedAccommodationIndex = i;
                              });
                            },
                            child: Container(
                              padding: const EdgeInsets.fromLTRB(24, 6, 24, 6),
                              decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.primary, width: 0.5),
                                borderRadius: BorderRadius.circular(30),
                                color: _selectedAccommodationIndex == i
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
                                  color: _selectedAccommodationIndex == i
                                      ? AppColors.white
                                      : AppColors.primary,
                                ),
                              ),
                            ),
                          ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ]),
    );
  }
}
