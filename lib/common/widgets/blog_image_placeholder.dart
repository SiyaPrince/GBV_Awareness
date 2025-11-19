// import 'package:flutter/material.dart';

// class BlogImagePlaceholder extends StatelessWidget {
//   final String imageUrl;
//   const BlogImagePlaceholder({super.key, required this.imageUrl});

//   @override
//   Widget build(BuildContext context) {
//     final colors = Theme.of(context).colorScheme;

//     return Container(
//       width: double.infinity,
//       height: 200,
//       decoration: BoxDecoration(
//         color: colors.surface,
//         borderRadius: BorderRadius.circular(12),
//       ),
//       child: imageUrl.isNotEmpty
//           ? Image.network(imageUrl, fit: BoxFit.cover)
//           : Icon(Icons.photo_library, size: 64, color: colors.primary),
//     );
//   }
// }
