import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/models/stat_metric.dart';
import 'package:gbv_awareness/common/services/stats/stats_service.dart';
import 'package:gbv_awareness/features/dashboard/controllers/dashboard_controller.dart';
import 'package:gbv_awareness/features/dashboard/widgets/metric_card.dart';

/// High-level category filters used to reduce clutter.
enum DashboardCategoryFilter {
  all,
  reportingHelp,
  supportCase,
  awareness,
  digital,
}

/// Sort modes for KPI metrics.
enum KpiSortMode {
  priority,
  valueDesc,
  name,
}

class DashboardKpiRow extends StatefulWidget {
  final DashboardController controller;

  const DashboardKpiRow({
    super.key,
    required this.controller,
  });

  @override
  State<DashboardKpiRow> createState() => _DashboardKpiRowState();
}

class _DashboardKpiRowState extends State<DashboardKpiRow> {
  DashboardCategoryFilter _selectedCategory = DashboardCategoryFilter.all;
  KpiSortMode _sortMode = KpiSortMode.priority;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // -------------------------------------------------------------------
        // FILTER + SORT BAR
        // -------------------------------------------------------------------
        _KpiFilterBar(
          selectedCategory: _selectedCategory,
          sortMode: _sortMode,
          onCategoryChanged: (value) {
            if (value == null) return;
            setState(() => _selectedCategory = value);
          },
          onSortModeChanged: (value) {
            if (value == null) return;
            setState(() => _sortMode = value);
          },
        ),
        const SizedBox(height: 12),

        // -------------------------------------------------------------------
        // KPI LIST
        // -------------------------------------------------------------------
        SizedBox(
          height: 160,
          child: StreamBuilder<List<MetricWithLatest>>(
            stream: widget.controller.dashboardMetricsStream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const _KpiSkeletonRow();
              }

              if (snapshot.hasError) {
                return Center(
                  child: Text(
                    'Unable to load dashboard metrics.',
                    style: theme.textTheme.bodyMedium,
                  ),
                );
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

              // 1) Filter by category
              final filtered = items
                  .where(
                    (m) => _matchesCategory(
                      m.metric,
                      _selectedCategory,
                    ),
                  )
                  .toList();

              if (filtered.isEmpty) {
                return Center(
                  child: Text(
                    'No metrics in this category yet.',
                    style: theme.textTheme.bodyMedium,
                  ),
                );
              }

              // 2) Sort according to selected mode
              filtered.sort((a, b) => _compareMetrics(a, b, _sortMode));

              // 3) Limit how many we show in the row so it stays clean
              final visible = filtered.take(4).toList();

              return ListView.separated(
                scrollDirection: Axis.horizontal,
                itemCount: visible.length,
                separatorBuilder: (_, _) => const SizedBox(width: 12),
                itemBuilder: (context, index) {
                  final item = visible[index];
                  return SizedBox(
                    width: 260,
                    child: MetricCard(
                      metric: item.metric,
                      latestPoint: item.latestPoint,
                    ),
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }

  bool _matchesCategory(
    StatMetric metric,
    DashboardCategoryFilter filter,
  ) {
    final category = (metric.category ?? '').toLowerCase();

    switch (filter) {
      case DashboardCategoryFilter.all:
        return true;
      case DashboardCategoryFilter.reportingHelp:
        return category == 'reporting_help';
      case DashboardCategoryFilter.supportCase:
        return category == 'support_case' ||
            category == 'support_case_management';
      case DashboardCategoryFilter.awareness:
        return category == 'awareness' || category == 'community';
      case DashboardCategoryFilter.digital:
        return category == 'digital' || category == 'digital_engagement';
    }
  }

  int _compareMetrics(
    MetricWithLatest a,
    MetricWithLatest b,
    KpiSortMode mode,
  ) {
    switch (mode) {
      case KpiSortMode.priority:
        final pa = a.metric.priority;
        final pb = b.metric.priority;
        return pa.compareTo(pb);

      case KpiSortMode.valueDesc:
        final va = a.latestPoint?.value ?? 0;
        final vb = b.latestPoint?.value ?? 0;
        return vb.compareTo(va); // highest first

      case KpiSortMode.name:
        return a.metric.title.compareTo(b.metric.title);
    }
  }
}

/// -------------------------------------------------------------------------
/// FILTER / SORT BAR WIDGET
/// -------------------------------------------------------------------------
class _KpiFilterBar extends StatelessWidget {
  final DashboardCategoryFilter selectedCategory;
  final KpiSortMode sortMode;
  final ValueChanged<DashboardCategoryFilter?> onCategoryChanged;
  final ValueChanged<KpiSortMode?> onSortModeChanged;

  const _KpiFilterBar({
    required this.selectedCategory,
    required this.sortMode,
    required this.onCategoryChanged,
    required this.onSortModeChanged,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Wrap(
      spacing: 12,
      runSpacing: 8,
      crossAxisAlignment: WrapCrossAlignment.center,
      children: [
        // Category chips
        Wrap(
          spacing: 8,
          children: [
            _CategoryChip(
              label: 'All',
              value: DashboardCategoryFilter.all,
              groupValue: selectedCategory,
              onSelected: onCategoryChanged,
            ),
            _CategoryChip(
              label: 'Reporting',
              value: DashboardCategoryFilter.reportingHelp,
              groupValue: selectedCategory,
              onSelected: onCategoryChanged,
            ),
            _CategoryChip(
              label: 'Support',
              value: DashboardCategoryFilter.supportCase,
              groupValue: selectedCategory,
              onSelected: onCategoryChanged,
            ),
            _CategoryChip(
              label: 'Awareness',
              value: DashboardCategoryFilter.awareness,
              groupValue: selectedCategory,
              onSelected: onCategoryChanged,
            ),
            _CategoryChip(
              label: 'Digital',
              value: DashboardCategoryFilter.digital,
              groupValue: selectedCategory,
              onSelected: onCategoryChanged,
            ),
          ],
        ),

        const SizedBox(width: 12),

        // Sort dropdown
        Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Sort by:',
              style: theme.textTheme.bodySmall,
            ),
            const SizedBox(width: 8),
            DropdownButton<KpiSortMode>(
              value: sortMode,
              underline: const SizedBox.shrink(),
              items: const [
                DropdownMenuItem(
                  value: KpiSortMode.priority,
                  child: Text('Priority'),
                ),
                DropdownMenuItem(
                  value: KpiSortMode.valueDesc,
                  child: Text('Latest value'),
                ),
                DropdownMenuItem(
                  value: KpiSortMode.name,
                  child: Text('Name'),
                ),
              ],
              onChanged: onSortModeChanged,
            ),
          ],
        ),
      ],
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final String label;
  final DashboardCategoryFilter value;
  final DashboardCategoryFilter groupValue;
  final ValueChanged<DashboardCategoryFilter?> onSelected;

  const _CategoryChip({
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isSelected = value == groupValue;
    return ChoiceChip(
      label: Text(label),
      selected: isSelected,
      onSelected: (_) => onSelected(value),
    );
  }
}

/// Skeleton row while loading KPIs.
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
