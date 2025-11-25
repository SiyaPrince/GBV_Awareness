import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/models/stat_metric.dart';
import 'package:gbv_awareness/content/metric_explanations.dart';

class InterpretationCard extends StatelessWidget {
  final StatMetric? metric;

  const InterpretationCard({super.key, this.metric});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    // Get metric-specific explanation if available
    final metricExplanation = metric != null
        ? MetricExplanations.explanations[metric!.id]
        : null;

    final genericPoints = <String>[
      'These numbers represent reported cases only. Many GBV incidents go unreported due to various barriers.',
      'Increased reporting can indicate growing awareness and trust in support systems, not necessarily more violence.',
      'Data collection methods vary by region and time period - focus on trends rather than absolute numbers.',
      'All data is aggregated and anonymized to protect privacy and safety.',
      'These statistics should inform prevention efforts and resource allocation, not create fear.',
    ];

    return Card(
      elevation: 0,
      color: theme.colorScheme.surfaceContainerHighest.withAlpha(
        102,
      ), // 40% opacity equivalent
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                const Icon(Icons.analytics_outlined),
                const SizedBox(width: 8),
                Text(
                  metricExplanation?['title'] ?? 'Understanding the Data',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),

            // Metric-specific description
            if (metricExplanation?['description'] != null) ...[
              Text(
                metricExplanation!['description']!,
                style: theme.textTheme.bodyMedium,
              ),
              const SizedBox(height: 12),
            ],

            // Interpretation guide
            if (metricExplanation?['interpretation'] != null) ...[
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.white.withAlpha(128), // 50% opacity equivalent
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'How to interpret this chart:',
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      metricExplanation!['interpretation']!,
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
            ],

            // Generic data context
            Text(
              'Important context about GBV data:',
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            ...genericPoints.map(
              (p) => Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('• '),
                    Expanded(child: Text(p, style: theme.textTheme.bodyMedium)),
                  ],
                ),
              ),
            ),

            // Limitations
            if (metricExplanation?['limitations'] != null) ...[
              const SizedBox(height: 12),
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.orange.withAlpha(25), // ~10% opacity equivalent
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.info_outline,
                          size: 16,
                          color: Colors.orange[700],
                        ),
                        const SizedBox(width: 4),
                        Text(
                          'Data Limitations:',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            fontWeight: FontWeight.bold,
                            color: Colors.orange[700],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      metricExplanation!['limitations']!,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        color: Colors.orange[700],
                      ),
                    ),
                  ],
                ),
              ),
            ],

            // Safety reminder
            const SizedBox(height: 12),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.blue.withAlpha(25), // ~10% opacity equivalent
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.health_and_safety,
                    size: 16,
                    color: Colors.blue[700],
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'Remember: If this data causes distress, support is available. Your wellbeing comes first.',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.blue[700],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
