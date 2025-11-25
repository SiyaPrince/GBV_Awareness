import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/widgets/article_card.dart';
import '../../../../common/models/article.dart';

class InformationHubContent extends StatelessWidget {
  final List<Article> articles;

  const InformationHubContent({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final article in articles)
          Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: ArticleCard(article: article),
          ),
      ],
    );
  }
}
