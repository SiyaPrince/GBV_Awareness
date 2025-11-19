import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/app_features.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';
import 'package:gbv_awareness/common/widgets/feature_card.dart';
import 'package:gbv_awareness/common/widgets/page_section.dart';
import 'package:gbv_awareness/common/widgets/persona_card.dart';
import 'package:gbv_awareness/common/widgets/primary_button.dart';
import 'package:go_router/go_router.dart';

class FeaturesPage extends StatelessWidget {
  const FeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: "Product Features",
      subtitle:
          "Explore the tools designed to support safety, clarity, and empowerment.",
      children: [
        _buildFeatureGridSection(context),
        _buildPersonaSection(),
        _buildSafetySection(),
        _buildFinalCTASection(context),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 1: Feature Grid
  // ---------------------------------------------------------------------------

  Widget _buildFeatureGridSection(BuildContext context) {
    const features = [
      AppFeature(
        title: "Anonymous Reporting",
        description:
            "Share incidents safely without revealing your identity or location.",
        icon: Icons.lock_outline,
      ),
      AppFeature(
        title: "Safety Planning",
        description:
            "Build a personalised safety plan with calm, guided steps.",
        icon: Icons.shield_outlined,
      ),
      AppFeature(
        title: "Resource Finder",
        description:
            "Locate trusted support resources like shelters, hotlines, and legal aid.",
        icon: Icons.map_outlined,
      ),
      AppFeature(
        title: "Guidance for Allies",
        description:
            "Learn how to support a friend or loved one facing GBV safely and gently.",
        icon: Icons.group_outlined,
      ),
      AppFeature(
        title: "Offline Tips",
        description:
            "View essential safety information even with limited connectivity.",
        icon: Icons.wifi_off_rounded,
      ),
      AppFeature(
        title: "Trauma-Informed Content",
        description:
            "Every page is written in a calm, supportive, non-triggering tone.",
        icon: Icons.self_improvement_outlined,
      ),
    ];

    return PageSection(
      title: "Key Features",
      subtitle: "Designed with survivors, allies, and organisations in mind.",
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          final crossAxisCount = isWide ? 3 : 1;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: features.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isWide ? 1.4 : 1.8,
            ),
            itemBuilder: (context, index) {
              final f = features[index];
              return FeatureCard(
                icon: f.icon,
                title: f.title,
                description: f.description,
              );
            },
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 2: Personas
  // ---------------------------------------------------------------------------

  Widget _buildPersonaSection() {
    return PageSection(
      title: "Built for different journeys",
      subtitle:
          "Everyone’s situation is unique — our tools support real-world needs.",
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: const [
          PersonaCard(
            title: "Survivors",
            bullets: [
              "Learn about your rights and safe options.",
              "Record incidents in a private space.",
              "Get calm, step-by-step guidance.",
            ],
          ),
          PersonaCard(
            title: "Friends & Family",
            bullets: [
              "Understand how to support safely.",
              "Avoid harmful or triggering responses.",
              "Connect your loved one to real help.",
            ],
          ),
          PersonaCard(
            title: "Organisations",
            bullets: [
              "Share verified resources with communities.",
              "Support GBV protocols and training.",
              "Gain insight into commonly needed tools.",
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 3: Safety & Privacy
  // ---------------------------------------------------------------------------

  Widget _buildSafetySection() {
    return PageSection(
      title: "Safety, Privacy & Accessibility",
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F8FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          "This platform is designed with a trauma-informed approach: "
          "minimal data collection, anonymous browsing, clear content, "
          "supportive language, and fast exit options to keep users safe.",
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
      ),
    );
  }

  Widget _buildFinalCTASection(BuildContext context) {
    return PageSection(
      title: "See real stories from people who used the platform",
      child: PrimaryButton(
        label: "View Testimonials",
        onPressed: () => context.go('/product/testimonials'),
      ),
    );
  }
}
