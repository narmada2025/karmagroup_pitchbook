import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_btn.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/src/app_locatizations.dart';
import 'package:pitchbook/src/community/widgets/gallery_online_widget.dart';

class CommunityEventImagesWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String lang;

  final List<dynamic> galleryData;

  const CommunityEventImagesWidget({
    super.key,
    required this.galleryData,
    required this.data,
    required this.lang,
  });

  @override
  State<CommunityEventImagesWidget> createState() =>
      _CommunityEventImagesWidgetState();
}

class _CommunityEventImagesWidgetState
    extends State<CommunityEventImagesWidget> {
  bool _showAll = false;
  final int showFirst = 9;

  @override
  Widget build(BuildContext context) {
    List<dynamic> imagesList = _showAll
        ? widget.galleryData.toList()
        : widget.galleryData.take(showFirst).toList();

    return Container(
      padding: const EdgeInsets.fromLTRB(80, 80, 80, 60),
      alignment: Alignment.center,
      child: Column(
        children: [
          CustomText(
            label: widget.data['Event Images'][widget.lang],
            type: 'h2',
            textStyle: const TextStyle(color: AppColors.primary),
            textAlign: TextAlign.center,
            isSerif: true,
          ),
          const SizedBox(height: 50),
          GalleryOnlineWidget<String>(
            items: imagesList,
            columns: 3,
            gap: 20,
            hasPopup: true,
          ),
          const SizedBox(height: 50),
          if (imagesList.isNotEmpty && widget.galleryData.length > showFirst)
            SizedBox(
              child: CustomBtn(
                onPressed: () {
                  setState(() {
                    _showAll = !_showAll;
                  });
                },
                label: _showAll
                    ? tr(context, 'labels.view_less', widget.lang)
                    : tr(context, 'labels.view_all', widget.lang),
                btnType: BtnType.primary,
                borderRadius: 50,
              ),
            )
        ],
      ),
    );
  }
}
