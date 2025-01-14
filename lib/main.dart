import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'Authentication/LoginScreen.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:firebase_ui_localizations/firebase_ui_localizations.dart';

import 'Utils/AppLocalization.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //await Firebase.initializeApp();
  // Load saved locale
  LocaleProvider localeProvider = LocaleProvider();
  await localeProvider.loadLocale();
  runApp(
    ChangeNotifierProvider(
      create: (_) => localeProvider,
      child: MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  // This widget is the root of your application.
  Map<String, Map<String, String>> localizedLabels = {};

  @override
  void initState() {
    super.initState();
    loadLocalizationFiles();
  }

  Future<void> loadLocalizationFiles() async {
    final enData = await loadJsonAsset('assets/lang/en.json');
    final esData = await loadJsonAsset('assets/lang/es.json');

    setState(() {
      localizedLabels = {
        'en': enData,
        'es': esData,
      };
    });
  }

  Future<Map<String, String>> loadJsonAsset(String path) async {
    final jsonString = await rootBundle.loadString(path);
    final Map<String, dynamic> jsonMap = json.decode(jsonString);
    return jsonMap.map((key, value) => MapEntry(key, value.toString()));
  }

  @override
  Widget build(BuildContext context) {
    final localeProvider = Provider.of<LocaleProvider>(context);
    return MaterialApp(
      title: 'IngiaTek Health',
      supportedLocales: const [
        Locale('en'),
        Locale('es'),
        Locale('ht'),
      ],
      locale: localeProvider.locale,
      localizationsDelegates: [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        // Custom fallback for unsupported locales
        FallbackMaterialLocalizationsDelegate(),

      ],
        localeResolutionCallback: (locale, supportedLocales) {
          // Fallback to a supported locale if the device's locale is not supported
          for (Locale supportedLocale in supportedLocales) {
            if (supportedLocale.languageCode == locale?.languageCode) {
              return supportedLocale;
            }
          }
          return supportedLocales.first; // Fallback to English by default
        },
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: LoginPasswordScreen(),
    );
  }
}

class LocaleProvider with ChangeNotifier {
  Locale _locale = Locale('en');

  Locale get locale => _locale;

  Future<void> setLocale(Locale locale) async{
    _locale = locale;
    notifyListeners();
    // Save the selected locale
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString('locale', locale.languageCode);
  }
  // Load the saved locale from SharedPreferences
  Future<void> loadLocale() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String? localeCode = prefs.getString('locale');
    if (localeCode != null) {
      _locale = Locale(localeCode);
      notifyListeners();
    }
  }
}

