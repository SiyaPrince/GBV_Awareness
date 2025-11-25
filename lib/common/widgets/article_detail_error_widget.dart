import 'package:flutter/material.dart';

class ArticleDetailErrorWidget extends StatelessWidget {
  final VoidCallback onBack;

  const ArticleDetailErrorWidget({super.key, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.error,
            size: 64,
            color: Theme.of(context).colorScheme.error,
          ),
          const SizedBox(height: 16),
          const Text("Article not found"),
          const SizedBox(height: 8),
          TextButton(onPressed: onBack, child: const Text("Go Back")),
        ],
      ),
    );
  }
}
