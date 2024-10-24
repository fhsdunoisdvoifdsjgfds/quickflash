import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/offer.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/buttons/cuper_button.dart';
import '../../../core/widgets/texts/text_r.dart';

class OfferCard extends StatelessWidget {
  const OfferCard({super.key, required this.offer});

  final Offer offer;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 118,
      margin: const EdgeInsets.only(bottom: 30),
      decoration: BoxDecoration(
        color: const Color(0xff333333),
        borderRadius: BorderRadius.circular(13),
      ),
      child: CuperButton(
        onPressed: () {
          context.push('/offer-edit', extra: offer);
        },
        child: Row(
          children: [
            const SizedBox(width: 8),
            SvgPicture.asset(
              'assets/car${getSvgId(offer.transportType)}.svg',
            ),
            const Spacer(),
            Container(
              height: 100,
              width: 150,
              padding: const EdgeInsets.symmetric(horizontal: 15),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(13),
                border: Border.all(
                  color: AppColors.main,
                  width: 1,
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  TextR(offer.who, fontSize: 12),
                  TextR(offer.note, fontSize: 10),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      TextB(
                        '\$${offer.cost} ',
                        fontSize: 20,
                        color: AppColors.main,
                      ),
                      Expanded(
                        child: TextM(
                          '/per ${getPeriod(offer.paymentPeriod)}',
                          fontSize: 12,
                          color: AppColors.main,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(width: 20),
          ],
        ),
      ),
    );
  }
}
