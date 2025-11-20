// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:flutter_riverpod/legacy.dart';

// import 'package:gbv_awareness/common/widgets/article_card_widget.dart';
// import '../../../common/services/content_service.dart';
// import '../../../common/models/article.dart';

// /// ─────────────────────────────────────────────────────────
// /// STATE PROVIDERS (search + category)
// /// ─────────────────────────────────────────────────────────

// final searchQueryProvider = StateProvider<String>((ref) => '');
// final selectedCategoryProvider = StateProvider<String?>((ref) => null);

// /// ─────────────────────────────────────────────────────────
// /// TAGS STREAM PROVIDER (with keepAlive to stop blinking)
// /// ─────────────────────────────────────────────────────────

// final tagsProvider = StreamProvider<List<String>>((ref) {
//   final link = ref.keepAlive(); // ← FIXES FLICKER
//   final contentService = ref.watch(contentServiceProvider);

//   // OPTIONAL: automatically dispose after inactivity to save memory
//   ref.onCancel(() {});
//   ref.onDispose(() {});

//   return contentService.getAllTags();
// });

// /// ─────────────────────────────────────────────────────────
// /// ARTICLES STREAM PROVIDER (with keepAlive to stop blinking)
// /// ─────────────────────────────────────────────────────────

// final articlesStreamProvider = StreamProvider<List<Article>>((ref) {
//   final link = ref.keepAlive(); // ← FIXES FLICKER

//   final contentService = ref.watch(contentServiceProvider);
//   final search = ref.watch(searchQueryProvider);
//   final category = ref.watch(selectedCategoryProvider);

//   if (search.isNotEmpty) {
//     return contentService
//         .searchContent(search)
//         .map((articles) => articles.where((a) => a.type == 'article').toList());
//   }

//   if (category != null) {
//     return contentService
//         .getArticlesByTag(category)
//         .map((articles) => articles.where((a) => a.type == 'article').toList());
//   }

//   return contentService.getArticles();
// });

// /// ─────────────────────────────────────────────────────────
// /// PAGE WIDGET
// /// ─────────────────────────────────────────────────────────

// class InformationHubPage extends ConsumerWidget {
//   const InformationHubPage({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final colors = Theme.of(context).colorScheme;
//     final articlesAsync = ref.watch(articlesStreamProvider);

//     return SingleChildScrollView(
//       padding: const EdgeInsets.all(16),
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           Text(
//             'Information Hub',
//             style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//               color: colors.primary,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//           const SizedBox(height: 24),

//           _SearchAndFilter(),
//           const SizedBox(height: 16),

//           articlesAsync.when(
//             loading: () => const Center(child: CircularProgressIndicator()),

//             error: (error, stack) {
//               print("🔥 ARTICLES ERROR: $error");
//               print(stack);
//               return _ErrorMessage(message: 'Failed to load information');
//             },

//             data: (articles) {
//               if (articles.isEmpty) {
//                 return const _EmptyMessage(message: 'No content found');
//               }

//               return Column(
//                 children: [
//                   for (final article in articles)
//                     Padding(
//                       padding: const EdgeInsets.only(bottom: 16),
//                       child: ArticleCardWidget(article: article),
//                     ),
//                 ],
//               );
//             },
//           ),
//         ],
//       ),
//     );
//   }
// }

// /// ─────────────────────────────────────────────────────────
// /// SEARCH + FILTER SECTION (optimized)
// /// ─────────────────────────────────────────────────────────

// class _SearchAndFilter extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final search = ref.watch(searchQueryProvider);
//     final selectedCategory = ref.watch(selectedCategoryProvider);
//     final tagsAsync = ref.watch(tagsProvider);

//     return Column(
//       children: [
//         // SEARCH BAR
//         TextField(
//           decoration: InputDecoration(
//             hintText: 'Search for information...',
//             prefixIcon: Icon(
//               Icons.search,
//               color: Theme.of(context).colorScheme.primary,
//             ),
//             suffixIcon: search.isNotEmpty
//                 ? IconButton(
//                     icon: Icon(
//                       Icons.clear,
//                       color: Theme.of(context).colorScheme.primary,
//                     ),
//                     onPressed: () =>
//                         ref.read(searchQueryProvider.notifier).state = '',
//                   )
//                 : null,
//             border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
//           ),
//           onChanged: (value) =>
//               ref.read(searchQueryProvider.notifier).state = value,
//         ),

//         const SizedBox(height: 16),

//         // TAG FILTERS
//         tagsAsync.when(
//           loading: () => const SizedBox(),
//           error: (error, stack) {
//             print("🔥 TAGS ERROR: $error");
//             print(stack);
//             return const SizedBox();
//           },
//           data: (categories) {
//             return SingleChildScrollView(
//               scrollDirection: Axis.horizontal,
//               child: Row(
//                 children: [
//                   FilterChip(
//                     label: const Text('All'),
//                     selected: selectedCategory == null,
//                     onSelected: (_) =>
//                         ref.read(selectedCategoryProvider.notifier).state =
//                             null,
//                   ),
//                   ...categories.map(
//                     (tag) => Padding(
//                       padding: const EdgeInsets.only(left: 8),
//                       child: FilterChip(
//                         label: Text(tag),
//                         selected: selectedCategory == tag,
//                         onSelected: (_) =>
//                             ref.read(selectedCategoryProvider.notifier).state =
//                                 tag,
//                       ),
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ],
//     );
//   }
// }

// /// ─────────────────────────────────────────────────────────
// /// UI MESSAGE WIDGETS
// /// ─────────────────────────────────────────────────────────

// class _ErrorMessage extends StatelessWidget {
//   final String message;

//   const _ErrorMessage({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           Icon(Icons.error, size: 64, color: Colors.red),
//           const SizedBox(height: 16),
//           Text(message),
//         ],
//       ),
//     );
//   }
// }

// class _EmptyMessage extends StatelessWidget {
//   final String message;

//   const _EmptyMessage({required this.message});

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Column(
//         children: [
//           Icon(Icons.info_outline, size: 64, color: Colors.grey),
//           const SizedBox(height: 16),
//           Text(message),
//           const SizedBox(height: 4),
//           const Text("Try adjusting your search or filters"),
//         ],
//       ),
//     );
//   }
// }
// Full Information Hub Page Code
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';

import 'package:gbv_awareness/common/widgets/article_card_widget.dart';
import '../../../common/services/content_service.dart';
import '../../../common/models/article.dart';

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
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final search = ref.watch(searchQueryProvider);
    final category = ref.watch(selectedCategoryProvider);

    final articlesAsync = ref.watch(articlesStreamProvider);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Information Hub',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: colors.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),

          _SearchAndFilter(
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
              return const _ErrorMessage(message: 'Failed to load information');
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
                return const _EmptyMessage(message: 'No content found');
              }

              return Column(
                children: [
                  for (final article in filtered)
                    Padding(
                      padding: const EdgeInsets.only(bottom: 16),
                      child: ArticleCardWidget(article: article),
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

/// SEARCH + FILTER AREA
class _SearchAndFilter extends ConsumerWidget {
  final ScrollController controller;
  final VoidCallback onLeft;
  final VoidCallback onRight;

  const _SearchAndFilter({
    required this.controller,
    required this.onLeft,
    required this.onRight,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final search = ref.watch(searchQueryProvider);
    final selectedCategory = ref.watch(selectedCategoryProvider);
    final tagsAsync = ref.watch(tagsStreamProvider);

    return Column(
      children: [
        TextField(
          key: ValueKey(search),
          decoration: InputDecoration(
            hintText: 'Search for information...',
            prefixIcon: Icon(
              Icons.search,
              color: Theme.of(context).colorScheme.primary,
            ),
            suffixIcon: search.isNotEmpty
                ? IconButton(
                    icon: Icon(
                      Icons.clear,
                      color: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: () =>
                        ref.read(searchQueryProvider.notifier).state = '',
                  )
                : null,
            border: OutlineInputBorder(borderRadius: BorderRadius.circular(25)),
          ),
          onChanged: (value) =>
              ref.read(searchQueryProvider.notifier).state = value,
        ),

        const SizedBox(height: 16),

        tagsAsync.when(
          loading: () => const SizedBox(),
          error: (_, _) => const SizedBox(),
          data: (categories) {
            return Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.arrow_back_ios),
                  onPressed: onLeft,
                ),

                Expanded(
                  child: SingleChildScrollView(
                    controller: controller,
                    scrollDirection: Axis.horizontal,
                    child: Row(
                      children: [
                        FilterChip(
                          label: const Text('All'),
                          selected: selectedCategory == null,
                          onSelected: (_) =>
                              ref
                                      .read(selectedCategoryProvider.notifier)
                                      .state =
                                  null,
                        ),
                        ...categories.map(
                          (tag) => Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: FilterChip(
                              label: Text(tag),
                              selected: selectedCategory == tag,
                              onSelected: (_) =>
                                  ref
                                          .read(
                                            selectedCategoryProvider.notifier,
                                          )
                                          .state =
                                      tag,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                IconButton(
                  icon: const Icon(Icons.arrow_forward_ios),
                  onPressed: onRight,
                ),
              ],
            );
          },
        ),
      ],
    );
  }
}

/// ERROR MESSAGE
class _ErrorMessage extends StatelessWidget {
  final String message;

  const _ErrorMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.error, size: 64, color: Colors.red),
          const SizedBox(height: 16),
          Text(message),
        ],
      ),
    );
  }
}

/// EMPTY RESULT MESSAGE
class _EmptyMessage extends StatelessWidget {
  final String message;

  const _EmptyMessage({required this.message});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          const Icon(Icons.info_outline, size: 64, color: Colors.grey),
          const SizedBox(height: 16),
          Text(message),
          const SizedBox(height: 4),
          const Text("Try adjusting your search or filters"),
        ],
      ),
    );
  }
}
