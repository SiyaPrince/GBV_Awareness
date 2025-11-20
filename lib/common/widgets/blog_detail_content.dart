import 'package:flutter/material.dart';
import '../../../common/models/article.dart';
import 'blog_detail_featured_badge.dart';
import 'blog_detail_meta_info.dart';
import 'blog_detail_image_placeholder.dart';
import 'blog_detail_tags_section.dart';
import 'blog_detail_support_notice.dart';

class BlogDetailContent extends StatelessWidget {
  final Article blog;

  const BlogDetailContent({super.key, required this.blog});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (blog.featured) BlogDetailFeaturedBadge(),
          const SizedBox(height: 16),

          Text(
            blog.title,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Theme.of(context).colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          BlogDetailMetaInfo(blog: blog),
          const SizedBox(height: 24),

          if (blog.imageUrl != null) BlogDetailImagePlaceholder(),
          const SizedBox(height: 16),

          Text(
            blog.summary,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),

          Text(blog.body, style: Theme.of(context).textTheme.bodyLarge),
          const SizedBox(height: 24),

          if (blog.tags.isNotEmpty) BlogDetailTagsSection(blog: blog),
          const SizedBox(height: 32),

          BlogDetailSupportNotice(),
        ],
      ),
    );
  }
}
