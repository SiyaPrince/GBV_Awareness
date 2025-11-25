import 'package:flutter/material.dart';

/// PageSection
/// A reusable container for page sections.
/// Provides consistent spacing, section title, optional subtitle,
/// and a child widget (grid, cards, text, etc.)
class PageSection extends StatelessWidget {
  final String title;
  final String? subtitle;
  final Widget child;

  const PageSection({
    super.key,
    required this.title,
    this.subtitle,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: theme.textTheme.titleLarge),
          if (subtitle != null) ...[
            const SizedBox(height: 8),
            Text(subtitle!, style: theme.textTheme.bodyMedium),
          ],
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
