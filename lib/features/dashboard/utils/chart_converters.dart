import 'package:fl_chart/fl_chart.dart';
import 'package:gbv_awareness/common/services/stats/models/metric_point.dart';

/// Convert MetricPoint list to FlSpot list.
/// For now, uses index as x-value and keeps DateTime for tooltip labels.
List<FlSpot> metricPointsToLineSpots(List<MetricPoint> points) {
  return List<FlSpot>.generate(points.length, (index) {
    final p = points[index];
    return FlSpot(index.toDouble(), p.value);
  });
}

/// Simple bar groups using index as x.
List<BarChartGroupData> metricPointsToBarGroups(List<MetricPoint> points) {
  return List<BarChartGroupData>.generate(points.length, (index) {
    final p = points[index];
    return BarChartGroupData(
      x: index,
      barRods: [
        BarChartRodData(toY: p.value),
      ],
    );
  });
}
