import 'models/stat_metric.dart';
import 'models/metric_point.dart';

class MetricWithLatest {
  final StatMetric metric;
  final MetricPoint? latestPoint;

  const MetricWithLatest({
    required this.metric,
    required this.latestPoint,
  });
}

abstract class StatsService {
  /// All metric definitions (for cards, selectors, etc.).
  Stream<List<StatMetric>> streamAllMetrics();

  /// Single metric definition by id.
  Stream<StatMetric?> streamMetric(String metricId);

  /// Time-series data for a single metric.
  Stream<List<MetricPoint>> streamMetricPoints(
    String metricId, {
    String? region,
    DateTime? from,
    DateTime? to,
  });

  /// Convenience: metric + its latest datapoint.
  ///
  /// Simple version: it's okay if this only updates when definitions change.
  Stream<List<MetricWithLatest>> streamDashboardMetrics();
}
