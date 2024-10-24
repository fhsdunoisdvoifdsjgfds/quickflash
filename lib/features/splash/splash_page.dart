import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../core/config/app_colors.dart';
import '../../core/db/prefs.dart';
import '../../core/widgets/custom_scaffold.dart';
import '../offer/bloc/offer_bloc.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool loading = false;

  void load() async {
    await getData().then((onboard) {
      if (mounted) {
        context.read<OfferBloc>().add(GetOfferEvent());
      }

      Future.delayed(Duration.zero, () {
        setState(() {
          loading = true;
        });
      });

      Future.delayed(const Duration(seconds: 2), () {
        if (mounted) {
          if (onboard) {
            context.go('/onboard');
          } else {
            context.go('/home');
          }
        }
      });
    });
  }

  @override
  void initState() {
    super.initState();
    load();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Column(
        children: [
          const Spacer(),
          SizedBox(
            height: 250,
            width: 250,
            child: Image.asset('assets/logo.png'),
          ),
          const Spacer(),
          Center(
            child: Container(
              height: 11,
              width: 270,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(23),
                color: const Color(0xffD9D9D9),
              ),
              child: Row(
                children: [
                  AnimatedContainer(
                    duration: const Duration(seconds: 2),
                    height: 11,
                    width: loading ? 270 : 0,
                    decoration: BoxDecoration(
                      color: AppColors.main,
                      borderRadius: BorderRadius.circular(19),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Spacer(),
        ],
      ),
    );
  }
}
