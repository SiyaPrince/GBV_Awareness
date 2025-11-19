// import 'package:flutter/material.dart';

// class ArticleListErrorWidget extends StatelessWidget {
//   final VoidCallback onRetry;
//   final String message;

//   const ArticleListErrorWidget({
//     super.key,
//     required this.onRetry,
//     required this.message,
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
//           Text(message, style: Theme.of(context).textTheme.titleMedium),
//           const SizedBox(height: 8),
//           TextButton(onPressed: onRetry, child: const Text('Try Again')),
//         ],
//       ),
//     );
//   }
// }
