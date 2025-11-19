// import 'package:flutter/material.dart';
// import '../../common/models/article.dart';

// class ArticleTags extends StatelessWidget {
//   final Article article;
//   const ArticleTags({super.key, required this.article});

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           'Tags:',
//           style: Theme.of(
//             context,
//           ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
//         ),
//         const SizedBox(height: 8),
//         Wrap(
//           spacing: 8,
//           children: article.tags
//               .map(
//                 (tag) => Chip(
//                   label: Text(tag),
//                   backgroundColor: colors.secondaryContainer,
//                 ),
//               )
//               .toList(),
//         ),
//       ],
//     );
//   }
// }
// //
