// lib/features/articles/presentation/widgets/article_detail_image_placeholder.dart
import 'package:flutter/material.dart';

class ArticleDetailImagePlaceholder extends StatelessWidget {
  const ArticleDetailImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: colors.surfaceContainerHighest,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.photo_library, color: colors.primary, size: 60),
    );
  }
}
