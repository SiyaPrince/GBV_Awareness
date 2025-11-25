import 'package:flutter/material.dart';

class BlogDetailImagePlaceholder extends StatelessWidget {
  const BlogDetailImagePlaceholder({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: colors.surface,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(Icons.photo_library, size: 64, color: colors.primary),
    );
  }
}
