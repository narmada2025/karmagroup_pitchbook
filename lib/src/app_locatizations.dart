import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pitchbook/constants/app_data.dart';

class AppLocalizations {
  final Locale locale;
  static Map<String, dynamic> _localizedStrings = {};

  AppLocalizations(this.locale);

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  Future<bool> load() async {
    String jsonString = await rootBundle.loadString(AppAPI.global);
    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localizedStrings = jsonMap;
    return true;
  }

  String translate(String key, String lang) {
    List<String> keys = key.split('.');
    dynamic value = _localizedStrings;
    for (String k in keys) {
      if (value is Map) {
        value = value[k];
      }
    }
    return value is Map && value[lang] is String ? value[lang] : key;
  }
}

class AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) =>
      ['en', 'de', 'fr', 'id'].contains(locale.languageCode);

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(AppLocalizationsDelegate old) => false;
}

String tr(BuildContext context, String key, String lang) {
  return AppLocalizations.of(context).translate(key, lang);
}
