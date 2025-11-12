import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/good_karma/good_karma_banner_widget.dart';
import 'package:pitchbook/src/good_karma/good_karma_showcase_widget.dart';

class GoodKarmaScreen extends StatefulWidget {
  const GoodKarmaScreen({super.key});

  @override
  State<GoodKarmaScreen> createState() => _GoodKarmaScreenState();
}

class _GoodKarmaScreenState extends State<GoodKarmaScreen> {
  Map<String, dynamic> data = {};
  bool _isLoading = true;

  Future<void> _loadJsonData() async {
    final jsonData = await loadJsonFromAssets(AppAPI.goodKarma);
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
              child: Padding(
                padding: const EdgeInsets.only(bottom: 20),
                child: Column(
                  children: [
                    GoodKarmaBannerWidget(data: data['banner'], lang: lang),
                    // NoData(title: data['showcase']['categories'].toString())
                    GoodKarmaShowcaseWidget(data: data['showcase'], lang: lang),
                  ],
                ),
              ),
            ),
    );
  }
}
