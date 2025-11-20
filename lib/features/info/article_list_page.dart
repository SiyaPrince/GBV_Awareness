import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gbv_awareness/common/widgets/article_card.dart';
import 'package:gbv_awareness/common/widgets/article_list_empty_widget.dart';
import 'package:gbv_awareness/common/widgets/article_list_error_widget.dart';
import 'package:gbv_awareness/common/widgets/article_search_filter_section.dart';
import '../../../common/services/content_service.dart';
import '../../../common/models/article.dart';

/// Local filter state for this page
final articleSearchQueryProvider = StateProvider.autoDispose<String>(
  (ref) => '',
);
final articleSelectedTagProvider = StateProvider.autoDispose<String?>(
  (ref) => null,
);

class ArticleListPage extends ConsumerStatefulWidget {
  const ArticleListPage({super.key});

  @override
  ConsumerState<ArticleListPage> createState() => _ArticleListPageState();
}

class _ArticleListPageState extends ConsumerState<ArticleListPage> {
  late final TextEditingController _searchController;

  @override
  void initState() {
    super.initState();
    _searchController = TextEditingController();
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final articlesAsync = ref.watch(articlesStreamProvider);
    final searchQuery = ref.watch(articleSearchQueryProvider);
    final selectedTag = ref.watch(articleSelectedTagProvider);

    if (_searchController.text != searchQuery) {
      _searchController.value = _searchController.value.copyWith(
        text: searchQuery,
      );
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('Educational Articles'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          ArticleSearchFilterSection(
            searchController: _searchController,
            searchQuery: searchQuery,
            selectedTag: selectedTag,
          ),
          Expanded(
            child: articlesAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) => ArticleListErrorWidget(
                message: 'Error loading articles',
                onRetry: () => setState(() {}),
              ),
              data: (articles) {
                // Apply filters locally
                List<Article> filtered = articles;

                if (selectedTag != null) {
                  filtered = filtered
                      .where((a) => a.tags.contains(selectedTag))
                      .toList();
                }

                if (searchQuery.isNotEmpty) {
                  final q = searchQuery.toLowerCase();
                  filtered = filtered
                      .where(
                        (a) =>
                            a.title.toLowerCase().contains(q) ||
                            a.summary.toLowerCase().contains(q) ||
                            a.tags.any((tag) => tag.toLowerCase().contains(q)),
                      )
                      .toList();
                }

                if (filtered.isEmpty) {
                  return ArticleListEmptyWidget(message: 'No articles found');
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final article = filtered[index];
                    return ArticleCard(article: article);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
