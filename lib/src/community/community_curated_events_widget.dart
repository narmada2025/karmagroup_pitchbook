import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_btn.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/app_locatizations.dart';
import 'package:pitchbook/src/community/widgets/event_card_widget.dart';
import 'package:pitchbook/src/community/widgets/event_category_widget.dart';

class CommunityCuratedEventsWidget extends StatefulWidget {
  final Map<String, dynamic> events;
  final Map<String, dynamic> data;
  final String lang;

  const CommunityCuratedEventsWidget({
    super.key,
    required this.events,
    required this.data,
    required this.lang,
  });

  @override
  State<CommunityCuratedEventsWidget> createState() =>
      _CommunityCuratedEventsWidgetState();
}

class _CommunityCuratedEventsWidgetState
    extends State<CommunityCuratedEventsWidget> {
  String? _selectedLocation = "All";
  int? _selectedCategory = 0;

  bool _showAllEvents = false;
  final int showFirstEvents = 12;
  bool _showAllPastEvents = false;
  final int showFirstPastEvents = 6;

  final String filterLocation =
      "assets/icons/community/Filter Location.svg";

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    getLocations() {
      List<String> locations = [];
      locations.add('All');

      var upcomingEvents = widget.events['upcoming'] as List? ?? [];

      for (var event in upcomingEvents) {
        String location = event['location'];
        if (!locations.contains(location)) {
          locations.add(location);
        }
      }

      return locations;
    }

    List filteredUpcomingEvents = [];
    List filteredPastEvents = [];
    String errorMessage = '';

    try {
      filteredUpcomingEvents =
          ((widget.events['upcoming'] as List?) ?? []).where((event) {
        bool matchesLocation = _selectedLocation == 'All' ||
            event['location'] == _selectedLocation;

        bool matchesCategory = _selectedCategory == 0 ||
            (event['category'] is List &&
                event['category'].any(
                    (category) => category['term_id'] == _selectedCategory));

        return matchesLocation && matchesCategory;
      }).toList();
      // print("curatedevent==============$filteredUpcomingEvents") //Narmada;

      filteredPastEvents =
          ((widget.events['past'] as List?) ?? []).where((event) {
        bool matchesLocation = _selectedLocation == 'All' ||
            event['location'] == _selectedLocation;

        bool matchesCategory = _selectedCategory == 0 ||
            (event['category'] is List &&
                event['category'].any(
                    (category) => category['term_id'] == _selectedCategory));

        return matchesLocation && matchesCategory;
      }).toList();
    } catch (e) {
      errorMessage = 'An error occurred while filtering events: $e';
    }

    bool hasNoData =
        filteredUpcomingEvents.isEmpty && filteredPastEvents.isEmpty;

    return Container(
      width: size.width,
      padding: const EdgeInsets.fromLTRB(0, 0, 0, 40),
      constraints: BoxConstraints(
        minWidth: size.width,
      ),
      child: Wrap(
        runSpacing: 60,
        children: [
          Container(
            alignment: Alignment.center,
            child: CustomText(
              label: widget.data['Karma Curated Events'][widget.lang],
              type: 'h2',
              textStyle: const TextStyle(color: AppColors.primary),
              textAlign: TextAlign.center,
              isSerif: true,
            ),
          ),
          Container(
            padding: const EdgeInsets.all(20),
            color: AppColors.gray2,
            width: size.width,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomText(
                  label: widget.data['Filter Location'][widget.lang],
                  type: 'lg',
                  textStyle: const TextStyle(
                      color: AppColors.white, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 30),
                DropdownButtonHideUnderline(
                  child: DropdownButton(
                    dropdownColor: AppColors.white,
                    menuWidth: 200,
                    borderRadius: BorderRadius.circular(10),
                    icon: Container(
                      padding: const EdgeInsets.all(15),
                      decoration: BoxDecoration(
                          border: Border.all(color: AppColors.primary),
                          borderRadius: BorderRadius.circular(50)),
                      child: SvgPicture.asset(
                        filterLocation,
                        width: 20,
                        fit: BoxFit.contain,
                        semanticsLabel: 'down Arrow',
                        placeholderBuilder: (context) =>
                            const CircularProgressIndicator(),
                      ),
                    ),
                    value: _selectedLocation,
                    onChanged: (newValue) {
                      setState(() {
                        _selectedLocation = newValue;
                      });
                    },
                    items: getLocations().map((location) {
                      return DropdownMenuItem(
                        value: location,
                        child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomText(
                                label: location,
                                textStyle: const TextStyle(
                                  color: AppColors.primary,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(width: 5),
                            ]),
                      );
                    }).toList(),
                  ),
                ),
                const SizedBox(width: 60),
                CustomText(
                  label: widget.data['Filter Category'][widget.lang],
                  type: 'lg',
                  textStyle: const TextStyle(
                      color: AppColors.white, fontWeight: FontWeight.w500),
                ),
                const SizedBox(width: 20),
                Wrap(
                  spacing: 20,
                  children: [
                    ...widget.data['categories']
                        .asMap()
                        .entries
                        .map<Widget>((entry) {
                      return EventCategoryWidget(
                        svgAsset: entry.value['image'],
                        isActive: _selectedCategory == entry.value['id']
                            ? true
                            : false,
                        onTap: () {
                          setState(() {
                            if (_selectedCategory == entry.value['id']) {
                              _selectedCategory = 0;
                            } else {
                              _selectedCategory = entry.value['id'];
                            }
                          });
                        },
                        semanticsLabel: entry.value['title'],
                      );
                    }),
                  ],
                )
              ],
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: CustomText(
              label: widget.data['Upcoming Events'][widget.lang],
              type: 'h4',
              textStyle: const TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                ...filteredUpcomingEvents.isNotEmpty
                    ? filteredUpcomingEvents
                        .asMap()
                        .entries
                        .map<Widget>((entry) {
                          return EventCardWidget(
                            image: entry.value['thumbnail'],
                            title: entry.value['post_title'],
                            date: entry.value['date_start'],
                            month: entry.value['date_month_start'],
                            width: size.width / 4,
                            isSold: entry.value['is_sold_out'] ?? '',
                            isLastSpot: entry.value['is_last_spot'] ?? '',
                            location: entry.value['location'] ?? '',
                            onTap: () {
                              launchUrlInBrowser(context, entry.value['link']);
                            },
                          );
                        })
                        .toList()
                        .sublist(
                            0,
                            _showAllEvents
                                ? filteredUpcomingEvents.length
                                : min(showFirstEvents,
                                    filteredUpcomingEvents.length))
                    : [
                        if (!hasNoData)
                          CustomText(
                            label: tr(context, 'errors.No events available',
                                widget.lang),
                            textStyle: const TextStyle(color: AppColors.white),
                          ),
                        if (errorMessage.isNotEmpty)
                          CustomText(
                            label: tr(context, 'errors.Error fetching data',
                                widget.lang),
                            textStyle: const TextStyle(color: AppColors.white),
                          ),
                      ],
              ],
            ),
          ),
          const SizedBox(height: 50),
          if (filteredUpcomingEvents.length > showFirstEvents)
            Align(
              alignment: Alignment.center,
              child: CustomBtn(
                onPressed: () {
                  setState(() {
                    _showAllEvents = !_showAllEvents;
                  });
                },
                label: _showAllEvents
                    ? tr(context, 'labels.view_less', widget.lang)
                    : tr(context, 'labels.view_all', widget.lang),
                btnType: BtnType.primary,
                borderRadius: 50,
              ),
            ),
          Container(
            margin: const EdgeInsets.only(top: 50),
            alignment: Alignment.center,
            child: CustomText(
              label: widget.data['Past Events'][widget.lang],
              type: 'h4',
              textStyle: const TextStyle(
                  color: AppColors.white, fontWeight: FontWeight.w500),
            ),
          ),
          Container(
            alignment: Alignment.center,
            padding: const EdgeInsets.symmetric(horizontal: 60),
            child: Wrap(
              spacing: 20,
              runSpacing: 20,
              children: [
                ...filteredPastEvents.isNotEmpty
                    ? filteredPastEvents
                        .asMap()
                        .entries
                        .map<Widget>((entry) {
                          return EventCardWidget(
                            image: entry.value['thumbnail'],
                            title: entry.value['post_title'],
                            date: entry.value['date_start'],
                            month: entry.value['date_month_start'],
                            width: size.width / 4,
                            isSold: entry.value['is_sold_out'] ?? '',
                            isLastSpot: entry.value['is_last_spot'] ?? '',
                            location: entry.value['location'] ?? '',
                            onTap: () {
                              launchUrlInBrowser(context, entry.value['link']);
                            },
                          );
                        })
                        .toList()
                        .sublist(
                            0,
                            _showAllPastEvents
                                ? filteredPastEvents.length
                                : min(showFirstPastEvents,
                                    filteredPastEvents.length))
                    : [
                        if (!hasNoData)
                          CustomText(
                            label: tr(context, 'errors.No events available',
                                widget.lang),
                            textStyle: const TextStyle(color: AppColors.white),
                          ),
                        if (errorMessage.isNotEmpty)
                          CustomText(
                            label: tr(context, 'errors.Error fetching data',
                                widget.lang),
                            textStyle: const TextStyle(color: AppColors.white),
                          ),
                      ],
              ],
            ),
          ),
          const SizedBox(height: 50),
          if (filteredPastEvents.length > showFirstPastEvents)
            Align(
              alignment: Alignment.center,
              child: CustomBtn(
                onPressed: () {
                  setState(() {
                    _showAllPastEvents = !_showAllPastEvents;
                  });
                },
                label: _showAllPastEvents
                    ? tr(context, 'labels.view_less', widget.lang)
                    : tr(context, 'labels.view_all', widget.lang),
                btnType: BtnType.primary,
                borderRadius: 50,
              ),
            ),
        ],
      ),
    );
  }
}
