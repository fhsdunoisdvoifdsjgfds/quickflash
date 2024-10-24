import 'package:flutter/material.dart';

import '../../config/app_colors.dart';
import '../buttons/cuper_button.dart';
import '../texts/text_r.dart';

class DeleteDialog extends StatelessWidget {
  const DeleteDialog({
    super.key,
    required this.title,
    required this.onYes,
  });

  final String title;
  final void Function() onYes;

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: AppColors.grey,
      child: SizedBox(
        height: 150,
        child: Column(
          children: [
            const SizedBox(height: 20),
            TextB(
              title,
              fontSize: 18,
            ),
            const Spacer(),
            Row(
              children: [
                const SizedBox(width: 20),
                _Button(
                  title: 'NO',
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
                const Spacer(),
                _Button(
                  title: 'YES',
                  onPressed: () {
                    Navigator.pop(context);
                    onYes();
                  },
                ),
                const SizedBox(width: 20),
              ],
            ),
            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }
}

class _Button extends StatelessWidget {
  const _Button({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return CuperButton(
      padding: 0,
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TextM(
            title,
            fontSize: 14,
          ),
        ],
      ),
    );
  }
}
