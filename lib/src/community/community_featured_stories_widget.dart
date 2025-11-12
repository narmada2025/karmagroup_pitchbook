import 'package:flutter/material.dart';
import 'package:pitchbook/components/image_network_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/helpers/helper.dart';

class CommunityFeaturedStoriesWidget extends StatefulWidget {
  final Map<String, dynamic> stories;
  final Map<String, dynamic> data;
  final String lang;

  const CommunityFeaturedStoriesWidget({
    super.key,
    required this.stories,
    required this.data,
    required this.lang,
  });

  @override
  State<CommunityFeaturedStoriesWidget> createState() =>
      _CommunityFeaturedStoriesWidgetState();
}

class _CommunityFeaturedStoriesWidgetState
    extends State<CommunityFeaturedStoriesWidget> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    String thumbnail = '';
    String title = '';

    if (widget.stories['featured_stories'] != null &&
        widget.stories['featured_stories'].length > 0) {
      thumbnail = widget.stories['featured_stories'][0]['thumbnail'];
      title = widget.stories['featured_stories'][0]['title'];
    }

    return Container(
      width: size.width,
      padding: const EdgeInsets.fromLTRB(0, 40, 0, 100),
      constraints: BoxConstraints(
        minWidth: size.width,
      ),
      child: Wrap(
        runSpacing: 50,
        children: [
          Container(
            alignment: Alignment.center,
            child: CustomText(
              label: widget.data['Featured Stories'][widget.lang],
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
                height: size.height / 1.5,
              ),
              Container(
                width: size.width,
                height: size.height / 1.5,
                color: AppColors.black.withValues(alpha: 0.6),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 200),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    child: CustomText(
                      label: widget.data['Featured Stories'][widget.lang]
                          .toUpperCase(),
                      type: 'lg',
                      textStyle: const TextStyle(
                        color: AppColors.secondary,
                        fontWeight: FontWeight.w500,
                      ),
                      isUppercase: true,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 100),
                    width: size.width / 1.5,
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
                        if (widget.stories['featured_stories'] != null)
                          ...widget.stories['featured_stories']
                              .asMap()
                              .entries
                              .map<Widget>((entry) {
                            return InkWell(
                              onTap: () {
                                launchUrlInBrowser(context, entry.value["url"]);
                              },
                              child: Container(
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: AppColors.gray,
                                ),
                                clipBehavior: Clip.antiAlias,
                                width: size.width / 5,
                                height: 320,
                                child: ImageNetworkWidget(
                                  imageUrl: entry.value["thumbnail"],
                                  child: Container(
                                    alignment: Alignment.bottomLeft,
                                    padding: const EdgeInsets.fromLTRB(
                                        20, 20, 20, 20),
                                    decoration: BoxDecoration(
                                      gradient: LinearGradient(
                                        colors: [
                                          AppColors.black.withValues(alpha: 0),
                                          AppColors.black
                                              .withValues(alpha: 0.4),
                                          AppColors.black.withValues(alpha: 0.8)
                                        ],
                                        begin: Alignment.topCenter,
                                        end: Alignment.bottomCenter,
                                        stops: const [0.1, 0.4, 1],
                                      ),
                                    ),
                                    child: CustomText(
                                      label: entry.value["title"]
                                          .replaceAll("&amp;", "&"),
                                      isSerif: true,
                                      type: 'h4',
                                      textStyle: const TextStyle(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }),
                        const SizedBox(width: 80),
                      ]),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
