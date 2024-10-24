import 'package:go_router/go_router.dart';

import '../../features/home/pages/home_page.dart';
import '../../features/news/pages/news_detail_page.dart';
import '../../features/offer/pages/offer_add_page.dart';
import '../../features/offer/pages/offer_add_page2.dart';
import '../../features/offer/pages/offer_add_page3.dart';
import '../../features/offer/pages/offer_edit_page.dart';
import '../../features/offer/pages/offer_edit_page2.dart';
import '../../features/offer/pages/offer_edit_page3.dart';
import '../../features/splash/onboard_page.dart';
import '../../features/splash/splash_page.dart';
import '../models/news.dart';
import '../models/offer.dart';

final routerConfig = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashPage(),
    ),
    GoRoute(
      path: '/onboard',
      builder: (context, state) => const OnboardPage(),
    ),
    GoRoute(
      path: '/home',
      builder: (context, state) => const HomePage(),
    ),
    GoRoute(
      path: '/offer-add',
      builder: (context, state) => const OfferAddPage(),
    ),
    GoRoute(
      path: '/offer-add-2',
      builder: (context, state) => OfferAddPage2(
        offer: state.extra as Offer,
      ),
    ),
    GoRoute(
      path: '/offer-add-3',
      builder: (context, state) => OfferAddPage3(
        offer: state.extra as Offer,
      ),
    ),
    GoRoute(
      path: '/offer-edit',
      builder: (context, state) => OfferEditPage(
        offer: state.extra as Offer,
      ),
    ),
    GoRoute(
      path: '/offer-edit-2',
      builder: (context, state) => OfferEditPage2(
        offer: state.extra as Offer,
      ),
    ),
    GoRoute(
      path: '/offer-edit-3',
      builder: (context, state) => OfferEditPage3(
        offer: state.extra as Offer,
      ),
    ),
    GoRoute(
      path: '/news',
      builder: (context, state) => NewsDetailPage(
        news: state.extra as News,
      ),
    ),
  ],
);
