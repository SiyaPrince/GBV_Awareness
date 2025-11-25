import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeHeroSection extends StatelessWidget {
  const HomeHeroSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(
        color: color.primaryContainer,
        borderRadius: BorderRadius.circular(20),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;

          return isWide
              ? Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    // Text side
                    Expanded(child: _buildTextContent(context)),
                    const SizedBox(width: 32),
                    // Placeholder “illustration”
                    _buildVisualPlaceholder(context),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildTextContent(context),
                    const SizedBox(height: 24),
                    _buildVisualPlaceholder(context),
                  ],
                );
        },
      ),
    );
  }

  Widget _buildTextContent(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Support, information, and tools for navigating GBV.",
          style: Theme.of(context).textTheme.headlineMedium?.copyWith(
            color: color.onPrimaryContainer,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),
        Text(
          "This space is designed to help survivors, loved ones, and organisations "
          "understand gender-based violence, access trusted resources, and take the next step safely—at their own pace.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(
            color: color.onPrimaryContainer.withValues(alpha: 0.85),
            height: 1.5,
          ),
        ),
        const SizedBox(height: 24),
        Wrap(
          spacing: 12,
          runSpacing: 8,
          children: [
            FilledButton(
              onPressed: () => context.go('/info'),
              child: const Text("Learn about GBV"),
            ),
            FilledButton.tonal(
              onPressed: () => context.go('/support'),
              child: const Text("Get help now"),
            ),
            OutlinedButton(
              onPressed: () => context.go('/product'),
              child: const Text("Explore our product"),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildVisualPlaceholder(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: 260,
      height: 180,
      decoration: BoxDecoration(
        color: color.onPrimaryContainer.withValues(alpha: 0.05),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(
          color: color.onPrimaryContainer.withValues(alpha: 0.12),
        ),
      ),
      child: Center(
        child: Text(
          "Calm illustration\nplaceholder",
          textAlign: TextAlign.center,
          style: Theme.of(context).textTheme.bodySmall?.copyWith(
            color: color.onPrimaryContainer.withValues(alpha: 0.7),
          ),
        ),
      ),
    );
  }
}
