import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gbv_awareness/common/widgets/article_card.dart';
import 'package:gbv_awareness/common/widgets/article_list_empty_widget.dart';
import 'package:gbv_awareness/common/widgets/article_list_error_widget.dart';
import 'package:gbv_awareness/common/widgets/information_hub_header.dart';
import 'package:gbv_awareness/common/widgets/information_hub_search_filter.dart';
import '../../../../common/services/content_service.dart';
import '../../../../common/models/article.dart';

/// LOCAL STATE PROVIDERS
final searchQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final selectedCategoryProvider = StateProvider.autoDispose<String?>(
  (ref) => null,
);

class InformationHubPage extends ConsumerStatefulWidget {
  const InformationHubPage({super.key});

  @override
  ConsumerState<InformationHubPage> createState() => _InformationHubPageState();
}

class _InformationHubPageState extends ConsumerState<InformationHubPage> {
  final ScrollController _categoryScroll = ScrollController();

  void scrollLeft() {
    _categoryScroll.animateTo(
      _categoryScroll.offset - 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  void scrollRight() {
    _categoryScroll.animateTo(
      _categoryScroll.offset + 200,
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeOut,
    );
  }

  @override
  void dispose() {
    _categoryScroll.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final search = ref.watch(searchQueryProvider);
    final category = ref.watch(selectedCategoryProvider);
    final articlesAsync = ref.watch(articlesStreamProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InformationHubHeader(),
          const SizedBox(height: 24),

          InformationHubSearchFilter(
            controller: _categoryScroll,
            onLeft: scrollLeft,
            onRight: scrollRight,
          ),

          const SizedBox(height: 16),

          articlesAsync.when(
            loading: () => const Center(child: CircularProgressIndicator()),
            error: (error, stack) {
              debugPrint("🔥 ARTICLES ERROR: $error");
              debugPrint(stack.toString());
              return ArticleListErrorWidget(
                message: 'Failed to load information',
                onRetry: () => setState(() {}),
              );
            },
            data: (articles) {
              List<Article> filtered = articles;

              if (category != null) {
                filtered = filtered
                    .where((a) => a.tags.contains(category))
                    .toList();
              }

              if (search.isNotEmpty) {
                final query = search.toLowerCase();
                filtered = filtered
                    .where(
                      (a) =>
                          a.title.toLowerCase().contains(query) ||
                          a.summary.toLowerCase().contains(query) ||
                          a.tags.any(
                            (tag) => tag.toLowerCase().contains(query),
                          ),
                    )
                    .toList();
              }

              if (filtered.isEmpty) {
                return ArticleListEmptyWidget(message: 'No content found');
              }

              return Column(
                children: [
                  for (final article in filtered)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ArticleCard(article: article),
                    ),
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
