import 'package:gbv_awareness/common/services/stats/models/metric_point.dart';
import 'package:gbv_awareness/common/services/stats/models/stat_metric.dart';
import 'package:gbv_awareness/common/services/stats/stats_service.dart';

class DashboardController {
  final StatsService statsService;

  DashboardController({required this.statsService});

  Stream<List<StatMetric>> get metricsStream => statsService.streamAllMetrics();

  Stream<List<MetricWithLatest>> get dashboardMetricsStream =>
      statsService.streamDashboardMetrics();

  Stream<List<MetricPoint>> metricPointsStream(String metricId) =>
      statsService.streamMetricPoints(metricId);
}
