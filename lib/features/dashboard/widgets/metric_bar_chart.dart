import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/models/metric_point.dart';
import 'package:gbv_awareness/common/services/stats/models/stat_metric.dart';
import '../utils/chart_converters.dart';

class MetricBarChart extends StatelessWidget {
  final StatMetric metric;
  final List<MetricPoint> points;

  const MetricBarChart({
    super.key,
    required this.metric,
    required this.points,
  });

  @override
  Widget build(BuildContext context) {
    if (points.isEmpty) {
      return _buildEmptyState(context);
    }

    final theme = Theme.of(context);
    final groups = metricPointsToBarGroups(points);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              metric.title,
              style: theme.textTheme.titleMedium,
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: BarChart(
                BarChartData(
                  barTouchData: BarTouchData(enabled: true),
                  gridData: FlGridData(show: true),
                  borderData: FlBorderData(show: false),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(showTitles: true, reservedSize: 40),
                    ),
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 22,
                        getTitlesWidget: (value, meta) {
                          final index = value.toInt();
                          if (index < 0 || index >= points.length) {
                            return const SizedBox.shrink();
                          }

                          final label = points[index].region ??
                              'P${index + 1}'; // generic fallback

                          return Text(
                            label,
                            style: Theme.of(context).textTheme.bodySmall,
                          );
                        },
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  barGroups: groups,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        height: 180,
        alignment: Alignment.center,
        padding: const EdgeInsets.all(16),
        child: Text(
          'No comparison data available yet for this metric.',
          style: theme.textTheme.bodyMedium,
        ),
      ),
    );
  }
}
