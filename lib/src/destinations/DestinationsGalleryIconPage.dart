import 'package:flutter/material.dart';
import 'package:pitchbook/components/gallery_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/go_back.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/src/app_locatizations.dart';

class DestinationsGalleryIconPage extends StatelessWidget {
  final Map<String, dynamic> args;

  const DestinationsGalleryIconPage(this.args, {super.key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Container(
            constraints:
            BoxConstraints(minWidth: size.width, minHeight: size.height),
            padding: const EdgeInsets.fromLTRB(80, 140, 80, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: args['assets'] != null
                  ? GalleryWidget<String>(
                items: args['assets'].cast<String>(),
                columns: args['columns'],
                gap: args['gap'].toDouble(),
                childRatio: args['childRatio'].toDouble(),
                bottomSpace: 80,
                itemBuilder: (String imageUrl) {
                  return Image.network(
                    '${AppAPI.baseUrlGcp}$imageUrl',
                    fit: BoxFit.cover,
                  );
                },
                hasPopup: true,
              )
                  : NoData(
                  title: tr(context, 'errors.Content not available', lang)),
            ),
          ),
          GoBack(
            title: '${args['title'][lang]}: ${args['placeName'][lang]}',
            isSerif: true,
          ),
        ],
      ),
    );
  }
}
