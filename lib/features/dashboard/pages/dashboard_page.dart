import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/firebase_stats_service.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';
import 'package:gbv_awareness/features/dashboard/controllers/dashboard_controller.dart';
import 'package:gbv_awareness/features/dashboard/widgets/dashboarc_kpi_row.dart';
import 'package:gbv_awareness/features/dashboard/widgets/dashboard_primary_section.dart';

class DashboardPage extends StatelessWidget {
  final DashboardController? controllerOverride;

  const DashboardPage({
    super.key,
    this.controllerOverride,
  });

  @override
  Widget build(BuildContext context) {
    final controller = controllerOverride ??
        DashboardController(
          statsService: FirebaseStatsService(),
        );

    return AppPage(
      title: 'Real-Time GBV Dashboard',
      subtitle:
          'Live indicators to support awareness, policy, and survivor-focused action.',
      children: [
        DashboardKpiRow(controller: controller),
        const SizedBox(height: 24),
        DashboardPrimarySection(controller: controller),
      ],
    );
  }
}
