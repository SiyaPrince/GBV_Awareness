// lib/features/information_hub/presentation/widgets/information_hub_search_filter.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gbv_awareness/features/info/information_hub_page.dart';
import '../../../../common/services/content_service.dart';

class InformationHubSearchFilter extends ConsumerWidget {
  final ScrollController controller;
  final VoidCallback onLeft;
  final VoidCallback onRight;

  const InformationHubSearchFilter({
    super.key,
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
          // ❗ FIXED — removed ValueKey(search)
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
                          onSelected: (_) {
                            ref.read(selectedCategoryProvider.notifier).state =
                                null;
                          },
                        ),
                        ...categories.map((tag) {
                          return Padding(
                            padding: const EdgeInsets.only(left: 8),
                            child: FilterChip(
                              label: Text(tag),
                              selected: selectedCategory == tag,
                              onSelected: (_) {
                                ref
                                        .read(selectedCategoryProvider.notifier)
                                        .state =
                                    tag;
                              },
                            ),
                          );
                        }),
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
