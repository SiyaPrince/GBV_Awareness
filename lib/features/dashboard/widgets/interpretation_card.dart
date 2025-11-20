import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/models/stat_metric.dart';

class InterpretationCard extends StatelessWidget {
  final StatMetric? metric;

  const InterpretationCard({
    super.key,
    this.metric,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final genericPoints = <String>[
      'These numbers do not represent all GBV incidents. Many cases go unreported.',
      'An increase in reports may show greater awareness and willingness to seek help, not only more violence.',
      'A decrease may reflect barriers to reporting or access to services, not just reduced violence.',
      'Comparing regions does not mean one area is “safe”. Lower numbers may reflect under-reporting.',
    ];

    final hint = metric?.interpretationHint;
    final warning = metric?.warningText;

    return Card(
      elevation: 0,
      // ignore: deprecated_member_use
      color: theme.colorScheme.surfaceContainerHighest.withOpacity(0.4),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.info_outline),
                const SizedBox(width: 8),
                Text(
                  'How to read this data',
                  style: theme.textTheme.titleMedium,
                ),
              ],
            ),
            const SizedBox(height: 12),
            if (hint != null) ...[
              Text(
                hint,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
            ],
            ...genericPoints.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 4),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(
                      child: Text(
                        p,
                        style: theme.textTheme.bodySmall,
                      ),
                    ),
                  ],
                ),
              ),
            ),
            if (warning != null) ...[
              const SizedBox(height: 12),
              Text(
                warning,
                style: theme.textTheme.bodySmall?.copyWith(
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
