import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/stats_service.dart';
import 'package:gbv_awareness/features/dashboard/widgets/metric_chart_shared.dart';

class MetricLineChart extends StatelessWidget {
  final List<MetricWithLatest> metrics;

  const MetricLineChart({
    super.key,
    required this.metrics,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final spots = <FlSpot>[];
    final values = <double>[];

    for (var i = 0; i < metrics.length; i++) {
      final v = metrics[i].latestPoint!.value.toDouble();
      spots.add(FlSpot(i.toDouble(), v));
      values.add(v);
    }

    final minY = values.reduce((a, b) => a < b ? a : b);
    final maxY = values.reduce((a, b) => a > b ? a : b);

    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Line-based metrics', style: theme.textTheme.titleMedium),
            const SizedBox(height: 4),
            Text(
              'Trend-style metrics plotted together. Each colour represents a metric.',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 260,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: LineChart(
                      LineChartData(
                        minY: (minY - 1).clamp(0, double.infinity),
                        maxY: maxY + 1,
                        lineBarsData: [
                          LineChartBarData(
                            spots: spots,
                            isCurved: true,
                            barWidth: 2,
                            // ignore: deprecated_member_use
                            color: theme.colorScheme.primary.withOpacity(0.4),
                            dotData: FlDotData(
                              show: true,
                              getDotPainter:
                                  (spot, percent, barData, index) =>
                                      FlDotCirclePainter(
                                radius: 3,
                                color: metricColor(index, theme),
                                strokeWidth: 1,
                                strokeColor: theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
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
