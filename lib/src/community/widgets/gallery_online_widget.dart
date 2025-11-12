import 'package:flutter/material.dart';
import 'package:pitchbook/components/image_network_widget.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class GalleryOnlineWidget<T> extends StatelessWidget {
  final List<dynamic> items;
  final int columns;
  final double gap;
  final double bottomSpace;
  final bool hasPopup;
  final bool showAllItems;
  final int showFirst;

  const GalleryOnlineWidget({
    super.key,
    required this.items,
    this.columns = 3,
    this.gap = 20,
    this.bottomSpace = 0,
    this.hasPopup = false,
    this.showAllItems = true,
    this.showFirst = 12,
  });

  String formatTitle(String title) {
    // Replace underscores and hyphens with spaces
    String formattedTitle = title.replaceAll('_', ' ').replaceAll('-', ' ');

    // Capitalize each word
    formattedTitle = formattedTitle.split(' ').map((word) {
      return word[0].toUpperCase() + word.substring(1).toLowerCase();
    }).join(' ');

    return formattedTitle;
  }

  @override
  Widget build(BuildContext context) {
    late bool showAll = showAllItems;

    return Column(
      children: [
        items.isEmpty
            ? Wrap(
                spacing: gap,
                runSpacing: gap,
                children: List.generate(
                    showFirst,
                    (index) => ImageNetworkWidget(
                          decoration: BoxDecoration(
                            color: AppColors.gray,
                            borderRadius: BorderRadius.circular(6),
                          ),
                          imageUrl: '',
                          width: (MediaQuery.of(context).size.width - 200) /
                              columns,
                          height: 200,
                        )),
              )
            : Wrap(
                spacing: gap,
                runSpacing: gap,
                children: showAll
                    ? items.asMap().entries.map((entry) {
                        return GestureDetector(
                          onTap: hasPopup
                              ? () {
                                  _showItemPopup(context, entry.key,
                                      value: 'popup');
                                }
                              : null,
                          child: ImageNetworkWidget(
                            decoration: BoxDecoration(
                              color: AppColors.gray,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            imageUrl: entry.value['sizes']['medium'],
                            width: (MediaQuery.of(context).size.width - 200) /
                                columns,
                            height: 200,
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
                                  _showItemPopup(context, entry.key,
                                      value: 'popup');
                                }
                              : null,
                          child: ImageNetworkWidget(
                            decoration: BoxDecoration(
                              color: AppColors.gray,
                              borderRadius: BorderRadius.circular(6),
                            ),
                            imageUrl: entry.value['sizes']['medium'],
                            width: (MediaQuery.of(context).size.width - 200) /
                                columns,
                            height: 200,
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

  void _showItemPopup(BuildContext context, int index,
      {required dynamic value}) {
    Size size = MediaQuery.of(context).size;

    showDialog(
      barrierColor: const Color.fromARGB(211, 0, 0, 0),
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setState) {
            return Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  top: 20,
                  right: 40,
                  child: IconButton(
                    icon: const Icon(
                      Icons.close,
                      color: AppColors.primary,
                      size: 30,
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      alignment: Alignment.center,
                      width: size.width * 0.7,
                      child: CustomText(
                        label: formatTitle(items[index]['title']),
                        type: 'h5',
                        textStyle: const TextStyle(
                          color: AppColors.white,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    SizedBox(
                      height: size.height - 200,
                      child: PageView.builder(
                        itemCount: items.length,
                        controller: PageController(
                            initialPage: index, viewportFraction: 0.86),
                        onPageChanged: (newIndex) {
                          setState(() {
                            index = newIndex;
                          });
                        },
                        itemBuilder: (context, pageIndex) {
                          return Container(
                            margin: const EdgeInsets.only(right: 20),
                            child: ImageNetworkWidget(
                              decoration: BoxDecoration(
                                color: AppColors.gray,
                                borderRadius: BorderRadius.circular(6),
                              ),
                              imageUrl: items[pageIndex]['sizes']['large'],
                              fit: BoxFit.cover,
                              height: MediaQuery.of(context).size.height - 200,
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(height: 20),
                    CustomText(
                      label: '${index + 1} of ${items.length}',
                      textStyle: const TextStyle(
                        color: AppColors.white,
                      ),
                    ),
                  ],
                ),
              ],
            );
          },
        );
      },
    );
  }
}
