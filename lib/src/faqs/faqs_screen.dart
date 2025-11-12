import 'package:flutter/material.dart';
import 'package:pitchbook/components/accordian_item.dart';
import 'package:pitchbook/components/fade_in_animation.dart';
import 'package:pitchbook/constants/app_data.dart';
import 'package:pitchbook/constants/custom_text.dart';
import 'package:pitchbook/constants/go_back.dart';
import 'package:pitchbook/constants/loading_component.dart';
import 'package:pitchbook/constants/no_data.dart';
import 'package:pitchbook/helpers/helper.dart';
import 'package:pitchbook/src/app_locatizations.dart';

class FaqsScreen extends StatefulWidget {
  final Map<String, dynamic>? args;

  const FaqsScreen(this.args, {super.key});

  @override
  State<FaqsScreen> createState() => _FaqsScreenState();
}

class _FaqsScreenState extends State<FaqsScreen> {
  Map<String, dynamic> data = {};
  bool _isLoading = true;
  late String _selectedKey;

  Future<void> _loadJsonData() async {
    final jsonData = await loadJsonFromAssets(AppAPI.faq);
    setState(() {
      data = jsonData;
      if (data['faqs'] != null && data['faqs'].isNotEmpty) {
        _selectedKey = data['faqs'].keys.first;
      }
      _isLoading = false;
    });
  }

  void changeFaq(String key) {
    setState(() {
      _selectedKey = key;
    });
  }

  @override
  void initState() {
    super.initState();
    _loadJsonData();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    Locale locale = Localizations.localeOf(context);
    String lang = locale.languageCode;

    return Scaffold(
      body: _isLoading
          ? const LoadingComponent()
          : Stack(
              children: [
                SingleChildScrollView(
                  child: Container(
                    width: size.width,
                    padding: const EdgeInsets.fromLTRB(120, 80, 120, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        FadeInAnimation(
                          child: CustomText(
                            label: data['title'][lang],
                            type: 'h2',
                            textAlign: TextAlign.center,
                            isSerif: true,
                          ),
                        ),
                        const SizedBox(height: 40),
                        FadeInAnimation(
                          delay: const Duration(milliseconds: 200),
                          child: Wrap(
                            direction: Axis.horizontal,
                            spacing: 30,
                            children: [
                              ...data['category'] != null
                                  ? data['category']
                                      .entries
                                      .map<Widget>((entry) {
                                      return TextButton(
                                        onPressed: () => changeFaq(entry.key),
                                        child: CustomText(
                                          label: entry.value[lang],
                                          type: 'lg',
                                          textStyle: _selectedKey == entry.key
                                              ? const TextStyle(
                                                  color: AppColors.primary,
                                                  fontWeight: FontWeight.bold)
                                              : const TextStyle(
                                                  color: AppColors.gray),
                                        ),
                                      );
                                    }).toList()
                                  : [
                                      NoData(
                                          title: tr(
                                              context,
                                              'errors.Content not available',
                                              lang))
                                    ],
                            ],
                          ),
                        ),
                        const SizedBox(height: 20),
                        data['faqs'][_selectedKey] != null
                            ? FadeInAnimation(
                                delay: const Duration(milliseconds: 300),
                                child: SizedBox(
                                  width: double.infinity,
                                  child: Column(
                                    children: [
                                      ...data['faqs'][_selectedKey]
                                          .map<Widget>((faq) {
                                        return CustomAccordionItem(
                                          faq: faq,
                                          lang: lang,
                                        );
                                      }).toList()
                                    ],
                                  ),
                                ),
                              )
                            : NoData(
                                title: tr(context,
                                    'errors.Content not available', lang))
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
