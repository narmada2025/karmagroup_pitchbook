import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/karma_club/karma_club_banner_widget.dart';
import 'package:pitchbook/src/karma_club/karma_club_fractional_ownership_widget.dart';
import 'package:pitchbook/src/karma_club/karma_club_lifestyle_experiences.dart';
import 'package:pitchbook/src/karma_club/karma_club_locations_widget.dart';
import 'package:pitchbook/src/karma_club/karma_club_points_table_widget.dart';
import 'package:pitchbook/src/karma_club/karma_club_questions_widget.dart';
import 'package:pitchbook/src/karma_club/karma_club_travel_widget.dart';

class KarmaClubScreen extends StatefulWidget {
  const KarmaClubScreen({
    super.key,
  });

  @override
  State<KarmaClubScreen> createState() => _KarmaClubScreenState();
}

class _KarmaClubScreenState extends State<KarmaClubScreen> {
  Map<String, dynamic> data = {};
  bool _isLoading = true;

  Future<void> _loadJsonData() async {
    final jsonData = await loadJsonFromAssets(AppAPI.karmaClub);
    setState(() {
      data = jsonData;
      _isLoading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: _isLoading
          ? const LoadingComponent()
          : SingleChildScrollView(
              child: Column(
                children: [
                  KarmaClubBannerWidget(data: data['banner'], lang: lang),
                  KarmaClubLifestyleExperiencesWidget(
                      data: data['experiences'], lang: lang),
                  KarmaClubTravelWidget(data: data['rewards'], lang: lang),
                  KarmaClubPointTableWidget(
                      data: data['karmaPointsTables'], lang: lang),
                  KarmaClubFractionalOwnershipWidget(
                      data: data['fractionalOwnership'], lang: lang),
                  KarmaClubQuestionsWidget(data: data['questions'], lang: lang),
                  KarmaClubLocationsWidget(data: data['locations'], lang: lang)
                ],
              ),
            ),
    );
  }
}
