import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/stats_service.dart';
import 'package:gbv_awareness/features/dashboard/widgets/metric_chart_shared.dart';

class MetricBarChart extends StatelessWidget {
  final List<MetricWithLatest> metrics;

  const MetricBarChart({
    super.key,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final barGroups = <BarChartGroupData>[];
    final values = <double>[];

    for (var i = 0; i < metrics.length; i++) {
      final v = metrics[i].latestPoint!.value.toDouble();
      values.add(v);

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [
            BarChartRodData(
              toY: v,
              width: 14,
              borderRadius: BorderRadius.circular(4),
              color: metricColor(i, theme),
            ),
          ],
        ),
      );
    }

    final maxY = values.reduce((a, b) => a > b ? a : b);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Bar-based metrics', style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Comparison-style metrics plotted together. Colours match the line chart.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 260,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: BarChart(
                      BarChartData(
                        maxY: maxY + 1,
                        barGroups: barGroups,
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(show: true),
                        titlesData: const FlTitlesData(
                          bottomTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                            ),
                          ),
                          topTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  MetricsLegend(metrics: metrics),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
