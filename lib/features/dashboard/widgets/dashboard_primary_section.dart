import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/models/metric_point.dart';
import 'package:gbv_awareness/common/services/stats/models/stat_metric.dart';
import 'package:gbv_awareness/features/dashboard/controllers/dashboard_controller.dart';
import 'package:gbv_awareness/features/dashboard/widgets/interpretation_card.dart';
import 'package:gbv_awareness/features/dashboard/widgets/metric_line_chart.dart';
import 'package:gbv_awareness/features/dashboard/widgets/metric_bar_chart.dart';
import 'package:gbv_awareness/features/dashboard/widgets/support_help_card.dart';

class DashboardPrimarySection extends StatelessWidget {
  final DashboardController controller;

  const DashboardPrimarySection({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return StreamBuilder<List<StatMetric>>(
      stream: controller.metricsStream,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final metrics = snapshot.data ?? const [];
        if (metrics.isEmpty) {
          return Center(
            child: Text(
              'No metrics found. Ask an admin to configure metrics in Firestore.',
              style: theme.textTheme.bodyMedium,
            ),
          );
        }

        // Only show metrics that have a chart
        final chartableMetrics = metrics
            .where((m) => m.chartType != ChartType.none)
            .toList();

        if (chartableMetrics.isEmpty) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: const [
              Text('No chartable metrics configured.'),
              SizedBox(height: 16),
              SupportHelpCard(),
            ],
          );
        }

        return LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;

            final chartWidgets = chartableMetrics
                .map(
                  (metric) => _MetricChartCard(
                    controller: controller,
                    metric: metric,
                  ),
                )
                .toList();

            Widget charts;
            if (isWide) {
              charts = Wrap(
                spacing: 16,
                runSpacing: 16,
                children: chartWidgets
                    .map(
                      (child) => SizedBox(
                        width: (constraints.maxWidth - 16) / 2,
                        child: child,
                      ),
                    )
                    .toList(),
              );
            } else {
              charts = Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  for (final child in chartWidgets) ...[
                    child,
                    const SizedBox(height: 16),
                  ],
                ],
              );
            }

            return Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                charts,
                const SizedBox(height: 24),
                // Generic interpretation card (no specific metric passed)
                const InterpretationCard(),
                const SizedBox(height: 16),
                const SupportHelpCard(),
              ],
            );
          },
        );
      },
    );
  }
}

class _MetricChartCard extends StatelessWidget {
  final DashboardController controller;
  final StatMetric metric;

  const _MetricChartCard({
    required this.controller,
    required this.metric,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<MetricPoint>>(
      stream: controller.metricPointsStream(metric.id),
      builder: (context, snapshot) {
        final points = snapshot.data ?? const [];

        // Choose chart type based on metric.chartType
        switch (metric.chartType) {
          case ChartType.bar:
            return MetricBarChart(metric: metric, points: points);
          case ChartType.line:
          case ChartType.none:
          return MetricLineChart(metric: metric, points: points);
        }
      },
    );
  }
}
