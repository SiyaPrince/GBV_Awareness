// import 'package:flutter/material.dart';

// class BlogTagsSection extends StatelessWidget {
//   final List<String> tags;
//   const BlogTagsSection({super.key, required this.tags});

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
//           children: tags
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
