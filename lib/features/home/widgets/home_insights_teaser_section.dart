import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeInsightsTeaserSection extends StatelessWidget {
  const HomeInsightsTeaserSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    const stats = [
      _InsightStat(
        label: "Sample reports logged\n(last 30 days)",
        value: "128",
      ),
      _InsightStat(label: "Support interactions\n(demo data)", value: "312"),
      _InsightStat(label: "Articles & resources\npublished", value: "24"),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "GBV insights at a glance",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: color.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "These are demo indicators only. Real data always needs careful interpretation "
          "and context—it never represents the full story.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: stats
                  .map(
                    (s) => SizedBox(
                      width: isWide
                          ? (constraints.maxWidth - 32) / 3
                          : constraints.maxWidth,
                      child: _InsightCard(stat: s),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.bar_chart_outlined),
          label: const Text("View full dashboard"),
        ),
      ],
    );
  }
}

class _InsightStat {
  final String label;
  final String value;

  const _InsightStat({required this.label, required this.value});
}

class _InsightCard extends StatelessWidget {
  final _InsightStat stat;

  const _InsightCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stat.value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: color.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              stat.label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}
