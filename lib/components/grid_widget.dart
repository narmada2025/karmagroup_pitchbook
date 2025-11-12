import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

enum ScrollPhysicsType {
  noScroll,
  hScroll,
  vScroll,
}

class GridWidget<T> extends StatelessWidget {
  final List<T> items;
  final int columns;
  final double gap;
  final Function(T) itemBuilder;
  final ScrollPhysicsType physicsType;
  final bool hasPopup;

  const GridWidget({
    super.key,
    required this.items,
    this.columns = 2,
    this.gap = 10,
    required this.itemBuilder,
    this.physicsType = ScrollPhysicsType.vScroll,
    this.hasPopup = false,
  });

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
    return GridView.builder(
      physics: physics,
      shrinkWrap: physicsType == ScrollPhysicsType.noScroll ? false : true,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: columns,
        crossAxisSpacing: gap,
        mainAxisSpacing: gap,
      ),
      itemCount: items.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: hasPopup
              ? () {
                  _showItemPopup(context, index, value: 'popup');
                }
              : null,
          child: itemBuilder(items[index]),
        );
      },
    );
  }

  void _showItemPopup(BuildContext context, int index,
      {required dynamic value}) {
    Size size = MediaQuery.of(context).size;

    showDialog(
        barrierColor: const Color.fromARGB(211, 0, 0, 0),
        context: context,
        builder: (context) {
          int currentIndex = index;
          return StatefulBuilder(
            builder: (context, setState) {
              return GestureDetector(
                  onPanUpdate: (details) {
                    if (details.delta.dx > 10) {
                      if (currentIndex > 0) {
                        setState(() {
                          currentIndex--;
                        });
                      }
                    } else if (details.delta.dx < -10) {
                      if (currentIndex < items.length - 1) {
                        setState(() {
                          currentIndex++;
                        });
                      }
                    }
                  },
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: IconButton(
                              onPressed: () {
                                if (index > 0) {
                                  Navigator.pop(context);
                                  _showItemPopup(context, index - 1,
                                      value: 'popup');
                                }
                              },
                              icon: Icon(
                                Icons.arrow_circle_left_rounded,
                                color: currentIndex > 0
                                    ? AppColors.white
                                    : AppColors.disabled,
                                size: 40,
                              ),
                            ),
                          ),
                          Expanded(
                            child: Container(
                              height: size.height - 80,
                              alignment: Alignment.center,
                              child: Stack(
                                alignment: Alignment.center,
                                children: [
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      itemBuilder(items[currentIndex]),
                                    ],
                                  ),
                                  Positioned(
                                    bottom: 30,
                                    child: CustomText(
                                      label:
                                          '${currentIndex + 1} of ${items.length}',
                                      textStyle: const TextStyle(
                                        color: AppColors.white,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 60),
                            child: IconButton(
                              onPressed: () {
                                if (index < items.length - 1) {
                                  Navigator.pop(context);
                                  _showItemPopup(context, index + 1,
                                      value: 'popup');
                                }
                              },
                              icon: Icon(
                                Icons.arrow_circle_right_rounded,
                                color: currentIndex > 0
                                    ? AppColors.white
                                    : AppColors.disabled,
                                size: 40,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ));
            },
          );
        });
  }
}
