import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/stats_service.dart';
import 'package:gbv_awareness/features/dashboard/controllers/dashboard_controller.dart';
import 'package:gbv_awareness/features/dashboard/widgets/metric_card.dart';

class DashboardKpiRow extends StatelessWidget {
  final DashboardController controller;

  const DashboardKpiRow({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      height: 130,
      child: StreamBuilder<List<MetricWithLatest>>(
        stream: controller.dashboardMetricsStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const _KpiSkeletonRow();
          }

          final items = snapshot.data ?? const [];

          if (items.isEmpty) {
            return Center(
              child: Text(
                'No dashboard metrics configured yet.',
                style: theme.textTheme.bodyMedium,
              ),
            );
          }

          return ListView.separated(
            scrollDirection: Axis.horizontal,
            itemCount: items.length,
            separatorBuilder: (_, _) => const SizedBox(width: 12),
            itemBuilder: (context, index) {
              final m = items[index];
              return SizedBox(
                width: 260,
                child: MetricCard(
                  metric: m.metric,
                  latestPoint: m.latestPoint,
                ),
              );
            },
          );
        },
      ),
    );
  }
}

class _KpiSkeletonRow extends StatelessWidget {
  const _KpiSkeletonRow();

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      scrollDirection: Axis.horizontal,
      itemCount: 3,
      separatorBuilder: (_, _) => const SizedBox(width: 12),
      itemBuilder: (_, _) {
        return const _KpiSkeletonCard();
      },
    );
  }
}

class _KpiSkeletonCard extends StatelessWidget {
  const _KpiSkeletonCard();

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 260,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Container(
          padding: const EdgeInsets.all(16),
          alignment: Alignment.centerLeft,
          child: const Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _SkeletonBox(width: 120, height: 16),
              SizedBox(height: 12),
              _SkeletonBox(width: 80, height: 28),
            ],
          ),
        ),
      ),
    );
  }
}

class _SkeletonBox extends StatelessWidget {
  final double width;
  final double height;

  const _SkeletonBox({
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: Colors.grey.shade300,
        borderRadius: BorderRadius.circular(8),
      ),
    );
  }
}
