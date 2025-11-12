import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/partnerships/partnerships_banner_widget.dart';
import 'package:pitchbook/src/partnerships/partnerships_guest_widget.dart';
import 'package:pitchbook/src/partnerships/partnerships_section_one_widget.dart';

class PartnershipsScreen extends StatefulWidget {
  const PartnershipsScreen({super.key});

  @override
  State<PartnershipsScreen> createState() => _PartnershipsScreenState();
}

class _PartnershipsScreenState extends State<PartnershipsScreen> {
  Map<String, dynamic> data = {};
  bool _isLoading = true;

  Future<void> _loadJsonData() async {
    final jsonData = await loadJsonFromAssets(AppAPI.partnerships);
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
    // print("======partnership ${data['guest']}");
    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    return Scaffold(
      backgroundColor: AppColors.black,
      body: _isLoading
          ? const LoadingComponent()
          : SingleChildScrollView(
              child: Column(
                children: [
                  if (data['banner'] != null)
                    PartnershipsBannerWidget(data: data['banner'], lang: lang),
                  if (!_isLoading)
                    PartnershipsSectionOneWidget(
                        data: data['partnership'], lang: lang),
                  if (!_isLoading)
                    PartnershipsGuestWidget(data: data['guest'], lang: lang),
                ],
              ),
            ),
    );
  }
}
