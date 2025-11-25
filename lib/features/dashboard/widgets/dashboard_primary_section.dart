import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/stats_service.dart';
import 'package:gbv_awareness/common/services/stats/models/stat_metric.dart';
import 'package:gbv_awareness/features/dashboard/controllers/dashboard_controller.dart';
import 'package:gbv_awareness/features/dashboard/widgets/metric_line_chart.dart';
import 'package:gbv_awareness/features/dashboard/widgets/metric_bar_chart.dart';

class DashboardPrimarySection extends StatelessWidget {
  final DashboardController controller;

  const DashboardPrimarySection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<List<MetricWithLatest>>(
      stream: controller.dashboardMetricsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const _PrimarySkeleton();
        }

        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Unable to load dashboard visuals.',
              style: theme.textTheme.bodyMedium,
            ),
          );
        }

        final rawItems = snapshot.data ?? const [];

        // Only metrics that actually have a latest value
        final withValue = rawItems.where((m) => m.latestPoint != null).toList();

        if (withValue.isEmpty) {
          return Center(
            child: Text(
              'No data available yet for dashboard visuals.',
              style: theme.textTheme.bodyMedium,
            ),
          );
        }

        // Sort by priority (lowest number = highest priority)
        withValue.sort((a, b) {
          final pa = a.metric.priority;
          final pb = b.metric.priority;
          return pa.compareTo(pb);
        });

        // Enum-based filtering (ChartType from StatMetric)
        bool isLineMetric(MetricWithLatest m) =>
            m.metric.chartType == ChartType.line;
        bool isBarMetric(MetricWithLatest m) =>
            m.metric.chartType == ChartType.bar;

        List<MetricWithLatest> lineMetrics =
            withValue.where(isLineMetric).toList();
        List<MetricWithLatest> barMetrics =
            withValue.where(isBarMetric).toList();

        // Fallbacks if chartType not set
        if (lineMetrics.isEmpty && barMetrics.isEmpty) {
          lineMetrics = List.from(withValue);
          barMetrics = List.from(withValue);
        } else {
          if (lineMetrics.isEmpty) lineMetrics = List.from(withValue);
          if (barMetrics.isEmpty) barMetrics = List.from(withValue);
        }

        // Vertical layout: line chart then bar chart
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            MetricLineChart(metrics: lineMetrics),
            const SizedBox(height: 16),
            MetricBarChart(metrics: barMetrics),
          ],
        );
      },
    );
  }
}

class _PrimarySkeleton extends StatelessWidget {
  const _PrimarySkeleton();

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      height: 260,
      child: Center(child: CircularProgressIndicator()),
    );
  }
}
