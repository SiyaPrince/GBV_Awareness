import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gbv_awareness/features/info/article_list_page.dart';
import '../../../../common/services/content_service.dart';

class ArticleSearchFilterSection extends ConsumerWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final String? selectedTag;

  const ArticleSearchFilterSection({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.selectedTag,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tagsAsync = ref.watch(tagsStreamProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Search articles...',
              prefixIcon: Icon(
                Icons.search,
                color: Theme.of(context).colorScheme.primary,
              ),
              suffixIcon: searchQuery.isNotEmpty
                  ? IconButton(
                      icon: Icon(
                        Icons.clear,
                        color: Theme.of(context).colorScheme.primary,
                      ),
                      onPressed: () {
                        searchController.clear();
                        ref.read(articleSearchQueryProvider.notifier).state =
                            '';
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            onChanged: (value) =>
                ref.read(articleSearchQueryProvider.notifier).state = value,
          ),
          const SizedBox(height: 16),

          // Tags Filter
          tagsAsync.when(
            loading: () => const SizedBox(),
            error: (_, _) => const SizedBox(),
            data: (tags) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: selectedTag == null,
                      onSelected: (_) =>
                          ref.read(articleSelectedTagProvider.notifier).state =
                              null,
                    ),
                    ...tags.map(
                      (tag) => Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: FilterChip(
                          label: Text(tag),
                          selected: selectedTag == tag,
                          onSelected: (_) =>
                              ref
                                      .read(articleSelectedTagProvider.notifier)
                                      .state =
                                  tag,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
