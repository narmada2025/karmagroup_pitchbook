import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

enum ScrollPhysicsType {
  noScroll,
  hScroll,
  vScroll,
}

class GalleryWidget<T> extends StatelessWidget {
  final List<T> items;
  final int columns;
  final double gap;
  final double bottomSpace;
  final double childRatio;
  final Function(T) itemBuilder;
  final ScrollPhysicsType physicsType;
  final bool hasPopup;
  final bool showAllItems;
  final int showFirst;
  final bool isSlider;
  final Axis sliderDirection;
  final double viewportFraction;
  final ValueChanged<int> onPageChanged;
  final PageController? pageController;

  const GalleryWidget({
    super.key,
    required this.items,
    this.columns = 3,
    this.gap = 20,
    this.bottomSpace = 0,
    this.childRatio = 1,
    required this.itemBuilder,
    this.physicsType = ScrollPhysicsType.vScroll,
    this.hasPopup = false,
    this.showAllItems = true,
    this.showFirst = 12,
    this.isSlider = false,
    this.sliderDirection = Axis.horizontal,
    this.viewportFraction = 1,
    this.onPageChanged = _defaultOnPageChanged,
    this.pageController,
  });

  static void _defaultOnPageChanged(int index) {}

  ScrollPhysics get physics {
    switch (physicsType) {
      case ScrollPhysicsType.vScroll:
        return const BouncingScrollPhysics();
      case ScrollPhysicsType.hScroll:
        return const ClampingScrollPhysics();
      case ScrollPhysicsType.noScroll:
        return const NeverScrollableScrollPhysics();
    }
  }

  @override
  Widget build(BuildContext context) {
    late bool showAll = showAllItems;

    return isSlider && !hasPopup
        ? PageView.builder(
            onPageChanged: onPageChanged,
            scrollDirection: sliderDirection,
            controller: pageController ??
                PageController(viewportFraction: viewportFraction),
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Container(
                alignment: Alignment.topCenter,
                margin: viewportFraction != 1
                    ? EdgeInsets.only(right: gap)
                    : EdgeInsets.zero,
                child: itemBuilder(items[index]),
              );
            },
          )
        : Column(
            children: [
              Wrap(
                spacing: gap,
                runSpacing: gap,
                children: showAll
                    ? items.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: hasPopup
                              ? () {
                                  _showItemPopup(context, entry.key);
                                }
                              : null,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            clipBehavior: Clip.antiAlias,
                            child: Image.network(
                              '${AppAPI.baseUrlGcp}${entry.value.toString()}',
                              width:
                                  (MediaQuery.of(context).size.width - 200) / 3,
                            ),
                          ),
                        );
                      }).toList()
                    : items
                        .sublist(0,
                            items.length < showFirst ? items.length : showFirst)
                        .asMap()
                        .entries
                        .map((entry) {
                        return GestureDetector(
                          onTap: hasPopup
                              ? () {
                                  _showItemPopup(context, entry.key);
                                }
                              : null,
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(6),
                            clipBehavior: Clip.antiAlias,
                            child: Image.network(
                              '${AppAPI.baseUrlGcp}${entry.value.toString()}',
                              width:
                                  (MediaQuery.of(context).size.width - 200) / 3,
                            ),
                          ),
                        );
                      }).toList(),
              ),
              if (bottomSpace != 0)
                SizedBox(
                  height: bottomSpace,
                )
            ],
          );
  }

  void _showItemPopup(BuildContext context, int index) {
    Size size = MediaQuery.of(context).size;
    PageController pageController = PageController(initialPage: index);

    showDialog(
      barrierColor: const Color.fromARGB(211, 0, 0, 0),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              children: [
                Center(
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: index > 0
                              ? () {
                                  setState(() {
                                    index--;
                                    pageController.animateToPage(
                                      index,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                }
                              : null,
                          icon: Icon(
                            Icons.arrow_circle_left_rounded,
                            color: index > 0
                                ? AppColors.white
                                : AppColors.disabled,
                            size: 40,
                          ),
                        ),
                        SizedBox(
                          width: size.width - 200,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const SizedBox(height: 50),
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
                                    itemCount: items.length,
                                    itemBuilder: (context, currentIndex) {
                                      return itemBuilder(items[currentIndex]);
                                    },
                                  ),
                                ),
                              ),
                              const SizedBox(height: 30),
                              CustomText(
                                label: '${index + 1} of ${items.length}',
                                textStyle: const TextStyle(
                                  color: AppColors.white,
                                ),
                              ),
                              const SizedBox(height: 50),
                            ],
                          ),
                        ),
                        IconButton(
                          onPressed: index < items.length - 1
                              ? () {
                                  setState(() {
                                    index++;
                                    pageController.animateToPage(
                                      index,
                                      duration:
                                          const Duration(milliseconds: 300),
                                      curve: Curves.easeInOut,
                                    );
                                  });
                                }
                              : null,
                          icon: Icon(
                            Icons.arrow_circle_right_rounded,
                            color: index < items.length - 1
                                ? AppColors.white
                                : AppColors.disabled,
                            size: 40,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 30),
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
              ],
            );
          },
        );
      },
    );
  }
}
