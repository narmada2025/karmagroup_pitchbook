import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/accolades/accolades_awards_widget.dart';
import 'package:pitchbook/src/accolades/accolades_banner_widget.dart';

class AccoladesScreen extends StatefulWidget {
  const AccoladesScreen({super.key});

  @override
  State<AccoladesScreen> createState() => _AccoladesScreenState();
}

class _AccoladesScreenState extends State<AccoladesScreen> {
  Map<String, dynamic> data = {};
  bool _isLoading = true;

  Future<void> _loadJsonData() async {
    final jsonData = await loadJsonFromAssets(AppAPI.awards);
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
                  AccoladesBannerWidget(data: data['banner'], lang: lang),
                  AccoladesAwardsWidget(
                      data: data['awardExperiences'], lang: lang),
                ],
              ),
            ),
    );
  }
}
