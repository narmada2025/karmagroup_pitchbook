import 'package:flutter/material.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/go_back.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/partnerships_reciprocal/partnerships_reciprocal_alliance_network_widget.dart';
import 'package:pitchbook/src/partnerships_reciprocal/partnerships_reciprocal_banner_widget.dart';
import 'package:pitchbook/src/partnerships_reciprocal/partnerships_reciprocal_strategic_partnerships_widget.dart';

import 'partnership_reciprocal_widget.dart';

class PartnershipsReciprocalScreen extends StatefulWidget {
  const PartnershipsReciprocalScreen({super.key});

  @override
  State<PartnershipsReciprocalScreen> createState() =>
      _PartnershipsReciprocalScreenState();
}

class _PartnershipsReciprocalScreenState
    extends State<PartnershipsReciprocalScreen> {
  Map<String, dynamic> data = {};
  bool _isLoading = true;

  Future<void> _loadJsonData() async {
    final jsonData = await loadJsonFromAssets(AppAPI.reciprocalPartnerships);
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
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 20),
                    child: Column(
                      children: [
                        PartnershipsReciprocalBannerWidget(
                            data: data['banner'], lang: lang),
                        PartnershipReciprocalWidget(
                            data: data['reciprocal'], lang: lang),
                        PartnershipReciprocalAllianceNetworkWidget(
                            data: data['alliance'], lang: lang),
                        PartnershipsReciprocalStrategicPartnershipsWidget(
                            data: data['strategic'], lang: lang),
                      ],
                    ),
                  ),
                ),
                const GoBack()
              ],
            ),
    );
  }
}
