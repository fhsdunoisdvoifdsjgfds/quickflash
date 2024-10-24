import 'package:flutter/cupertino.dart';

import '../../config/app_colors.dart';
import '../texts/text_r.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    super.key,
    required this.title,
    this.active = true,
    this.grey = false,
    this.width,
    required this.onPressed,
  });

  final String title;
  final bool active;
  final bool grey;
  final double? width;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 50,
      width: width,
      decoration: BoxDecoration(
        color: grey
            ? const Color(0xff363636)
            : active
                ? AppColors.main
                : const Color(0xff363636),
        borderRadius: BorderRadius.circular(50),
      ),
      child: CupertinoButton(
        onPressed: active ? onPressed : null,
        padding: EdgeInsets.zero,
        child: Center(
          child: TextH(
            title,
            fontSize: 18,
            color: AppColors.white,
          ),
        ),
      ),
    );
  }
}
