import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeSupportCTASection extends StatelessWidget {
  const HomeSupportCTASection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: const Color(0xFFC2185B).withValues(alpha: 0.9), // Deep Rose tone
        borderRadius: BorderRadius.circular(16),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;

          final text = Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "If you or someone you know needs support right now",
                style: Theme.of(context).textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "You deserve safety, respect, and support. If you are in danger or feel unsafe, "
                "please use the resources below. You don’t have to face this alone.",
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                  height: 1.5,
                ),
              ),
            ],
          );

          final buttons = Wrap(
            spacing: 12,
            runSpacing: 8,
            children: [
              FilledButton(
                onPressed: () => context.go('/support'),
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.white,
                  foregroundColor: const Color(0xFFC2185B),
                ),
                child: const Text("View support resources"),
              ),
              OutlinedButton(
                onPressed: () => context.go('/contact'),
                style: OutlinedButton.styleFrom(
                  side: const BorderSide(color: Colors.white),
                  foregroundColor: Colors.white,
                ),
                child: const Text("Contact us"),
              ),
            ],
          );

          if (isWide) {
            return Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(child: text),
                const SizedBox(width: 24),
                buttons,
              ],
            );
          } else {
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [text, const SizedBox(height: 16), buttons],
            );
          }
        },
      ),
    );
  }
}
