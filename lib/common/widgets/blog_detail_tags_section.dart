import 'package:flutter/material.dart';
import '../../../common/models/article.dart';

class BlogDetailTagsSection extends StatelessWidget {
  final Article blog;

  const BlogDetailTagsSection({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Tags:',
          style: Theme.of(
            context,
          ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          children: blog.tags.map((tag) {
            return Chip(
              label: Text(tag),
              backgroundColor: colors.secondaryContainer,
            );
          }).toList(),
        ),
      ],
    );
  }
}
