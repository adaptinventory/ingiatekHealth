import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

class AppLocalizations {
  final Locale locale;

  AppLocalizations(this.locale);

  static AppLocalizations? of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations);
  }

  late Map<String, dynamic> _localizedStrings;

  // Load the JSON file for the current locale
  Future<bool> load() async {
    String jsonString = await rootBundle.loadString('assets/lang/${locale.languageCode}.json');
    _localizedStrings = json.decode(jsonString);
    return true;
  }

  // Fetch the localized string based on the provided key
  String translate(String key) {
    List<String> keys = key.split('.');
    dynamic result = _localizedStrings;
    for (var k in keys) {
      result = result[k];
    }
    return result ?? key;
  }

  // Delegate class to be used in MaterialApp
  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'es', 'ht'].contains(locale.languageCode);  // Add other supported languages here
  }

  @override
  Future<AppLocalizations> load(Locale locale) async {
    AppLocalizations localizations = AppLocalizations(locale);
    await localizations.load();
    return localizations;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<AppLocalizations> old) => false;
}

class FallbackMaterialLocalizationsDelegate extends LocalizationsDelegate<MaterialLocalizations> {
  @override
  bool isSupported(Locale locale) {
    // Return true for unsupported locales to use fallback
    return ['ht'].contains(locale.languageCode);
  }

  @override
  Future<MaterialLocalizations> load(Locale locale) async {
    // Load default English for unsupported locales like 'ht'
    return await GlobalMaterialLocalizations.delegate.load(const Locale('en', ''));
  }

  @override
  bool shouldReload(FallbackMaterialLocalizationsDelegate old) => false;
}
