import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/home/home_awards_widget.dart';
import 'package:pitchbook/src/home/home_banner_widget.dart';
import 'package:pitchbook/src/home/home_experiences_widget.dart';
import 'package:pitchbook/src/home/home_moments_widget.dart';
import 'package:pitchbook/src/home/home_philanthropy.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic> data = {};
  bool _isLoading = true;

  Future<void> _loadJsonData() async {
    final jsonData = await loadJsonFromAssets(AppAPI.home);
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
                  HomeBannerWidget(data: data['banner'], lang: lang),
                  HomeExperiencesWidget(data: data['experience'], lang: lang),
                  HomePhilanthropyWidget(
                      data: data['philanthropy'], lang: lang),
                  HomeAwardsWidget(data: data['homeAwards'], lang: lang),
                  HomeMomentsWidget(data: data['moments'], lang: lang),
                ],
              ),
            ),
    );
  }
}
