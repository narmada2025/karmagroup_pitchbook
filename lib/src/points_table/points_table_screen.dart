import 'package:flutter/material.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/go_back.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/points_table/pt_karma_club.dart';
import 'package:pitchbook/src/points_table/pt_karma_club_elite.dart';
import 'package:pitchbook/src/points_table/pt_karma_royal_residences.dart';

class PointsTableScreen extends StatefulWidget {
  final Map<String, dynamic>? args;

  const PointsTableScreen(this.args, {super.key});

  @override
  State<PointsTableScreen> createState() => _PointsTableScreenState();
}

class _PointsTableScreenState extends State<PointsTableScreen> {
  Map<String, dynamic> data = {};
  List<String> propertyNames = [];
  bool _isLoading = true;

  int _selectedTable = 0;

  Future<void> _loadJsonData() async {
    final jsonData = await loadJsonFromAssets(AppAPI.pointsTable);
    setState(() {
      data = jsonData;
      _isLoading = false;
    });
  }

  void changeTable(int index) {
    _selectedTable = index;
  }

  @override
  void initState() {
    super.initState();
    _selectedTable = int.tryParse(widget.args?['setTab'] ?? '0') ?? 0;
    _loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    List<dynamic> tabs = data['tabs'] ?? [];
    Size size = MediaQuery.of(context).size;

    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: _isLoading
          ? const LoadingComponent()
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.all(80),
                    child: Column(
                      children: [
                        FadeInAnimation(
                          child: CustomText(
                            label: data['title'][lang],
                            type: 'h2',
                            textStyle:
                                const TextStyle(color: AppColors.primary),
                            textAlign: TextAlign.center,
                            isSerif: true,
                          ),
                        ),
                        const SizedBox(height: 30),
                        FadeInAnimation(
                          delay: const Duration(milliseconds: 200),
                          child: Wrap(
                            spacing: 14,
                            children: [
                              for (int i = 0; i < tabs.length; i++)
                                GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _selectedTable = i;
                                    });
                                  },
                                  child: Container(
                                    padding:
                                        const EdgeInsets.fromLTRB(24, 6, 24, 6),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: AppColors.primary, width: 0.5),
                                      borderRadius: BorderRadius.circular(30),
                                      color: _selectedTable == i
                                          ? AppColors.primary
                                          : Colors.transparent,
                                    ),
                                    child: CustomText(
                                        label: tabs[i][lang],
                                        type: 'sm',
                                        textStyle: TextStyle(
                                          fontWeight: FontWeight.w500,
                                          color: _selectedTable == i
                                              ? AppColors.white
                                              : AppColors.primary,
                                        )),
                                  ),
                                ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 30),
                        if (_selectedTable == 0)
                          FadeInAnimation(
                              delay: const Duration(milliseconds: 300),
                              child: PtKarmaClub(pointsData: data, lang: lang)),
                        if (_selectedTable == 1)
                          FadeInAnimation(
                              delay: const Duration(milliseconds: 300),
                              child: PtKarmaClubElite(
                                pointsData: data,
                                lang: lang,
                              )),
                        if (_selectedTable == 2)
                          FadeInAnimation(
                              delay: const Duration(milliseconds: 300),
                              child: PtKarmaRoyalResidences(
                                pointsData: data,
                                lang: lang,
                              )),
                        const SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                ),
                if (widget.args?['showBack'] == true) const GoBack()
              ],
            ),
    );
  }
}
