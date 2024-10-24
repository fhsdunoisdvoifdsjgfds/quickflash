import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../core/db/prefs.dart';
import '../../core/utils.dart';
import '../../core/config/app_colors.dart';
import '../../core/widgets/buttons/cuper_button.dart';
import '../../core/widgets/buttons/primary_button.dart';
import '../../core/widgets/custom_scaffold.dart';
import '../../core/widgets/texts/text_r.dart';

class OnboardPage extends StatefulWidget {
  const OnboardPage({super.key});

  @override
  State<OnboardPage> createState() => _OnboardPageState();
}

class _OnboardPageState extends State<OnboardPage> {
  int page = 1;

  String title = 'Welcome to\nQuick Flash Garage';
  String desc =
      'Immerse yourself in the world of cars and everything that goes with them. Find out the information you want to know directly from this app.';

  void onPage(int index) {
    page = index;
    setState(() {
      if (index == 1) {
        title = 'Welcome to\nQuick Flash Garage';
        desc =
            'Immerse yourself in the world of cars and everything that goes with them. Find out the information you want to know directly from this app.';
      } else if (index == 2) {
        title = 'Rent of any\ntransportation';
        desc =
            'In the app, you can pick up any mode of transportation that appeals to you at affordable prices.';
      } else {
        title = 'Lots of\nannouncements';
        desc =
            'Immerse yourself in the world of cars and everything that goes with them. Find out the information you want to know directly from this app.';
      }
    });
  }

  void onNext() {
    setState(() {
      if (page == 1) {
        page++;
        title = 'Rent of any\ntransportation';
        desc =
            'In the app, you can pick up any mode of transportation that appeals to you at affordable prices.';
      } else if (page == 2) {
        page++;
        title = 'Lots of\nannouncements';
        desc =
            'Immerse yourself in the world of cars and everything that goes with them. Find out the information you want to know directly from this app.';
      } else {
        onSkip();
      }
    });
  }

  void onSkip() async {
    await saveOnboard().then((value) {
      if (mounted) {
        context.go('/home');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          SizedBox(
            height: getWidth(context),
            child: Stack(
              children: [
                Image.asset(
                  'assets/onboard.png',
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Container(
                    width: double.infinity,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                        colors: [
                          AppColors.black.withOpacity(0),
                          AppColors.black,
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: [
              SizedBox(
                height: getWidth(context) > 800
                    ? getWidth(context) - 100
                    : getWidth(context) - 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _PageIndicator(
                    index: 1,
                    active: page == 1,
                    onPressed: onPage,
                  ),
                  const SizedBox(width: 15),
                  _PageIndicator(
                    index: 2,
                    active: page == 2,
                    onPressed: onPage,
                  ),
                  const SizedBox(width: 15),
                  _PageIndicator(
                    index: 3,
                    active: page == 3,
                    onPressed: onPage,
                  ),
                ],
              ),
              Center(
                child: Container(
                  height: 350,
                  width: 350,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  decoration: BoxDecoration(
                    color: AppColors.grey,
                    borderRadius: BorderRadius.circular(13),
                  ),
                  child: Column(
                    children: [
                      const SizedBox(height: 20),
                      TextH(
                        title,
                        fontSize: 28,
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 10),
                      TextR(
                        desc,
                        fontSize: 16,
                        maxLines: 5,
                        textAlign: TextAlign.center,
                      ),
                      const Spacer(),
                      PrimaryButton(
                        title: page == 3 ? 'Get Start' : 'Next',
                        onPressed: onNext,
                      ),
                      const SizedBox(height: 13),
                      page == 3
                          ? const SizedBox(height: 50)
                          : PrimaryButton(
                              title: 'Skip',
                              grey: true,
                              onPressed: onSkip,
                            ),
                      const SizedBox(height: 15),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PageIndicator extends StatelessWidget {
  const _PageIndicator({
    required this.index,
    required this.active,
    required this.onPressed,
  });

  final int index;
  final bool active;
  final void Function(int) onPressed;

  @override
  Widget build(BuildContext context) {
    return CuperButton(
      onPressed: () {
        onPressed(index);
      },
      minSize: 38,
      child: Container(
        height: 18,
        width: 18,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          color: active ? AppColors.main : AppColors.white,
        ),
      ),
    );
  }
}
