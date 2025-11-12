import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/components/video_grid_title_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/go_back.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/src/app_locatizations.dart';

class DestinationsVirtualExpWidget extends StatelessWidget {
  final Map<String, dynamic> args;

  const DestinationsVirtualExpWidget(this.args, {super.key});

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
            width: size.width,
            padding: const EdgeInsets.fromLTRB(80, 120, 80, 40),
            child: args['assets'] != null
                ? VideoGridTitleWidget(
                    data: args['assets'],
                    columns: 3,
                    gap: 20,
                    scrollGapX: 55,
                    useGrid: true,
                    initialItemCount: 12,
                    loadMoreCount: 12,
                    textAlign: Alignment.bottomCenter,
                    thumbIcon: ClipRRect(
                      borderRadius: BorderRadius.circular(50.0),
                      child: BackdropFilter(
                        filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
                        child: Container(
                          width: 60,
                          height: 60,
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                              color: AppColors.white.withValues(alpha: 0.2),
                              borderRadius: BorderRadius.circular(50)),
                          child: SvgPicture.asset(
                            AppIcons.vrIcon,
                            width: 30,
                            fit: BoxFit.contain,
                            semanticsLabel: 'vr',
                            placeholderBuilder: (context) =>
                                const CircularProgressIndicator(),
                          ),
                        ),
                      ),
                    ),
                  )
                : NoData(
                    title: tr(context, 'errors.Content not available', lang)),
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
