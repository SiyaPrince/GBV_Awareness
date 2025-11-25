// lib/features/articles/presentation/widgets/article_detail_support_notice.dart
import 'package:flutter/material.dart';

class ArticleDetailSupportNotice extends StatelessWidget {
  const ArticleDetailSupportNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Icon(Icons.support, size: 40, color: colors.secondary),
          const SizedBox(height: 8),
          Text(
            "Need Support?",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: colors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            "If this content has brought up difficult feelings, support is available. "
            "You can reach out to our resources for help.",
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
