import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeProductHighlightSection extends StatelessWidget {
  const HomeProductHighlightSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: color.secondaryContainer,
        borderRadius: BorderRadius.circular(16),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;

          final textContent = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "A supportive tool—not a replacement for people",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: color.onSecondaryContainer,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "[Product name] is designed to complement existing GBV services, not replace them. "
                "It focuses on clear information, safer documentation, and guided next steps.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: color.onSecondaryContainer.withValues(alpha: 0.9),
                  height: 1.5,
                ),
              ),
              const SizedBox(height: 16),
              FilledButton.tonal(
                onPressed: () => context.go('/product'),
                style: FilledButton.styleFrom(
                  foregroundColor: color.onSecondaryContainer,
                ),
                child: const Text("Learn about the product"),
              ),
            ],
          );

          final visual = Container(
            width: 220,
            height: 160,
            decoration: BoxDecoration(
              color: color.onSecondaryContainer.withValues(alpha: 0.05),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: color.onSecondaryContainer.withValues(alpha: 0.12),
              ),
            ),
            child: Center(
              child: Text(
                "Product preview\nplaceholder",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color.onSecondaryContainer.withValues(alpha: 0.7),
                ),
              ),
            ),
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: textContent),
                const SizedBox(width: 24),
                visual,
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [textContent, const SizedBox(height: 20), visual],
            );
          }
        },
      ),
    );
  }
}
