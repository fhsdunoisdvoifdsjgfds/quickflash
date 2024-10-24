import 'package:flutter/material.dart';

import '../../../core/models/news.dart';
import '../../../core/utils.dart';
import '../../../core/widgets/texts/text_r.dart';
import '../widgets/news_card.dart';

class NewsPage extends StatelessWidget {
  const NewsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(height: getStatusBar(context) + 20),
        const Row(
          children: [
            SizedBox(width: 26),
            TextH(
              'News',
              fontSize: 28,
            ),
          ],
        ),
        const SizedBox(height: 20),
        Expanded(
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 30),
            children: [
              const SizedBox(height: 16),
              const Center(
                child: TextM('Popular news', fontSize: 18),
              ),
              const SizedBox(height: 20),
              ...List.generate(
                popularNewsList.length,
                (index) {
                  return NewsCard(news: popularNewsList[index]);
                },
              ),
              const SizedBox(height: 26),
              const Center(
                child: TextM('Recent news', fontSize: 18),
              ),
              const SizedBox(height: 20),
              ...List.generate(
                newsList.length,
                (index) {
                  return NewsCard(news: newsList[index]);
                },
              ),
              const SizedBox(height: 110),
            ],
          ),
        ),
      ],
    );
  }
}
