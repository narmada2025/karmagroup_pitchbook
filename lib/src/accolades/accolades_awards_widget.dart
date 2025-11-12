import 'package:flutter/material.dart';
import 'package:pitchbook/components/award_card_widget.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/no_data.dart';

class AccoladesAwardsWidget extends StatefulWidget {
  final Map<String, dynamic> data;
  final String lang;

  const AccoladesAwardsWidget({
    required this.data,
    required this.lang,
    super.key,
  });

  @override
  State<AccoladesAwardsWidget> createState() => _AccoladesAwardsWidgetState();
}

class _AccoladesAwardsWidgetState extends State<AccoladesAwardsWidget> {
  String _selectedYear = 'all';
  // final bool _isLoading = true;

  void _changeYear(String year) {
    setState(() {
      _selectedYear = year;
    });
  }

  List<Widget> _buildAwardText(data) {
    List<Widget> items = [];
    for (int i = 0; i < data.length; i++) {
      items.add(Text(
        data[i],
        style: const TextStyle(
          fontFamily: 'Montserrat',
          color: Colors.white,
          fontSize: 13,
          fontWeight: FontWeight.w500,
        ),
      ));

      // Add dot separator except for last item
      if (i != data.length - 1) {
        items.add(const Text(
          '•',
          style: TextStyle(
            color: Colors.white,
            fontSize: 12,
            fontWeight: FontWeight.w300,
          ),
        ));
      }
    }
    return items;
  }
  
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Container(
      width: size.width,
      padding: const EdgeInsets.fromLTRB(60, 80, 60, 0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          FadeInAnimation(
            visibilityThreshold: 1,
            child: SizedBox(
              width: size.width / 1.8,
              child: CustomText(
                label: widget.data['title'][widget.lang],
                type: 'h3',
                textStyle: const TextStyle(color: AppColors.primary),
                textAlign: TextAlign.center,
                isSerif: true,
              ),
            ),
          ),
          const SizedBox(height: 20),
          FadeInAnimation(
            visibilityThreshold: 1,
            child: SizedBox(
              width: size.width / 1.2,
              child: CustomText(
                label: widget.data['description'][widget.lang],
                textStyle: const TextStyle(color: AppColors.white),
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const SizedBox(height: 60),
          FadeInAnimation(
            visibilityThreshold: 1,
            child: Column(
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(30, 20, 30, 20),
                  decoration: BoxDecoration(
                      border: Border.all(
                        color: AppColors.primary,
                        width: 0.5,
                      ),
                      borderRadius: BorderRadius.circular(10)),
                  child: Wrap(
                      direction: Axis.horizontal,
                      spacing: 20,
                      runSpacing: 5,
                      children: [
                        InkWell(
                          onTap: () => _changeYear('all'),
                          child: Container(
                            padding: const EdgeInsets.symmetric(vertical: 6),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: _selectedYear == 'all'
                                            ? AppColors.white
                                            : Colors.transparent))),
                            child: CustomText(
                              label: widget.data['all'][widget.lang],
                              type: 'md',
                              textStyle: _selectedYear == 'all'
                                  ? const TextStyle(color: AppColors.white)
                                  : const TextStyle(color: AppColors.primary),
                            ),
                          ),
                        ),
                        ...widget.data['awards'].keys
                            .toList()
                            .asMap()
                            .entries
                            .map<Widget>((entry) {
                          return InkWell(
                            onTap: () => _changeYear(entry.value),
                            child: Container(
                              padding: const EdgeInsets.symmetric(vertical: 6),
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: _selectedYear == entry.value
                                              ? AppColors.white
                                              : Colors.transparent))),
                              child: CustomText(
                                label: entry.value,
                                type: 'md',
                                textStyle: _selectedYear == entry.value
                                    ? const TextStyle(color: AppColors.white)
                                    : const TextStyle(color: AppColors.primary),
                              ),
                            ),
                          );
                        }),
                      ]),
                ),
              ],
            ),
          ),
          const SizedBox(height: 80),
          FadeInAnimation(
            visibilityThreshold: 1,
            child: CustomText(
              label: widget.data['subTitle'][widget.lang],
              type: 'h2',
              textStyle: const TextStyle(color: AppColors.white),
              textAlign: TextAlign.center,
              isSerif: true,
            ),
          ),
          const SizedBox(height: 80),
          if (_selectedYear != 'all')
            Wrap(
              direction: Axis.horizontal,
              spacing: 40,
              runSpacing: 80,
              children: widget.data['awards'][_selectedYear] != null
                  ? widget.data['awards'][_selectedYear]
                      .asMap()
                      .entries
                      .map<Widget>((entry) {
                      return FadeInAnimation(
                        visibilityThreshold: 0.3,
                        child: SizedBox(
                          width: (size.width - 200) / 4.5,
                          child: AwardCardWidget(
                            award: entry.value,
                            lang: widget.lang,
                          ),
                        ),
                      );
                    }).toList()
                  : [
                      NoData(
                        title: 'No Awards for $_selectedYear ',
                      )
                    ],
            ),
          if (_selectedYear == 'all')
            Column(
              children: widget.data['awards'].keys.map<Widget>((year) {
                return Column(
                  children: [
                    FadeInAnimation(
                      visibilityThreshold: 1,
                      child: Row(
                        children: [
                          CustomText(
                            label: year,
                            type: 'h3',
                            textStyle: const TextStyle(color: AppColors.white),
                            textAlign: TextAlign.center,
                            isSerif: true,
                          ),
                          const SizedBox(width: 20),
                          Expanded(
                            child: Container(
                              margin: const EdgeInsets.only(top: 15),
                              height: 1,
                              color: AppColors.primary,
                            ),
                          )
                        ],
                      ),
                    ),
                    const SizedBox(height: 30),
                    Wrap(
                    direction: Axis.horizontal,
                    spacing: 40,
                    runSpacing: 80,
                    children: (widget.data['awards'][year]['awardsList'] as List)
                        .asMap()
                        .entries
                        .map<Widget>((entry) {
                    final award = entry.value;
                    return FadeInAnimation(
                    visibilityThreshold: 0.3,
                    child: SizedBox(
                    width: (size.width - 200) / 4.5,
                    child: AwardCardWidget(
                    award: award,
                    lang: widget.lang,
                    ),
                    ),
                    );
                    })
                        .toList(),
                    ),

                    //Tripadvisor
                    widget.data['awards'][year]['tripImage'] ==""?Container():FadeInAnimation(
                      visibilityThreshold: 0.3,
                       child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const SizedBox(height: 30),
                          Image.network('${AppAPI.baseUrlGcp}${widget.data['awards'][year]['tripImage']}'),
                          const SizedBox(height: 40),
                          // Resorts list
                          Wrap(
                            alignment: WrapAlignment.center,
                            spacing: 8,
                            runSpacing: 8,
                            children: _buildAwardText(widget.data['awards'][year]['tripAdvisorList'])
                          ),
                        ],
                        ),
                     ),
                    const SizedBox(height: 80),
                  ],
                );
              }).toList(),
            ),
          const SizedBox(height: 80),
        ],
      ),
    );
  }
}


