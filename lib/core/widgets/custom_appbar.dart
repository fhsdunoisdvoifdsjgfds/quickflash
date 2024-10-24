import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../features/offer/bloc/offer_bloc.dart';
import '../config/app_colors.dart';
import '../models/offer.dart';
import '../utils.dart';
import 'buttons/cuper_button.dart';
import 'dialogs/delete_dialog.dart';
import 'texts/text_r.dart';

class CustomAppbar extends StatelessWidget {
  const CustomAppbar(
    this.title, {
    super.key,
    this.offer,
  });

  final String title;
  final Offer? offer;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getStatusBar(context) + 20),
        Row(
          children: [
            const SizedBox(width: 30),
            CuperButton(
              onPressed: () {
                context.pop();
              },
              child: SvgPicture.asset('assets/arrow.svg'),
            ),
            const SizedBox(width: 16),
            TextH(title, fontSize: 18),
            if (offer != null) ...[
              const Spacer(),
              CuperButton(
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return DeleteDialog(
                        title: 'Delete Offer?',
                        onYes: () {
                          context
                              .read<OfferBloc>()
                              .add(DeleteOfferEvent(id: offer!.id));
                          context.pop();
                        },
                      );
                    },
                  );
                },
                child: const Icon(
                  Icons.delete,
                  color: AppColors.main,
                ),
              ),
              const SizedBox(width: 30),
            ]
          ],
        ),
        const SizedBox(height: 20),
      ],
    );
  }
}
