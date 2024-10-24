import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/widgets/buttons/cuper_button.dart';
import '../../../core/widgets/texts/text_r.dart';

class TypeCard extends StatelessWidget {
  const TypeCard({
    super.key,
    required this.id,
    required this.title,
    required this.active,
    required this.onPressed,
  });

  final int id;
  final String title;
  final bool active;
  final void Function(String) onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      decoration: BoxDecoration(
        color: const Color(0xff222222),
        borderRadius: BorderRadius.circular(16),
        border: active
            ? Border.all(
                color: AppColors.main,
              )
            : null,
      ),
      child: CuperButton(
        onPressed: () {
          onPressed(title);
        },
        child: Row(
          children: [
            const SizedBox(width: 16),
            SizedBox(
              width: 92,
              child: Center(
                child: SvgPicture.asset('assets/car$id.svg'),
              ),
            ),
            const SizedBox(width: 16),
            TextR(title, fontSize: 16),
            const Spacer(),
            Container(
              height: 20,
              width: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: active ? AppColors.main : null,
                border: Border.all(
                  color: const Color(0xff363636),
                ),
              ),
            ),
            const SizedBox(width: 32),
          ],
        ),
      ),
    );
  }
}
