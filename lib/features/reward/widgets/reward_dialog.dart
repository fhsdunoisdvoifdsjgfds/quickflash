import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/widgets/buttons/primary_button.dart';
import '../../../core/widgets/texts/text_r.dart';
import '../bloc/reward_bloc.dart';

class RewardDialog extends StatelessWidget {
  const RewardDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: const Color(0xff333333),
      child: SizedBox(
        height: 320,
        child: Column(
          children: [
            const SizedBox(height: 14),
            SvgPicture.asset('assets/coin.svg'),
            const TextH(
              'Daily Reward',
              fontSize: 28,
            ),
            const SizedBox(height: 14),
            const TextR(
              'You earned an additional 100 coins today',
              fontSize: 16,
            ),
            const Spacer(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              child: PrimaryButton(
                title: 'Receive',
                onPressed: () async {
                  context.read<RewardBloc>().add(GetRewardEvent());
                  context.pop();
                },
              ),
            ),
            const SizedBox(height: 25),
          ],
        ),
      ),
    );
  }
}
