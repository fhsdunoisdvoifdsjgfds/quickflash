import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/widgets/buttons/cuper_button.dart';
import '../../../core/widgets/texts/text_r.dart';

class PaymentPeriod extends StatefulWidget {
  const PaymentPeriod({
    super.key,
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function(String) onPressed;

  @override
  State<PaymentPeriod> createState() => _PaymentPeriodState();
}

class _PaymentPeriodState extends State<PaymentPeriod> {
  bool expanded = false;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: expanded ? 150 : 50,
      decoration: BoxDecoration(
        color: const Color(0xff363636),
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        children: [
          if (expanded) ...[
            CuperButton(
              onPressed: () {
                setState(() {
                  if (expanded) {
                    expanded = false;
                    widget.onPressed('Daily');
                  } else {
                    expanded = true;
                  }
                });
              },
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    const SizedBox(width: 22),
                    const TextR('Daily', fontSize: 16),
                    const Spacer(),
                    RotatedBox(
                      quarterTurns: expanded ? 2 : 0,
                      child: SvgPicture.asset('assets/arrow-bottom.svg'),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),
            CuperButton(
              onPressed: () {
                setState(() {
                  if (expanded) {
                    expanded = false;
                    widget.onPressed('Weekly');
                  }
                });
              },
              child: const SizedBox(
                height: 50,
                child: Row(
                  children: [
                    SizedBox(width: 22),
                    TextR('Weekly', fontSize: 16),
                  ],
                ),
              ),
            ),
            CuperButton(
              onPressed: () {
                setState(() {
                  if (expanded) {
                    expanded = false;
                    widget.onPressed('Monthly');
                  }
                });
              },
              child: const SizedBox(
                height: 50,
                child: Row(
                  children: [
                    SizedBox(width: 22),
                    TextR('Monthly', fontSize: 16),
                  ],
                ),
              ),
            ),
          ] else
            CuperButton(
              onPressed: () {
                setState(() {
                  expanded = true;
                });
              },
              child: SizedBox(
                height: 50,
                child: Row(
                  children: [
                    const SizedBox(width: 22),
                    TextR(widget.title, fontSize: 16),
                    const Spacer(),
                    RotatedBox(
                      quarterTurns: expanded ? 2 : 0,
                      child: SvgPicture.asset('assets/arrow-bottom.svg'),
                    ),
                    const SizedBox(width: 16),
                  ],
                ),
              ),
            ),
        ],
      ),
    );
  }
}
