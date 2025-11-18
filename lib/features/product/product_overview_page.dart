import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/app_features.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';
import 'package:gbv_awareness/common/widgets/feature_card.dart';
import 'package:gbv_awareness/common/widgets/page_section.dart';
import 'package:gbv_awareness/common/widgets/persona_card.dart';
import 'package:gbv_awareness/common/widgets/primary_button.dart';

class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: "Your Safety. Your Support.",
      subtitle:
          "A gentle, privacy-focused platform that helps survivors, allies, "
          "and organisations navigate gender-based violence safely.",
      children: [
        _buildWhatItDoesSection(),
        _buildWhoItsForSection(),
        _buildKeyFeaturesPreviewSection(context),
        _buildCTASection(context),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 1: What the product does
  // ---------------------------------------------------------------------------

  Widget _buildWhatItDoesSection() {
    return const PageSection(
      title: "What this platform helps you do",
      subtitle:
          "Clear guidance, supportive tools, and safe resources for those who need them most.",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "- Understand your rights and options",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 6),
          Text(
            "- Get non-judgmental guidance on next steps",
            style: TextStyle(fontSize: 15),
          ),
          SizedBox(height: 6),
          Text(
            "- Access trusted support and safety resources",
            style: TextStyle(fontSize: 15),
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 2: Who it's for
  // ---------------------------------------------------------------------------

  Widget _buildWhoItsForSection() {
    return PageSection(
      title: "Who it's for",
      subtitle:
          "Designed to support survivors, loved ones, and organisations responding to GBV.",
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: const [
          PersonaCard(
            title: "Survivors",
            bullets: [
              "Learn about your rights and available options.",
              "Document safely and understand next steps.",
              "Find trusted help on your own terms.",
            ],
          ),
          PersonaCard(
            title: "Friends & Family",
            bullets: [
              "Get guidance on supporting someone safely.",
              "Learn what to say and what not to say.",
              "Access quick resources to offer them help.",
            ],
          ),
          PersonaCard(
            title: "Organisations",
            bullets: [
              "Strengthen your internal response protocols.",
              "Provide verified resources to communities.",
              "Better understand survivor needs.",
            ],
          ),
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 3: Key features (preview)
  // ---------------------------------------------------------------------------

  Widget _buildKeyFeaturesPreviewSection(BuildContext context) {
    const previewFeatures = [
      AppFeature(
        title: "Anonymous Reporting",
        description: "Share incidents safely without revealing your identity.",
        icon: Icons.lock_outline,
      ),
      AppFeature(
        title: "Safety Planning",
        description:
            "Build a personalised safety plan in small, supported steps.",
        icon: Icons.shield_outlined,
      ),
      AppFeature(
        title: "Resource Finder",
        description:
            "Find local hotlines, shelters, and legal support instantly.",
        icon: Icons.map_outlined,
      ),
    ];

    return PageSection(
      title: "A glimpse of what's inside",
      subtitle: "Explore the features designed with safety and care in mind.",
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          final crossAxisCount = isWide ? 3 : 1;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: previewFeatures.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isWide ? 1.3 : 1.8,
            ),
            itemBuilder: (context, index) {
              final f = previewFeatures[index];
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
  // SECTION 4: CTA
  // ---------------------------------------------------------------------------

  Widget _buildCTASection(BuildContext context) {
    return PageSection(
      title: "See how everything works together",
      child: PrimaryButton(
        label: "Explore How It Works",
        onPressed: () {
          // TODO: navigate to How It Works page
        },
      ),
    );
  }
}
