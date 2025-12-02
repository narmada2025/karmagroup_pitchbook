import 'package:flutter/material.dart';
import 'package:pitchbook/components/gallery_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/go_back.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/src/app_locatizations.dart';

import '../../constants/custom_btn.dart';
import '../../constants/custom_text.dart';

class DestinationsGalleryWidget extends StatefulWidget {
  final Map<String, dynamic> args;

  const DestinationsGalleryWidget(this.args, {super.key});

  @override
  State<DestinationsGalleryWidget> createState() => _DestinationsGalleryWidgetState();
}

class _DestinationsGalleryWidgetState extends State<DestinationsGalleryWidget> {
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

   List<dynamic> getImages() {
     var properties = widget.args['properties'];
       if (_selectedAccommodationIndex != -1) {
        return widget.args['properties'][_selectedAccommodationIndex]['media']['gallery'].cast<String>();
       }
     else{
       List<dynamic> imageUrls = [];

       for (var asset in properties) {
         if (asset['media']['gallery'] != null && asset['media']['gallery'].toString().isNotEmpty) {
           // imageUrls.add(asset['media']['gallery'].toString());
           imageUrls = asset['media']['gallery'];
         }
       }
       return imageUrls;
     }

    }

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Container(
            constraints:
                BoxConstraints(minWidth: size.width, minHeight: size.height),
            padding: _isGridView
                ? const EdgeInsets.fromLTRB(80, 140, 80, 0)
                : const EdgeInsets.fromLTRB(0, 120, 0, 0),
            child: _isGridView
                ?SingleChildScrollView(
              scrollDirection:
              _isGridView ? Axis.vertical : Axis.horizontal,
              // child: widget.args['assets'] != null
              child:  getImages().isNotEmpty
                  ? Column(
                    children: [
                      GalleryWidget<dynamic>(
                          items: getImages(),
                          columns: widget.args['columns'],
                          childRatio: 3 / 1.65,
                          bottomSpace: 80,
                          itemBuilder: (dynamic imageUrl) {
                            return Image.network(
                              '${AppAPI.baseUrlGcp}$imageUrl',
                              fit: BoxFit.cover,
                            );
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
                      title: tr(context, 'errors.Content not available', lang)),
            ): getImages().isNotEmpty
                ? GalleryWidget<dynamic>(
              items: getImages(),
              gap: 20,
              bottomSpace: 80,
              itemBuilder: (dynamic imageUrl) {
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
            title: '${widget.args['title'][lang]}: ${widget.args['placeName'][lang]}',
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
                          i < (widget.args['properties']?.length ?? 0);
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
                                  label: widget.args['properties'][i]['name']?[lang] ??
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
        ],
      ),
    );
  }
}
