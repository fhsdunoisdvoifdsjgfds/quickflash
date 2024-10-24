import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import 'package:quick_flash/core/widgets/others/no_data.dart';

import '../../../core/db/prefs.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/custom_scaffold.dart';
import '../../../core/widgets/texts/text_r.dart';
import '../../news/pages/news_page.dart';
import '../../offer/bloc/offer_bloc.dart';
import '../../reward/bloc/reward_bloc.dart';
import '../../reward/widgets/reward_dialog.dart';
import '../bloc/home_bloc.dart';
import '../widgets/nav_bar.dart';
import '../widgets/offer_card.dart';
import 'settings_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<RewardBloc>().add(CheckRewardEvent());
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: Stack(
        children: [
          BlocBuilder<HomeBloc, HomeState>(
            builder: (context, state) {
              if (state is HomeSettings) return const SettingsPage();

              if (state is HomeNews) return const NewsPage();

              return const _Home();
            },
          ),
          const NavBar(),
        ],
      ),
    );
  }
}

class _Home extends StatelessWidget {
  const _Home();

  @override
  Widget build(BuildContext context) {
    return BlocListener<RewardBloc, RewardState>(
      listener: (context, state) {
        if (state is RewardClaimingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return const RewardDialog();
            },
          );
        }
      },
      child: Stack(
        children: [
          Column(
            children: [
              SizedBox(height: getStatusBar(context) + 20),
              Row(
                children: [
                  const SizedBox(width: 26),
                  const TextH(
                    'Home',
                    fontSize: 28,
                  ),
                  const Spacer(),
                  BlocBuilder<RewardBloc, RewardState>(
                    builder: (context, state) {
                      return TextB(
                        coins.toString(),
                        fontSize: 20,
                      );
                    },
                  ),
                  const SizedBox(width: 4),
                  SvgPicture.asset(
                    'assets/coin.svg',
                    height: 40,
                  ),
                  const SizedBox(width: 26),
                ],
              ),
              const SizedBox(height: 20),
              BlocBuilder<OfferBloc, OfferState>(
                builder: (context, state) {
                  if (state is OfferLoadedState) {
                    if (state.offers.isEmpty) {
                      return const NoData();
                    }

                    return Expanded(
                      child: ListView(
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        children: [
                          const SizedBox(height: 16),
                          const Center(
                            child: TextM('Cars', fontSize: 18),
                          ),
                          const SizedBox(height: 26),
                          ...List.generate(
                            state.offers.length,
                            (index) {
                              return OfferCard(offer: state.offers[index]);
                            },
                          ),
                          const SizedBox(height: 96 + 32 + 50 + 30),
                        ],
                      ),
                    );
                  }

                  return Container();
                },
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 32,
                right: 32,
                bottom: 128,
              ),
              child: PrimaryButton(
                title: '+ Add New Offer',
                onPressed: () {
                  context.push('/offer-add');
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
