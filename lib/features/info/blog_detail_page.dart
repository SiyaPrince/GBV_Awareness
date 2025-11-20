import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gbv_awareness/common/widgets/blog_detail_content.dart';
import 'package:gbv_awareness/common/widgets/blog_detail_error_widget.dart';
import '../../../common/services/content_service.dart';
import '../../../common/models/article.dart';

class BlogDetailPage extends ConsumerStatefulWidget {
  final String id;
  const BlogDetailPage({super.key, required this.id});

  @override
  ConsumerState<BlogDetailPage> createState() => _BlogDetailPageState();
}

class _BlogDetailPageState extends ConsumerState<BlogDetailPage> {
  late Future<Article?> _blogFuture;

  @override
  void initState() {
    super.initState();
    _blogFuture = _loadBlog();
  }

  Future<Article?> _loadBlog() async {
    final contentService = ref.read(contentServiceProvider);
    return await contentService.getArticleById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          // Custom App Bar
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 16),
            color: Theme.of(context).colorScheme.primary,
            child: SafeArea(
              child: Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.white),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'Blog Post',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          // Content Area
          FutureBuilder<Article?>(
            future: _blogFuture,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return SizedBox(
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: const Center(child: CircularProgressIndicator()),
                );
              }

              if (snapshot.hasError || snapshot.data == null) {
                return BlogDetailErrorWidget(
                  onBack: () => Navigator.pop(context),
                );
              }

              final blog = snapshot.data!;
              return BlogDetailContent(blog: blog);
            },
          ),
        ],
      ),
    );
  }
}
