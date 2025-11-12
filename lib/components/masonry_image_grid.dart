import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class MasonryImageGrid extends StatefulWidget {
  final List<String> imageUrls;
  final List<String?>? names;
  final int? column;
  final bool showName;
  final int showFirst;

  const MasonryImageGrid({
    super.key,
    required this.imageUrls,
    this.names,
    this.column,
    this.showName = true,
    this.showFirst = 20,
  });

  @override
  State<MasonryImageGrid> createState() => _MasonryImageGridState();
}

class _MasonryImageGridState extends State<MasonryImageGrid> {
  int visibleItemCount = 0;
  final bool _showAll = true;

  @override
  void initState() {
    super.initState();

    visibleItemCount = widget.showFirst;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MasonryGridView.count(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          crossAxisCount: widget.column ?? 4,
          mainAxisSpacing: 8,
          crossAxisSpacing: 8,
          itemCount: _showAll ? widget.imageUrls.length : visibleItemCount,
          itemBuilder: (context, index) {
            return _buildImageItem(
              widget.imageUrls[index],
              widget.names != null && index < widget.names!.length
                  ? widget.names![index]
                  : null,
              index,
            );
          },
        ),

        // const SizedBox(height: 60),
        // if (widget.imageUrls.length > visibleItemCount )
        //   Align(
        //     alignment: Alignment.center,
        //     child: CustomBtn(
        //       onPressed: () {
        //         setState(() {
        //           _showAll = !_showAll;
        //         });
        //       },
        //       label: _showAll ? 'View Less' : 'View All',
        //       btnType: BtnType.primary,
        //       borderRadius: 50,
        //     ),
        //   ),
      ],
    );
  }

  Widget _buildImageItem(String imageUrl, String? name, int index) {
    String displayName = name ?? _extractImageName(imageUrl);

    return FadeInAnimation(
      initOpacity: 0.2,
      child: GestureDetector(
        onTap: () {
          _showItemPopup(context, index, value: imageUrl);
        },
        child: Stack(
          alignment: Alignment.bottomCenter,
          children: [
            Image.network('${AppAPI.baseUrlGcp}$imageUrl', fit: BoxFit.cover),
            if (widget.showName)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: ClipRect(
                  child: BackdropFilter(
                    filter: ImageFilter.blur(sigmaX: 4.0, sigmaY: 4.0),
                    child: Container(
                      padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                      decoration: BoxDecoration(
                        color: AppColors.black.withValues(alpha: 0.4),
                      ),
                      child: Text(
                        displayName,
                        style: const TextStyle(color: Colors.white),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  void _showItemPopup(BuildContext context, int index,
      {required dynamic value}) {
    PageController pageController = PageController(initialPage: index);

    showDialog(
      barrierColor: const Color.fromARGB(211, 0, 0, 0),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                Positioned(
                  top: 30,
                  right: 30,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.white,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 30),
                  child: Align(
                    alignment: Alignment.centerRight,
                    child: IconButton(
                      onPressed: index < widget.imageUrls.length - 1
                          ? () {
                              pageController.nextPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      icon: Icon(
                        Icons.arrow_circle_right_rounded,
                        color: index < widget.imageUrls.length - 1
                            ? AppColors.white
                            : AppColors.disabled,
                        size: 40,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.fromLTRB(80, 20, 80, 0),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      if (widget.showName)
                        Container(
                          padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: CustomText(
                            label: (widget.names != null &&
                                    index < widget.names!.length &&
                                    widget.names![index] != null)
                                ? widget.names![index]!
                                : _extractImageName(widget.imageUrls[index]),
                            type: 'lg',
                            textStyle: const TextStyle(color: Colors.white),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      Expanded(
                        child: Container(
                          clipBehavior: Clip.antiAlias,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10)),
                          child: PageView.builder(
                            controller: pageController,
                            onPageChanged: (newIndex) {
                              setState(() {
                                index = newIndex;
                              });
                            },
                            itemCount: widget.imageUrls.length,
                            itemBuilder: (context, currentIndex) {
                              return Center(
                                child:
                                    Image.network('${AppAPI.baseUrlGcp}${widget.imageUrls[currentIndex]}'),
                              );
                            },
                          ),
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: CustomText(
                          label: '${index + 1} of ${widget.imageUrls.length}',
                          textStyle: const TextStyle(
                            color: AppColors.white,
                          ),
                        ),
                      ),
                      const SizedBox(height: 30),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 30),
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      onPressed: index > 0
                          ? () {
                              pageController.previousPage(
                                duration: const Duration(milliseconds: 300),
                                curve: Curves.easeInOut,
                              );
                            }
                          : null,
                      icon: Icon(
                        Icons.arrow_circle_left_rounded,
                        color: index > 0 ? AppColors.white : AppColors.disabled,
                        size: 40,
                      ),
                    ),
                  ),
                ),
              ],
            );
          },
        );
      },
    );
  }

  String _extractImageName(String imageUrl) {
    return imageUrl.split('/').last.split('.').first;
  }
}
