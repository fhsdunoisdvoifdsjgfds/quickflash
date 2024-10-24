import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:cached_network_image/cached_network_image.dart';

import '../../../core/config/app_colors.dart';
import '../../../core/models/news.dart';
import '../../../core/widgets/buttons/cuper_button.dart';
import '../../../core/widgets/texts/text_r.dart';

class NewsCard extends StatelessWidget {
  const NewsCard({super.key, required this.news});

  final News news;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 100,
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: const Color(0xff363636),
        borderRadius: BorderRadius.circular(6),
      ),
      child: CuperButton(
        onPressed: () {
          context.push('/news', extra: news);
        },
        child: Row(
          children: [
            const SizedBox(width: 10),
            ClipRRect(
              borderRadius: BorderRadius.circular(6),
              child: CachedNetworkImage(
                imageUrl: news.image,
                width: 130,
                height: 74,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 14),
                  TextB(news.title, fontSize: 12),
                  const Spacer(),
                  TextR(
                    news.body,
                    fontSize: 10,
                    color: AppColors.white50,
                    maxLines: 3,
                  ),
                  const Spacer(),
                  TextR(
                    news.date.replaceAll('.', '/'),
                    fontSize: 10,
                    color: AppColors.main,
                  ),
                  const SizedBox(height: 14),
                ],
              ),
            ),
            const SizedBox(width: 10),
          ],
        ),
      ),
    );
  }
}
