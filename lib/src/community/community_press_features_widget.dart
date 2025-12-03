import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:pitchbook/components/image_network_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/helpers/helper.dart';

class CommunityPressFeaturesWidget extends StatefulWidget {
  final dynamic press;
  final Map<String, dynamic> data;
  final String lang;

  const CommunityPressFeaturesWidget({
    super.key,
    required this.press,
    required this.data,
    required this.lang,
  });

  @override
  State<CommunityPressFeaturesWidget> createState() =>
      _CommunityPressFeaturesWidgetState();
}

class _CommunityPressFeaturesWidgetState
    extends State<CommunityPressFeaturesWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String thumbnail = '';
    String title = '';

    if (widget.press != null && widget.press.length > 0) {
      thumbnail = widget.press[0]['thumbnail'];
      title = widget.press[0]['title'];
    }

    return Container(
      width: size.width,
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 40),
      constraints: BoxConstraints(
        minWidth: size.width,
      ),
      child: Wrap(
        runSpacing: 50,
        children: [
          Container(
            alignment: Alignment.center,
            child: CustomText(
              label: widget.data['Press Features'][widget.lang],
              type: 'h2',
              textStyle: const TextStyle(color: AppColors.primary),
              textAlign: TextAlign.center,
              isSerif: true,
            ),
          ),
          Stack(
            alignment: Alignment.topCenter,
            children: [
              ImageNetworkWidget(
                imageUrl: thumbnail,
                width: size.width,
                height: size.height / 1.6,
              ),
              Container(
                width: size.width,
                height: size.height / 1.2,
                color: AppColors.black.withValues(alpha: 0.6),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 220),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: CustomText(
                      label: widget.data['FEATURED PRESS'][widget.lang]
                          .toUpperCase(),
                      type: 'lg',
                      textStyle: const TextStyle(
                          color: AppColors.secondary,
                          fontWeight: FontWeight.w500),
                      isUppercase: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    width: size.width / 1.2,
                    child: CustomText(
                      label: title.replaceAll("&amp;", "&"),
                      type: 'h3',
                      textStyle: const TextStyle(
                          color: AppColors.white,
                          fontWeight: FontWeight.w600,
                          letterSpacing: -1.5),
                    ),
                  ),
                  const SizedBox(height: 30),
                  SizedBox(
                    width: size.width,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Wrap(spacing: 20, children: [
                        const SizedBox(width: 80),
                        ...widget.press.map<Widget>((item) {
                          return InkWell(
                            onTap: () {
                              launchUrlInBrowser(context, item["url"]);
                              log("title========== ${item["title"]}");
                              log("URL========== ${item["url"]}");
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.gray,
                              ),
                              clipBehavior: Clip.antiAlias,
                              width: size.width / 4.3,
                              height: 220,
                              child: ImageNetworkWidget(
                                imageUrl: item["thumbnail"],
                                child: Container(
                                  padding:
                                      const EdgeInsets.fromLTRB(20, 20, 20, 20),
                                  alignment: Alignment.bottomLeft,
                                  decoration: BoxDecoration(
                                    gradient: LinearGradient(
                                      colors: [
                                        AppColors.black.withValues(alpha: 0),
                                        AppColors.black.withValues(alpha: 0.4),
                                        AppColors.black.withValues(alpha: 0.8)
                                      ],
                                      begin: Alignment.topCenter,
                                      end: Alignment.bottomCenter,
                                      stops: const [0.1, 0.4, 1],
                                    ),
                                  ),
                                  child: CustomText(
                                    label:
                                        item["title"].replaceAll("&amp;", "&"),
                                    type: 'lg',
                                    maxLines: 2,
                                    textStyle: const TextStyle(
                                      color: AppColors.white,
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }).toList(),
                        const SizedBox(width: 80),
                      ]),
                    ),
                  )
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
