// import 'package:flutter/material.dart';

// class ArticleDetailErrorWidget extends StatelessWidget {
//   const ArticleDetailErrorWidget({
//     super.key,
//     required String message,
//     required void Function() onRetry,
//   });

//   @override
//   Widget build(BuildContext context) {
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
//           Text(
//             'Article not found',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           const SizedBox(height: 8),
//           TextButton(
//             onPressed: () => Navigator.pop(context),
//             child: const Text('Go Back'),
//           ),
//         ],
//       ),
//     );
//   }
// }
