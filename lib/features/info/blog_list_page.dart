import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:gbv_awareness/common/widgets/blog_card.dart';
import 'package:gbv_awareness/common/widgets/blog_empty_widget.dart';
import 'package:gbv_awareness/common/widgets/blog_list_error_widget.dart';
import 'package:gbv_awareness/common/widgets/blog_search_filter_section.dart';
import '../../../common/services/content_service.dart';
import '../../../common/models/article.dart';

/// Local filter state for this page
final blogSearchQueryProvider = StateProvider.autoDispose<String>((ref) => '');
final blogSelectedTagProvider = StateProvider.autoDispose<String?>(
  (ref) => null,
);

class BlogListPage extends ConsumerStatefulWidget {
  const BlogListPage({super.key});

  @override
  ConsumerState<BlogListPage> createState() => _BlogListPageState();
}

class _BlogListPageState extends ConsumerState<BlogListPage> {
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
    final blogsAsync = ref.watch(blogPostsStreamProvider);
    final searchQuery = ref.watch(blogSearchQueryProvider);
    final selectedTag = ref.watch(blogSelectedTagProvider);

    if (_searchController.text != searchQuery) {
      _searchController.value = _searchController.value.copyWith(
        text: searchQuery,
      );
    }

    return SingleChildScrollView(
      child: Column(
        children: [
          // Custom App Bar replacement
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
                    'Blogs & Stories',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Theme.of(context).colorScheme.onPrimary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ),

          BlogSearchFilterSection(
            searchController: _searchController,
            searchQuery: searchQuery,
            selectedTag: selectedTag,
          ),

          // Blog list content
          blogsAsync.when(
            loading: () => const Padding(
              padding: EdgeInsets.all(32.0),
              child: Center(child: CircularProgressIndicator()),
            ),
            error: (error, stack) => BlogListErrorWidget(
              message: 'Error loading blogs',
              onRetry: () => setState(() {}),
            ),
            data: (blogs) {
              // Local filtering
              List<Article> filtered = blogs;

              if (selectedTag != null) {
                filtered = filtered
                    .where((b) => b.tags.contains(selectedTag))
                    .toList();
              }

              if (searchQuery.isNotEmpty) {
                final q = searchQuery.toLowerCase();
                filtered = filtered
                    .where(
                      (b) =>
                          b.title.toLowerCase().contains(q) ||
                          b.summary.toLowerCase().contains(q) ||
                          b.tags.any((tag) => tag.toLowerCase().contains(q)),
                    )
                    .toList();
              }

              if (filtered.isEmpty) {
                return const BlogEmptyWidget(message: 'No blogs found');
              }

              return Column(
                children: [
                  ...filtered.map((blog) => BlogCard(blog: blog)).toList(),
                  const SizedBox(height: 16), // Bottom padding
                ],
              );
            },
          ),
        ],
      ),
    );
  }
}
