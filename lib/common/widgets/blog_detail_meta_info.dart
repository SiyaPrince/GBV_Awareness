import 'package:flutter/material.dart';
import '../../../common/models/article.dart';

class BlogDetailMetaInfo extends StatelessWidget {
  final Article blog;

  const BlogDetailMetaInfo({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          '${blog.publishedAt.day}/${blog.publishedAt.month}/${blog.publishedAt.year}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Spacer(),
        const Icon(Icons.person, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          blog.author ?? 'Anonymous',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }
}
