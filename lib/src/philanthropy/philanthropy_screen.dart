import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/philanthropy/philanthropy_banner_widget.dart';
import 'package:pitchbook/src/philanthropy/philanthropy_quote_widget.dart';
import 'package:pitchbook/src/philanthropy/philanthropy_slider_widget.dart';
import 'package:pitchbook/src/philanthropy/philanthropy_stats_widget.dart';

class PhilanthropyScreen extends StatefulWidget {
  const PhilanthropyScreen({super.key});

  @override
  State<PhilanthropyScreen> createState() => _PhilanthropyScreenState();
}

class _PhilanthropyScreenState extends State<PhilanthropyScreen> {
  Map<String, dynamic> data = {};
  bool _isLoading = true;

  Future<void> _loadJsonData() async {
    final jsonData = await loadJsonFromAssets(AppAPI.philanthropy);
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
                  // NoData(title: data.toString())
                  PhilanthropyBannerWidget(data: data['banner'], lang: lang),
                  PhilanthropyQuoteWidget(data: data['quote'][lang]),
                  PhilanthropyStatsWidget(data: data, lang: lang),
                  PhilanthropySliderWidget(data: data, lang: lang),
                ],
              ),
            ),
    );
  }
}
