// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:go_router/go_router.dart';
// import '../../../common/services/content_service.dart';
// import '../../../common/models/article.dart';

// class BlogListPage extends ConsumerStatefulWidget {
//   const BlogListPage({super.key});

//   @override
//   ConsumerState<BlogListPage> createState() => _BlogListPageState();
// }

// class _BlogListPageState extends ConsumerState<BlogListPage> {
//   final TextEditingController _searchController = TextEditingController();
//   String _searchQuery = '';
//   String? _selectedTag;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Blogs & Stories'),
//         backgroundColor: Theme.of(context).colorScheme.primary,
//         foregroundColor: Theme.of(context).colorScheme.onPrimary,
//       ),
//       body: Column(
//         children: [
//           _buildSearchFilterSection(context),
//           Expanded(
//             child: StreamBuilder<List<Article>>(
//               stream: _getBlogsStream(ref),
//               builder: (context, snapshot) {
//                 if (snapshot.connectionState == ConnectionState.waiting) {
//                   return const Center(child: CircularProgressIndicator());
//                 }

//                 if (snapshot.hasError) {
//                   return _buildErrorWidget(context, 'Error loading blogs');
//                 }

//                 final blogs = snapshot.data ?? [];

//                 if (blogs.isEmpty) {
//                   return _buildEmptyWidget(context, 'No blogs found');
//                 }

//                 return ListView.builder(
//                   itemCount: blogs.length,
//                   itemBuilder: (context, index) {
//                     final blog = blogs[index];
//                     return _buildBlogCard(context, blog);
//                   },
//                 );
//               },
//             ),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildSearchFilterSection(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           // Search Bar
//           TextField(
//             controller: _searchController,
//             decoration: InputDecoration(
//               hintText: 'Search blogs...',
//               prefixIcon: Icon(
//                 Icons.search,
//                 color: Theme.of(context).colorScheme.primary,
//               ),
//               suffixIcon: _searchQuery.isNotEmpty
//                   ? IconButton(
//                       icon: Icon(
//                         Icons.clear,
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                       onPressed: () {
//                         _searchController.clear();
//                         setState(() => _searchQuery = '');
//                       },
//                     )
//                   : null,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(25.0),
//               ),
//             ),
//             onChanged: (value) => setState(() => _searchQuery = value),
//           ),
//           const SizedBox(height: 16),

//           // Tags Filter
//           StreamBuilder<List<String>>(
//             stream: ref.read(contentServiceProvider).getAllTags(),
//             builder: (context, snapshot) {
//               if (!snapshot.hasData) return const SizedBox();

//               final tags = snapshot.data!;
//               return SingleChildScrollView(
//                 scrollDirection: Axis.horizontal,
//                 child: Row(
//                   children: [
//                     FilterChip(
//                       label: const Text('All'),
//                       selected: _selectedTag == null,
//                       onSelected: (_) => setState(() => _selectedTag = null),
//                     ),
//                     ...tags.map(
//                       (tag) => Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child: FilterChip(
//                           label: Text(tag),
//                           selected: _selectedTag == tag,
//                           onSelected: (_) => setState(() => _selectedTag = tag),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }

//   Stream<List<Article>> _getBlogsStream(WidgetRef ref) {
//     final contentService = ref.read(contentServiceProvider);

//     if (_searchQuery.isNotEmpty) {
//       return contentService
//           .searchContent(_searchQuery)
//           .map((articles) => articles.where((a) => a.type == 'blog').toList());
//     }

//     if (_selectedTag != null) {
//       return contentService
//           .getArticlesByTag(_selectedTag!)
//           .map((articles) => articles.where((a) => a.type == 'blog').toList());
//     }

//     return contentService.getBlogPosts();
//   }

//   Widget _buildBlogCard(BuildContext context, Article blog) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (blog.featured)
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.orange,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   'FEATURED',
//                   style: Theme.of(context).textTheme.labelSmall?.copyWith(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 12),
//             Text(
//               blog.title,
//               style: Theme.of(context).textTheme.titleLarge?.copyWith(
//                 color: Theme.of(context).colorScheme.primary,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               blog.summary,
//               style: Theme.of(context).textTheme.bodyMedium,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 12),
//             Wrap(
//               spacing: 8,
//               children: blog.tags
//                   .take(3)
//                   .map(
//                     (tag) => Chip(
//                       label: Text(tag, style: const TextStyle(fontSize: 12)),
//                       visualDensity: VisualDensity.compact,
//                     ),
//                   )
//                   .toList(),
//             ),
//             const SizedBox(height: 12),
//             Row(
//               children: [
//                 Icon(Icons.calendar_today, size: 16, color: Colors.grey),
//                 const SizedBox(width: 4),
//                 Text(
//                   '${blog.publishedAt.day}/${blog.publishedAt.month}/${blog.publishedAt.year}',
//                   style: Theme.of(context).textTheme.bodySmall,
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                   onPressed: () => context.go('/info/blog/${blog.id}'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: Theme.of(context).colorScheme.primary,
//                     foregroundColor: Theme.of(context).colorScheme.onPrimary,
//                   ),
//                   child: const Text('Read More'),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildErrorWidget(BuildContext context, String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(
//             Icons.error,
//             size: 64,
//             color: Theme.of(context).colorScheme.error,
//           ),
//           const SizedBox(height: 16),
//           Text(message, style: Theme.of(context).textTheme.titleMedium),
//           const SizedBox(height: 8),
//           TextButton(
//             onPressed: () => setState(() {}),
//             child: const Text('Try Again'),
//           ),
//         ],
//       ),
//     );
//   }

//   Widget _buildEmptyWidget(BuildContext context, String message) {
//     return Center(
//       child: Column(
//         mainAxisAlignment: MainAxisAlignment.center,
//         children: [
//           Icon(Icons.article, size: 64, color: Colors.grey),
//           const SizedBox(height: 16),
//           Text(message, style: Theme.of(context).textTheme.titleMedium),
//           const SizedBox(height: 8),
//           Text(
//             'Try adjusting your search or filters',
//             style: Theme.of(context).textTheme.bodyMedium,
//           ),
//         ],
//       ),
//     );
//   }

//   @override
//   void dispose() {
//     _searchController.dispose();
//     super.dispose();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:go_router/go_router.dart';

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

    return Scaffold(
      appBar: AppBar(
        title: const Text('Blogs & Stories'),
        backgroundColor: Theme.of(context).colorScheme.primary,
        foregroundColor: Theme.of(context).colorScheme.onPrimary,
      ),
      body: Column(
        children: [
          _buildSearchFilterSection(
            context,
            searchQuery: searchQuery,
            selectedTag: selectedTag,
          ),
          Expanded(
            child: blogsAsync.when(
              loading: () => const Center(child: CircularProgressIndicator()),
              error: (error, stack) =>
                  _buildErrorWidget(context, 'Error loading blogs'),
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
                  return _buildEmptyWidget(context, 'No blogs found');
                }

                return ListView.builder(
                  itemCount: filtered.length,
                  itemBuilder: (context, index) {
                    final blog = filtered[index];
                    return _buildBlogCard(context, blog);
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSearchFilterSection(
    BuildContext context, {
    required String searchQuery,
    required String? selectedTag,
  }) {
    final tagsAsync = ref.watch(tagsStreamProvider);

    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Search Bar
          TextField(
            controller: _searchController,
            decoration: InputDecoration(
              hintText: 'Search blogs...',
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
                        _searchController.clear();
                        ref.read(blogSearchQueryProvider.notifier).state = '';
                      },
                    )
                  : null,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25.0),
              ),
            ),
            onChanged: (value) =>
                ref.read(blogSearchQueryProvider.notifier).state = value,
          ),
          const SizedBox(height: 16),

          // Tags Filter
          tagsAsync.when(
            loading: () => const SizedBox(),
            error: (_, __) => const SizedBox(),
            data: (tags) {
              return SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  children: [
                    FilterChip(
                      label: const Text('All'),
                      selected: selectedTag == null,
                      onSelected: (_) =>
                          ref.read(blogSelectedTagProvider.notifier).state =
                              null,
                    ),
                    ...tags.map(
                      (tag) => Padding(
                        padding: const EdgeInsets.only(left: 8.0),
                        child: FilterChip(
                          label: Text(tag),
                          selected: selectedTag == tag,
                          onSelected: (_) =>
                              ref.read(blogSelectedTagProvider.notifier).state =
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

  Widget _buildBlogCard(BuildContext context, Article blog) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (blog.featured)
              Container(
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
              ),
            const SizedBox(height: 12),
            Text(
              blog.title,
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: Theme.of(context).colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              blog.summary,
              style: Theme.of(context).textTheme.bodyMedium,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              children: blog.tags
                  .take(3)
                  .map(
                    (tag) => Chip(
                      label: Text(tag, style: const TextStyle(fontSize: 12)),
                      visualDensity: VisualDensity.compact,
                    ),
                  )
                  .toList(),
            ),
            const SizedBox(height: 12),
            Row(
              children: [
                const Icon(Icons.calendar_today, size: 16, color: Colors.grey),
                const SizedBox(width: 4),
                Text(
                  '${blog.publishedAt.day}/${blog.publishedAt.month}/${blog.publishedAt.year}',
                  style: Theme.of(context).textTheme.bodySmall,
                ),
                const Spacer(),
                ElevatedButton(
                  onPressed: () => context.go('/info/blog/${blog.id}'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Theme.of(context).colorScheme.onPrimary,
                  ),
                  child: const Text('Read More'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
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
            onPressed: () {
              setState(() {}); // force rebuild
            },
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
          const Icon(Icons.article, size: 64, color: Colors.grey),
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
}
