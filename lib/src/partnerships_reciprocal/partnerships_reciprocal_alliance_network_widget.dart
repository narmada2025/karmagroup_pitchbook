import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/components/slide_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/app_locatizations.dart';

class PartnershipReciprocalAllianceNetworkWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String lang;

  const PartnershipReciprocalAllianceNetworkWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  State<PartnershipReciprocalAllianceNetworkWidget> createState() =>
      _PartnershipReciprocalAllianceNetworkWidgetState();
}

class _PartnershipReciprocalAllianceNetworkWidgetState
    extends State<PartnershipReciprocalAllianceNetworkWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.symmetric(vertical: 60),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            width: size.width / 1.8,
            padding: const EdgeInsets.fromLTRB(60, 40, 60, 0),
            child: FadeInAnimation(
              child: CustomText(
                label: widget.data['title'][widget.lang],
                type: 'h2',
                textStyle: const TextStyle(color: AppColors.primary),
                textAlign: TextAlign.center,
                isSerif: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Container(
            width: size.width,
            padding: const EdgeInsets.fromLTRB(80, 0, 80, 0),
            child: FadeInAnimation(
              child: CustomText(
                label: widget.data['description'][widget.lang],
                textAlign: TextAlign.center,
                textStyle: const TextStyle(color: AppColors.white),
              ),
            ),
          ),
          const SizedBox(height: 40),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Wrap(
                spacing: 20,
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  const SizedBox(width: 60),
                  ...widget.data['network'] != null
                      ? widget.data['network']
                          .asMap()
                          .entries
                          .map<Widget>((entry) {
                          int index = entry.key;

                          return InkWell(
                            onTap: () => launchUrlInBrowser(
                                context, entry.value['url']!),
                            child: index < 4
                                ? SlideInAnimation(
                                    direction: SlideDirection.right,
                                    delay: Duration(milliseconds: 100 * index),
                                    child: Container(
                                      width: size.width / 4,
                                      constraints:
                                          const BoxConstraints(minHeight: 400),
                                      clipBehavior: Clip.antiAlias,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(6),
                                        image: DecorationImage(
                                          image:
                                              NetworkImage('${AppAPI.baseUrlGcp}${entry.value['image']!}'),
                                          fit: BoxFit.cover,
                                        ),
                                      ),
                                      child: Container(
                                        padding: const EdgeInsets.all(20),
                                        alignment: Alignment.bottomCenter,
                                        color: AppColors.black
                                            .withValues(alpha: 0.2),
                                        child: CustomText(
                                          label:
                                              entry.value['name']![widget.lang],
                                          type: 'h3',
                                          isSerif: true,
                                          textStyle: const TextStyle(
                                              color: AppColors.white),
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: size.width / 4,
                                    constraints:
                                        const BoxConstraints(minHeight: 400),
                                    clipBehavior: Clip.antiAlias,
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(6),
                                      image: DecorationImage(
                                        image:
                                            NetworkImage('${AppAPI.baseUrlGcp}${entry.value['image']!}'),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    child: Container(
                                      padding: const EdgeInsets.all(20),
                                      alignment: Alignment.bottomCenter,
                                      color: AppColors.black
                                          .withValues(alpha: 0.2),
                                      child: CustomText(
                                        label:
                                            entry.value['name']![widget.lang],
                                        type: 'h3',
                                        isSerif: true,
                                        textStyle: const TextStyle(
                                            color: AppColors.white),
                                        textAlign: TextAlign.center,
                                      ),
                                    ),
                                  ),
                          );
                        }).toList()
                      : [
                          NoData(
                              title: tr(context, 'errors.Content not available',
                                  widget.lang))
                        ],
                  const SizedBox(width: 60),
                ]),
          ),
        ],
      ),
    );
  }
}
