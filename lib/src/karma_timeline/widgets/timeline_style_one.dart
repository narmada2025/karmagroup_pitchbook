import 'package:flutter/material.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/app_data.dart';

class TimelineStyleOne extends StatelessWidget {
  final String title;
  final String image;
  final String logo;
  final String text;
  final double topPadding;
  final CrossAxisAlignment contentAlignment;

  const TimelineStyleOne({
    super.key,
    required this.title,
    required this.image,
    required this.logo,
    required this.text,
    this.contentAlignment = CrossAxisAlignment.center,
    this.topPadding = 120,
  });

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: (size.width * 0.15)),
      child: Stack(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              for (int i = 0; i < 4; i++)
                const VerticalDivider(
                  thickness: 1,
                  color: Color.fromARGB(129, 77, 73, 68),
                )
            ],
          ),
          Container(
            padding: EdgeInsets.fromLTRB(8, topPadding, 8, 0),
            height: size.height / 1.3,
            child: Row(
              crossAxisAlignment: contentAlignment,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 20),
                    child: Wrap(
                      alignment: WrapAlignment.end,
                      runSpacing: 30,
                      children: [
                        Align(
                          alignment: Alignment.topLeft,
                          child: CustomText(
                            label: title,
                            type: 'h6',
                            isSerif: true,
                            textStyle: const TextStyle(
                                color: AppColors.white, height: 1.2),
                          ),
                        ),
                        Image.network(
                          '${AppAPI.baseUrlGcp}$image',
                          width:
                              (((size.width - (size.width * 0.15)) / 3) * 0.6),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(30),
                    child: Image.network('${AppAPI.baseUrlGcp}$logo'),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.all(60),
                    child: CustomText(
                      label: text,
                      isUppercase: true,
                      textStyle:
                          const TextStyle(color: AppColors.white, height: 1.2),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
