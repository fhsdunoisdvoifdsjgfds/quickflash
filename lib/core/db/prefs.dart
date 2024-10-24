import 'package:shared_preferences/shared_preferences.dart';

import '../utils.dart';

int lastReward = 0;
int coins = 0;

Future<bool> getData() async {
  try {
    final prefs = await SharedPreferences.getInstance();
    // await prefs.remove('onboard');
    // await prefs.clear();
    bool onboard = prefs.getBool('onboard') ?? true;
    lastReward = prefs.getInt('lastReward') ?? 0;
    coins = prefs.getInt('coins') ?? 0;
    return onboard;
  } catch (e) {
    logger(e);
    return true;
  }
}

Future<void> saveOnboard() async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool('onboard', false);
}

Future<void> saveString(String key, String value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

Future<void> saveInt(String key, int value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

Future<void> saveBool(String key, bool value) async {
  final prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

Future<int> getCoins() async {
  final prefs = await SharedPreferences.getInstance();
  coins = prefs.getInt('coins') ?? 0;
  return coins;
}

Future<void> saveCoins() async {
  final prefs = await SharedPreferences.getInstance();
  coins = coins + 100;
  lastReward = getCurrentTimestamp();
  prefs.setInt('coins', coins);
  prefs.setInt('lastReward', lastReward);
}
