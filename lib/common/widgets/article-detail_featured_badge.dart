// lib/features/articles/presentation/widgets/article_detail_featured_badge.dart
import 'package:flutter/material.dart';

class ArticleDetailFeaturedBadge extends StatelessWidget {
  const ArticleDetailFeaturedBadge({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: Colors.orange,
        borderRadius: BorderRadius.circular(4),
      ),
      child: Text(
        'FEATURED',
        style: Theme.of(context).textTheme.labelSmall?.copyWith(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
