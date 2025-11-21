import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../../common/models/article.dart';
import 'article_detail_featured_badge.dart';
import 'article_detail_meta_info.dart';
import 'article_detail_image_placeholder.dart';
import 'article_detail_tags_section.dart';
import 'article_detail_support_notice.dart';

class ArticleDetailContent extends StatelessWidget {
  final Article article;

  const ArticleDetailContent({super.key, required this.article});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // BACK BUTTON
          Row(
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back, color: colors.primary, size: 26),
                onPressed: () => context.go('/info'),
              ),
              const SizedBox(width: 8),
              Text(
                "Back",
                style: textTheme.titleMedium?.copyWith(
                  color: colors.primary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),

          if (article.featured) const ArticleDetailFeaturedBadge(),
          const SizedBox(height: 16),

          Text(
            article.title,
            style: textTheme.headlineMedium?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 16),
          ArticleDetailMetaInfo(article: article),
          const SizedBox(height: 24),

          // Display actual image if available
          if (article.imageUrl != null && article.imageUrl!.isNotEmpty) ...[
            ArticleDetailImagePlaceholder(imageUrl: article.imageUrl!),
            const SizedBox(height: 16),
          ],

          Text(
            article.summary,
            style: textTheme.titleLarge?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),

          Text(
            article.body,
            style: textTheme.bodyLarge?.copyWith(
              height: 1.6, // Better line spacing for readability
            ),
          ),
          const SizedBox(height: 24),

          if (article.tags.isNotEmpty)
            ArticleDetailTagsSection(article: article),
          const SizedBox(height: 32),

          const ArticleDetailSupportNotice(),
        ],
      ),
    );
  }
}
