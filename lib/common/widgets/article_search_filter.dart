// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import '../../../common/services/content_service.dart';

// class ArticleSearchFilter extends ConsumerWidget {
//   final TextEditingController searchController;
//   final String searchQuery;
//   final String? selectedTag;
//   final Function(String?) onTagSelected;
//   final Function(String) onSearchChanged;
//   final Function() onClearSearch;

//   const ArticleSearchFilter({
//     super.key,
//     required this.searchController,
//     required this.searchQuery,
//     required this.selectedTag,
//     required this.onTagSelected,
//     required this.onSearchChanged,
//     required this.onClearSearch,
//   });

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     return Padding(
//       padding: const EdgeInsets.all(16.0),
//       child: Column(
//         children: [
//           TextField(
//             controller: searchController,
//             decoration: InputDecoration(
//               hintText: 'Search articles...',
//               prefixIcon: Icon(
//                 Icons.search,
//                 color: Theme.of(context).colorScheme.primary,
//               ),
//               suffixIcon: searchQuery.isNotEmpty
//                   ? IconButton(
//                       icon: Icon(
//                         Icons.clear,
//                         color: Theme.of(context).colorScheme.primary,
//                       ),
//                       onPressed: onClearSearch,
//                     )
//                   : null,
//               border: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(25.0),
//               ),
//             ),
//             onChanged: onSearchChanged,
//           ),
//           const SizedBox(height: 16),
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
//                       selected: selectedTag == null,
//                       onSelected: (_) => onTagSelected(null),
//                     ),
//                     ...tags.map(
//                       (tag) => Padding(
//                         padding: const EdgeInsets.only(left: 8.0),
//                         child: FilterChip(
//                           label: Text(tag),
//                           selected: selectedTag == tag,
//                           onSelected: (_) => onTagSelected(tag),
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
// }
