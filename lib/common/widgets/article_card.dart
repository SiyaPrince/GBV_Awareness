// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';
// import '../../../common/models/article.dart';

// class ArticleCard extends StatelessWidget {
//   final Article article;

//   const ArticleCard({super.key, required this.article});

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;
//     final textTheme = Theme.of(context).textTheme;

//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//       child: Padding(
//         padding: const EdgeInsets.all(16.0),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             if (article.featured)
//               Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
//                 decoration: BoxDecoration(
//                   color: Colors.orange,
//                   borderRadius: BorderRadius.circular(4),
//                 ),
//                 child: Text(
//                   'FEATURED',
//                   style: textTheme.labelSmall?.copyWith(
//                     color: Colors.white,
//                     fontWeight: FontWeight.bold,
//                   ),
//                 ),
//               ),
//             const SizedBox(height: 12),
//             Text(
//               article.title,
//               style: textTheme.titleLarge?.copyWith(
//                 color: colors.primary,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               article.summary,
//               style: textTheme.bodyMedium,
//               maxLines: 2,
//               overflow: TextOverflow.ellipsis,
//             ),
//             const SizedBox(height: 12),
//             Wrap(
//               spacing: 8,
//               children: article.tags
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
//                   '${article.publishedAt.day}/${article.publishedAt.month}/${article.publishedAt.year}',
//                   style: textTheme.bodySmall,
//                 ),
//                 const Spacer(),
//                 ElevatedButton(
//                   onPressed: () => context.go('/info/articles/${article.id}'),
//                   style: ElevatedButton.styleFrom(
//                     backgroundColor: colors.primary,
//                     foregroundColor: colors.onPrimary,
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
// }
// //
