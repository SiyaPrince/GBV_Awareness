import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../common/services/content_service.dart';
import '../../../common/models/article.dart';

class ArticleDetailPage extends ConsumerStatefulWidget {
  final String id;

  const ArticleDetailPage({super.key, required this.id});

  @override
  ConsumerState<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends ConsumerState<ArticleDetailPage> {
  late Future<Article?> _articleFuture;

  @override
  void initState() {
    super.initState();
    _articleFuture = _loadArticle();
  }

  Future<Article?> _loadArticle() async {
    final contentService = ref.read(contentServiceProvider);
    return await contentService.getArticleById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Article Details'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: FutureBuilder<Article?>(
        future: _articleFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError || snapshot.data == null) {
            return _buildErrorWidget(context);
          }

          final article = snapshot.data!;
          return _buildArticleContent(context, article);
        },
      ),
    );
  }

  Widget _buildArticleContent(BuildContext context, Article article) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (article.featured) _buildFeaturedBadge(context),
          const SizedBox(height: 16),

          Text(
            article.title,
            style: textTheme.headlineMedium?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _buildMetaInfo(context, article),
          const SizedBox(height: 24),

          if (article.imageUrl != null) _buildImagePlaceholder(context),
          const SizedBox(height: 16),

          Text(
            article.summary,
            style: textTheme.titleLarge?.copyWith(fontStyle: FontStyle.italic),
          ),
          const SizedBox(height: 24),

          Text(article.body, style: textTheme.bodyLarge),
          const SizedBox(height: 24),

          if (article.tags.isNotEmpty) _buildTagsSection(context, article),
          const SizedBox(height: 32),

          _buildSupportNotice(context),
        ],
      ),
    );
  }

  Widget _buildFeaturedBadge(BuildContext context) {
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

  Widget _buildMetaInfo(BuildContext context, Article article) {
    return Row(
      children: [
        Icon(Icons.calendar_today, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          '${article.publishedAt.day}/${article.publishedAt.month}/${article.publishedAt.year}',
          style: Theme.of(context).textTheme.bodySmall,
        ),
        const Spacer(),
        Icon(Icons.person, size: 16, color: Colors.grey),
        const SizedBox(width: 4),
        Text(
          article.author ?? 'Anonymous',
          style: Theme.of(context).textTheme.bodySmall,
        ),
      ],
    );
  }

  Widget _buildImagePlaceholder(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.photo_library, size: 64, color: colors.primary),
    );
  }

  Widget _buildTagsSection(BuildContext context, Article article) {
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
          children: article.tags.map((tag) {
            return Chip(
              label: Text(tag),
              backgroundColor: colors.secondaryContainer,
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildSupportNotice(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16.0),
      decoration: BoxDecoration(
        color: colors.secondaryContainer,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Column(
        children: [
          Icon(Icons.support, size: 40, color: colors.secondary),
          const SizedBox(height: 8),
          Text(
            'Need Support?',
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              color: colors.secondary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'If this content has brought up difficult feelings, remember that support is available. '
            'You can reach out to our support resources for help.',
            textAlign: TextAlign.center,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  Widget _buildErrorWidget(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          Text(
            'Article not found',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Go Back'),
          ),
        ],
      ),
    );
  }
}
