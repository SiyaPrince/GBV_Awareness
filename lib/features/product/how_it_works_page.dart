import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/how_it_works_step.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';
import 'package:gbv_awareness/common/widgets/page_section.dart';
import 'package:gbv_awareness/common/widgets/primary_button.dart';
import 'package:gbv_awareness/common/widgets/step_card.dart';
import 'package:go_router/go_router.dart';

class HowItWorksPage extends StatelessWidget {
  const HowItWorksPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: "How It Works",
      subtitle:
          "A simple, safe, and supportive journey designed to help you access resources and guidance quickly.",
      children: [
        _buildStepSection(context),
        _buildSafetyFlowSection(),
        _buildFinalCTASection(context),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 1: Step-by-step flow
  // ---------------------------------------------------------------------------

  Widget _buildStepSection(BuildContext context) {
    const steps = [
      HowItWorksStep(
        title: "1. Start Safely",
        description:
            "Open the platform on a device you trust. No login required, and no personal data stored.",
        icon: Icons.shield_outlined,
      ),
      HowItWorksStep(
        title: "2. Explore Your Options",
        description:
            "Learn about your rights, access supportive articles, and view clear next-step guidance.",
        icon: Icons.menu_book_outlined,
      ),
      HowItWorksStep(
        title: "3. Find Trusted Support",
        description:
            "Browse local hotlines, shelters, legal services, and community organisations.",
        icon: Icons.location_on_outlined,
      ),
      HowItWorksStep(
        title: "4. Create a Safety Plan",
        description:
            "Build a personalised safety plan with calm, step-by-step instructions.",
        icon: Icons.assignment_turned_in_outlined,
      ),
      HowItWorksStep(
        title: "5. Take Action at Your Pace",
        description:
            "Save helpful information, follow supportive checklists, and move forward safely.",
        icon: Icons.favorite_outline,
      ),
    ];

    return PageSection(
      title: "Your journey with the platform",
      subtitle:
          "Each step is written in clear, supportive language and designed to avoid overwhelm.",
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          final crossAxisCount = isWide ? 3 : 1;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: steps.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isWide ? 1.3 : 1.8,
            ),
            itemBuilder: (context, index) {
              final s = steps[index];
              return StepCard(
                icon: s.icon,
                title: s.title,
                description: s.description,
              );
            },
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 2: Safety-first design principles
  // ---------------------------------------------------------------------------

  Widget _buildSafetyFlowSection() {
    return PageSection(
      title: "Safety-first design",
      subtitle:
          "Every part of this platform is built to protect privacy and reduce risk.",
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F8FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          "No accounts. No tracking. No sensitive data stored. You stay in control "
          "of what you view, what you save, and when you exit the platform. "
          "Information is written in a calm, reassuring tone to avoid triggering language.",
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 3: CTA
  // ---------------------------------------------------------------------------

  Widget _buildFinalCTASection(BuildContext context) {
    return PageSection(
      title: "See features we have in the platform",
      child: PrimaryButton(
        label: "View Features",
        onPressed: () => context.go('/product/features'),
      ),
    );
  }
}
