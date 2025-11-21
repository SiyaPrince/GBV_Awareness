import 'package:flutter/material.dart';
import 'dashboard_intro_card.dart';
import 'data_context_card.dart';
import 'safety_guidance_card.dart';

class DashboardContextSection extends StatelessWidget {
  const DashboardContextSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: const [
        // Main Introduction Card
        DashboardIntroCard(),
        SizedBox(height: 16),

        // Responsive layout for data context and safety guidance
        _DashboardContextLayout(),
      ],
    );
  }
}

class _DashboardContextLayout extends StatelessWidget {
  const _DashboardContextLayout();

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 700;

        if (isWide) {
          return const Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(child: DataContextCard()),
              SizedBox(width: 16),
              Expanded(child: SafetyGuidanceCard()),
            ],
          );
        } else {
          return const Column(
            children: [
              DataContextCard(),
              SizedBox(height: 16),
              SafetyGuidanceCard(),
            ],
          );
        }
      },
    );
  }
}
