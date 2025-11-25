import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/stats_service.dart';

/// Color palette reused for both charts.
Color metricColor(int index, ThemeData theme) {
  final palette = <Color>[
    theme.colorScheme.primary,
    theme.colorScheme.secondary,
    const Color(0xFFEC4899),
    const Color(0xFF22C55E),
    const Color(0xFF6366F1),
    const Color(0xFFF97316),
    const Color(0xFF06B6D4),
    const Color(0xFF14B8A6),
  ];
  return palette[index % palette.length];
}

/// Legend widget (right side: coloured dots + labels)
class MetricsLegend extends StatelessWidget {
  final List<MetricWithLatest> metrics;

  const MetricsLegend({super.key, required this.metrics});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // FIX: Add dedicated scroll controller
    final controller = ScrollController();

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 180, maxHeight: 260),
      child: Scrollbar(
        controller: controller,
        thumbVisibility: true,
        child: ListView.builder(
          controller: controller,   // Attach here too
          padding: EdgeInsets.zero,
          itemCount: metrics.length,
          itemBuilder: (context, index) {
            final m = metrics[index].metric;
            final label = (m.shortLabel ?? m.title).trim();
            final display =
                label.length > 28 ? '${label.substring(0, 28)}…' : label;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: metricColor(index, theme),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      display,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
