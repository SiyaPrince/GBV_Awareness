import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/stats_service.dart';
import 'package:gbv_awareness/features/dashboard/controllers/dashboard_controller.dart';
import 'package:gbv_awareness/common/services/stats/models/stat_metric.dart';

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

        // Sort by priority
        withValue.sort((a, b) {
          final pa = a.metric.priority;
          final pb = b.metric.priority;
          return pa.compareTo(pb);
        });

        // Enum-based filtering
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

        // ALWAYS vertical layout
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _AllLineMetricsChart(metrics: lineMetrics),
            const SizedBox(height: 16),
            _AllBarMetricsChart(metrics: barMetrics),
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

/// Color palette reused for both charts.
Color _metricColor(int index, ThemeData theme) {
  final palette = <Color>[
    theme.colorScheme.primary,
    theme.colorScheme.secondary,
    const Color(0xFFEC4899),
    const Color(0xFF22C55E),
    const Color(0xFF6366F1),
    const Color(0xFFF97316),
    const Color(0xFF06B6D4),
    const Color(0xFF14B8A6),
  ];
  return palette[index % palette.length];
}

/// Shared legend widget (right side: coloured dots + labels)
class _MetricsLegend extends StatelessWidget {
  final List<MetricWithLatest> metrics;

  const _MetricsLegend({required this.metrics});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 180, maxHeight: 260),
      child: Scrollbar(
        thumbVisibility: true,
        child: ListView.builder(
          padding: EdgeInsets.zero,
          itemCount: metrics.length,
          itemBuilder: (context, index) {
            final m = metrics[index].metric;
            final label = (m.shortLabel ?? m.title).trim();
            final display =
                label.length > 28 ? '${label.substring(0, 28)}…' : label;

            return Padding(
              padding: const EdgeInsets.symmetric(vertical: 2),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    margin: const EdgeInsets.only(right: 8),
                    decoration: BoxDecoration(
                      color: _metricColor(index, theme),
                      shape: BoxShape.circle,
                    ),
                  ),
                  Expanded(
                    child: Text(
                      display,
                      style: theme.textTheme.bodySmall,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}

/// LINE CHART
class _AllLineMetricsChart extends StatelessWidget {
  final List<MetricWithLatest> metrics;

  const _AllLineMetricsChart({required this.metrics});

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
                            color:
                                theme.colorScheme.primary.withOpacity(0.4),
                            dotData: FlDotData(
                              show: true,
                              getDotPainter:
                                  (spot, percent, barData, index) =>
                                      FlDotCirclePainter(
                                radius: 3,
                                color: _metricColor(index, theme),
                                strokeWidth: 1,
                                strokeColor:
                                    theme.colorScheme.onSurface,
                              ),
                            ),
                          ),
                        ],
                        gridData: FlGridData(show: true),
                        borderData: FlBorderData(show: true),
                        titlesData: FlTitlesData(
                          // 🔴 no bottom titles – x-axis is just numeric positions
                          bottomTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _MetricsLegend(metrics: metrics),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// BAR CHART
class _AllBarMetricsChart extends StatelessWidget {
  final List<MetricWithLatest> metrics;

  const _AllBarMetricsChart({required this.metrics});

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
              color: _metricColor(i, theme),
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
                        titlesData: FlTitlesData(
                          // 🔴 no x-axis text
                          bottomTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          leftTitles: AxisTitles(
                            sideTitles: SideTitles(
                              showTitles: true,
                              reservedSize: 40,
                            ),
                          ),
                          topTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                          rightTitles: const AxisTitles(
                            sideTitles: SideTitles(showTitles: false),
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  _MetricsLegend(metrics: metrics),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
