import 'package:hive_flutter/hive_flutter.dart';

import '../models/offer.dart';
import '../utils.dart';

class DB {
  static String boxName = 'shablonbox';
  static String keyName = 'offersList';
  static List<Offer> offersList = [];
}

Future<void> initHive() async {
  try {
    await Hive.initFlutter();
    // await Hive.deleteBoxFromDisk(DB.boxName);
    Hive.registerAdapter(OfferAdapter());
  } catch (e) {
    logger(e);
  }
}

Future<void> getOffers() async {
  try {
    final box = await Hive.openBox(DB.boxName);
    List data = box.get(DB.keyName) ?? [];
    DB.offersList = data.cast<Offer>();
    logger(DB.offersList.length);
  } catch (e) {
    logger(e);
  }
}

Future<void> updateOffers() async {
  try {
    final box = await Hive.openBox(DB.boxName);
    box.put(DB.keyName, DB.offersList);
    DB.offersList = await box.get(DB.keyName);
  } catch (e) {
    logger(e);
  }
}
