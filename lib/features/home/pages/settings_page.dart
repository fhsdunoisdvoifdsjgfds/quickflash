import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:quick_flash/core/config/app_colors.dart';
import 'package:quick_flash/core/widgets/buttons/cuper_button.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../core/utils.dart';
import '../../../core/widgets/texts/text_r.dart';

class SettingsPage extends StatefulWidget {
  const SettingsPage({super.key});

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  Future<void> launchURL(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      await launchUrl(
        Uri.parse(url),
        mode: LaunchMode.externalApplication,
      );
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getStatusBar(context) + 20),
        const Row(
          children: [
            SizedBox(width: 26),
            TextH(
              'Settings',
              fontSize: 28,
            ),
          ],
        ),
        const SizedBox(height: 28),
        _Tile(
          title: 'Privacy Policy',
          onPressed: () => launchURL(
              'https://docs.google.com/document/d/1oxvUvLaT4FNnFIQzfMlOpqbWzgJQPxfqbs1ei7rBVjk/edit?usp=sharing'),
        ),
        const SizedBox(height: 14),
        _Tile(
          title: 'Terms Conditions',
          onPressed: () => launchURL(
              'https://docs.google.com/document/d/1AUSGiPjdT5Q4PRjEAl5qJ22R3t4KQ6IXAydvDJVeqXQ/edit?usp=sharing'),
        ),
        const SizedBox(height: 14),
        _Tile(
          title: 'Write Support',
          onPressed: () => launchURL('https://forms.gle/Www1N6w84fWAL7Bp7'),
        ),
      ],
    );
  }
}

class _Tile extends StatelessWidget {
  const _Tile({
    required this.title,
    required this.onPressed,
  });

  final String title;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 64,
      margin: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        color: const Color(0xff222222),
        borderRadius: BorderRadius.circular(14),
      ),
      child: CuperButton(
        onPressed: onPressed,
        child: Row(
          children: [
            const SizedBox(width: 16),
            TextB(
              title,
              fontSize: 14,
              color: AppColors.main,
            ),
            const Spacer(),
            SvgPicture.asset('assets/arrow-right.svg'),
            const SizedBox(width: 16),
          ],
        ),
      ),
    );
  }
}
