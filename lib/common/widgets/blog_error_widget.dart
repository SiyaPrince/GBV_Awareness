// import 'package:flutter/material.dart';

// class BlogErrorWidget extends StatelessWidget {
//   final VoidCallback onRetry;
//   const BlogErrorWidget({super.key, required this.onRetry});

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
//             'Blog post not found',
//             style: Theme.of(context).textTheme.titleMedium,
//           ),
//           const SizedBox(height: 8),
//           TextButton(onPressed: onRetry, child: const Text('Go Back')),
//         ],
//       ),
//     );
//   }
// }
