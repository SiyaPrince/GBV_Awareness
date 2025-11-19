// import 'package:flutter/material.dart';
// import '../../common/models/article.dart';

// class ArticleMetaInfo extends StatelessWidget {
//   final Article article;
//   const ArticleMetaInfo({super.key, required this.article});

//   @override
//   Widget build(BuildContext context) {
//     return Row(
//       children: [
//         Icon(Icons.calendar_today, size: 16, color: Colors.grey),
//         const SizedBox(width: 4),
//         Text(
//           '${article.publishedAt.day}/${article.publishedAt.month}/${article.publishedAt.year}',
//           style: Theme.of(context).textTheme.bodySmall,
//         ),
//         const Spacer(),
//         Icon(Icons.person, size: 16, color: Colors.grey),
//         const SizedBox(width: 4),
//         Text(
//           article.author ?? 'Anonymous',
//           style: Theme.of(context).textTheme.bodySmall,
//         ),
//       ],
//     );
//   }
// }
