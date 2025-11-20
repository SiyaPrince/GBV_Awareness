import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/models/metric_point.dart';
import 'package:gbv_awareness/common/services/stats/models/stat_metric.dart';
import '../utils/chart_converters.dart';

class MetricLineChart extends StatelessWidget {
  final StatMetric metric;
  final List<MetricPoint> points;

  const MetricLineChart({
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
    final spots = metricPointsToLineSpots(points);

    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(metric.title, style: theme.textTheme.titleMedium),
            if (metric.description != null) ...[
              const SizedBox(height: 4),
              Text(metric.description!, style: theme.textTheme.bodySmall),
            ],
            const SizedBox(height: 16),
            SizedBox(
              height: 220,
              child: LineChart(
                LineChartData(
                  lineTouchData: LineTouchData(
                    handleBuiltInTouches: true,
                    touchTooltipData: LineTouchTooltipData(
                      getTooltipItems: (touchedSpots) {
                        return touchedSpots.map((spot) {
                          final date = points[spot.spotIndex].timestamp;
                          final value = points[spot.spotIndex].value;
                          return LineTooltipItem(
                            '${date.day}/${date.month}\n$value',
                            const TextStyle(fontWeight: FontWeight.bold),
                          );
                        }).toList();
                      },
                    ),
                  ),
                  gridData: FlGridData(show: true),
                  titlesData: FlTitlesData(
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 40,
                      ),
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
                          final date = points[index].timestamp;
                          return Text(
                            '${date.day}/${date.month}',
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
                  borderData: FlBorderData(show: true),
                  lineBarsData: [
                    LineChartBarData(
                      spots: spots,
                      isCurved: true,
                      dotData: const FlDotData(show: false),
                    ),
                  ],
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
          'No data available yet for this metric.',
          style: theme.textTheme.bodyMedium,
        ),
      ),
    );
  }
}
