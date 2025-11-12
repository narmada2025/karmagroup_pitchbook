import 'package:flutter/material.dart';
import 'package:pitchbook/components/video_grid_title_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/go_back.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/src/app_locatizations.dart';

class DestinationsVideoWidget extends StatefulWidget {
  final Map<String, dynamic> args;

  const DestinationsVideoWidget(
    this.args, {
    super.key,
  });

  @override
  State<DestinationsVideoWidget> createState() =>
      _DestinationsVideoWidgetState();
}

class _DestinationsVideoWidgetState extends State<DestinationsVideoWidget> {
  bool isVideoPlaying = false;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;
    // print('======destinationVideooss \n ----${widget.args}-\n--${widget.args['assets']}');

    return Scaffold(
      backgroundColor: AppColors.black,
      body: Stack(
        children: [
          Container(
            constraints:
                BoxConstraints(minWidth: size.width, minHeight: size.height),
            padding: const EdgeInsets.fromLTRB(85, 140, 70, 0),
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  widget.args['assets'] != null
                      ? VideoGridTitleWidget(
                          key: ValueKey(widget.args['title'][lang]),
                          data: widget.args['assets'],
                          columns: 3,
                          gap: 20,
                          scrollGapX: 0,
                          useGrid: true,
                          initialItemCount: 9,
                          loadMoreCount: 9,
                          textAlign: Alignment.bottomCenter,
                          titleBoxPadding:
                              const EdgeInsets.fromLTRB(20, 15, 20, 15),
                          titleBoxDecoration: const BoxDecoration(
                            color: Color.fromARGB(71, 0, 0, 0),
                          ),
                        )
                      : NoData(
                          title: tr(
                              context, 'errors.Content not available', lang)),
                  const SizedBox(
                    height: 100,
                  )
                ],
              ),
            ),
          ),
          GoBack(
            title:
                '${widget.args['title'][lang]}: ${widget.args['placeName'][lang]}',
            isSerif: true,
          ),
        ],
      ),
    );
  }
}
