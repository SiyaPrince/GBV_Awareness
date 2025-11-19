import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gbv_awareness/common/widgets/article_card_widget.dart';
import '../../../common/services/content_service.dart';
import '../../../common/models/article.dart';

class InformationHubPage extends ConsumerStatefulWidget {
  const InformationHubPage({super.key});

  @override
  ConsumerState<InformationHubPage> createState() => _InformationHubPageState();
}

class _InformationHubPageState extends ConsumerState<InformationHubPage> {
  final TextEditingController _searchController = TextEditingController();
  String _searchQuery = '';
  String? _selectedCategory;

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Page Title
          Text(
            'Information Hub',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          // Search and Filter
          _buildSearchAndFilter(context),
          const SizedBox(height: 16),

          // Articles
          StreamBuilder<List<Article>>(
            stream: _getArticlesStream(ref),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }

              if (snapshot.hasError) {
                return _buildErrorWidget(context, 'Failed to load information');
              }

              final articles = snapshot.data ?? [];

              if (articles.isEmpty) {
                return _buildEmptyWidget(context, 'No content found');
              }

              return Column(
                children: articles
                    .map(
                      (article) => Padding(
                        padding: const EdgeInsets.only(bottom: 16.0),
                        child: ArticleCardWidget(article: article),
                      ),
                    )
                    .toList(),
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildSearchAndFilter(BuildContext context) {
    return Column(
      children: [
        // Search Bar
        TextField(
          controller: _searchController,
          decoration: InputDecoration(
            hintText: 'Search for information...',
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
            suffixIcon: _searchQuery.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () {
                      _searchController.clear();
                      setState(() => _searchQuery = '');
                    },
                  )
                : null,
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(25.0),
            ),
          ),
          onChanged: (value) => setState(() => _searchQuery = value),
        ),
        const SizedBox(height: 16),

        // Categories/Tags Filter
        StreamBuilder<List<String>>(
          stream: ref.read(contentServiceProvider).getAllTags(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();
            final categories = snapshot.data!;
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: _selectedCategory == null,
                    onSelected: (_) => setState(() => _selectedCategory = null),
                  ),
                  ...categories.map(
                    (category) => Padding(
                      padding: const EdgeInsets.only(left: 8.0),
                      child: FilterChip(
                        label: Text(category),
                        selected: _selectedCategory == category,
                        onSelected: (_) =>
                            setState(() => _selectedCategory = category),
                      ),
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ],
    );
  }

  Stream<List<Article>> _getArticlesStream(WidgetRef ref) {
    final contentService = ref.read(contentServiceProvider);

    if (_searchQuery.isNotEmpty) {
      return contentService
          .searchContent(_searchQuery)
          .map(
            (articles) => articles.where((a) => a.type == 'article').toList(),
          );
    }

    if (_selectedCategory != null) {
      return contentService
          .getArticlesByTag(_selectedCategory!)
          .map(
            (articles) => articles.where((a) => a.type == 'article').toList(),
          );
    }

    return contentService.getArticles();
  }

  Widget _buildErrorWidget(BuildContext context, String message) {
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
          Text(message, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          TextButton(
            onPressed: () => setState(() {}),
            child: const Text('Try Again'),
          ),
        ],
      ),
    );
  }

  Widget _buildEmptyWidget(BuildContext context, String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.info_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(message, style: Theme.of(context).textTheme.titleMedium),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your search or filters',
            style: Theme.of(context).textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
