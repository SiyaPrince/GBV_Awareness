import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/stats/firebase_stats_service.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';
import 'package:gbv_awareness/content/dashboard_intro_content.dart';
import 'package:gbv_awareness/features/dashboard/controllers/dashboard_controller.dart';
import 'package:gbv_awareness/features/dashboard/widgets/dashboard_kpi_row.dart';
import 'package:gbv_awareness/features/dashboard/widgets/dashboard_context_section.dart';
import 'package:gbv_awareness/features/dashboard/widgets/dashboard_primary_section.dart';

class DashboardPage extends StatelessWidget {
  final DashboardController? controllerOverride;

  const DashboardPage({super.key, this.controllerOverride});

  @override
  Widget build(BuildContext context) {
    final controller =
        controllerOverride ??
        DashboardController(statsService: FirebaseStatsService());

    return AppPage(
      title: DashboardIntroContent.pageTitle,
      subtitle: DashboardIntroContent.pageSubtitle,
      children: [
        // Add Dev B's context section at the top
        const DashboardContextSection(),
        const SizedBox(height: 24),

        // KPI metrics row
        DashboardKpiRow(controller: controller),
        const SizedBox(height: 24),

        // Main charts section
        DashboardPrimarySection(controller: controller),
      ],
    );
  }
}
