import 'package:flutter/material.dart';
import 'package:pitchbook/components/slide_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';

class PhilanthropyStatsWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String lang;

  const PhilanthropyStatsWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  State<PhilanthropyStatsWidget> createState() =>
      _PhilanthropyStatsWidgetState();
}

class _PhilanthropyStatsWidgetState extends State<PhilanthropyStatsWidget> {

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      color: AppColors.black,
      padding: const EdgeInsets.all(50),
      constraints: const BoxConstraints(
        maxHeight: double.infinity,
      ),
      child: Column(
        children: [
          // this is for Sort by countries - Add more countries in stats and enable this
          // Row(mainAxisSize: MainAxisSize.min, children: [
          //   ...widget.data['stats'].asMap().entries.map<Widget>((entry) {
          //     return InkWell(
          //       onTap: () => _changeCountry(entry.key),
          //       child: Container(
          //         padding: const EdgeInsets.fromLTRB(30, 5, 30, 5),
          //         child: CustomText(
          //             type: 'h6',
          //             label: entry.value['name'][widget.lang],
          //             textAlign: TextAlign.center,
          //             textStyle: _selectedCountry == entry.key
          //                 ? const TextStyle(
          //                     color: AppColors.primary,
          //                     fontWeight: FontWeight.w700)
          //                 : const TextStyle(
          //                     color: AppColors.white,
          //                   )),
          //       ),
          //     );
          //   }).toList(),
          // ]),
          // const SizedBox(
          //   height: 40,
          // ),
          Container(
            alignment: Alignment.topCenter,
            width: size.width / 1.2,
            child: Wrap(
                spacing: 20,
                runSpacing: 20,
                direction: Axis.horizontal,
                children: widget.data['stats'][0]['data']
                    .map<Widget>((entry) {
                  return SlideInAnimation(
                    visibilityThreshold: 0.3,
                    distance: 0.2,
                    child: SizedBox(
                      width: size.width / 5 - 5,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          Image.network(
                           '${AppAPI.baseUrlGcp}${entry['image']}',
                            fit: BoxFit.fill,
                          ),
                          Padding(
                            padding: const EdgeInsets.all(20),
                            child: Wrap(
                              runSpacing: 10,
                              alignment: WrapAlignment.center,
                              children: [
                                CustomText(
                                  label: entry['title'][widget.lang],
                                  type: entry['subTitle'] == '' ? 'h3' : 'h2',
                                  isSerif: true,
                                  textAlign: TextAlign.center,
                                  textStyle:
                                      const TextStyle(color: AppColors.white),
                                ),
                                if (entry['subTitle'] != '')
                                  CustomText(
                                    label: entry['subTitle'][widget.lang],
                                    type: 'h6',
                                    isSerif: true,
                                    textAlign: TextAlign.center,
                                    textStyle:
                                        const TextStyle(color: AppColors.white),
                                  ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }).toList()),
          ),
        ],
      ),
    );
  }
}
