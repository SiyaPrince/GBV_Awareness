import 'package:flutter/material.dart';

/// AppPage
/// --------
/// A simple page body used INSIDE AppShell.
/// AppShell handles scrolling / centering / maxWidth, so this:
/// - just lays out title + subtitle + children in a Column
class AppPage extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<Widget> children;

  const AppPage({super.key, this.title, this.subtitle, required this.children});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (title != null) ...[
          Text(title!, style: theme.textTheme.headlineMedium),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(subtitle!, style: theme.textTheme.bodyLarge),
          ],
          const SizedBox(height: 24),
        ],
        ...children,
      ],
    );
  }
}
