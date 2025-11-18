import 'package:flutter/material.dart';

/// AppPage
/// A shared layout wrapper used by most pages inside the app.
/// Includes:
/// - background color from theme
/// - max content width
/// - consistent padding
/// - optional title + subtitle
class AppPage extends StatelessWidget {
  final String? title;
  final String? subtitle;
  final List<Widget> children;
  final Widget? floatingActionButton;

  const AppPage({
    super.key,
    this.title,
    this.subtitle,
    required this.children,
    this.floatingActionButton,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      backgroundColor: theme.scaffoldBackgroundColor,
      floatingActionButton: floatingActionButton,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 1100),
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 32),
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
          ),
        ),
      ),
    );
  }
}
