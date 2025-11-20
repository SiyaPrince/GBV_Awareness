import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/models/metric_point.dart';
import 'package:gbv_awareness/common/services/stats/models/stat_metric.dart';

class MetricCard extends StatelessWidget {
  final StatMetric metric;
  final MetricPoint? latestPoint;

  const MetricCard({
    super.key,
    required this.metric,
    required this.latestPoint,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final valueText = latestPoint != null
        ? latestPoint!.value.toStringAsFixed(0)
        : '--';

    final unitText = metric.unit != null ? ' ${metric.unit}' : '';

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              metric.shortLabel ?? metric.title,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 8),
            Row(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Text(
                  valueText,
                  style: theme.textTheme.headlineMedium?.copyWith(
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  unitText,
                  style: theme.textTheme.titleMedium?.copyWith(
                    color: theme.textTheme.bodySmall?.color,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            if (metric.sourceName != null)
              Text(
                'Source: ${metric.sourceName}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.hintColor,
                ),
              ),
          ],
        ),
      ),
    );
  }
}
