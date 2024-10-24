import 'package:flutter/material.dart';

import '../../../core/widgets/texts/text_r.dart';

class FieldTitle extends StatelessWidget {
  const FieldTitle(this.title, {super.key});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: TextM(
        title,
        fontSize: 16,
      ),
    );
  }
}
