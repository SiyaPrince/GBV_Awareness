// lib/features/product/features_body.dart

import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/app_features.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';
import 'package:gbv_awareness/common/widgets/feature_card.dart';
import 'package:gbv_awareness/common/widgets/page_section.dart';

class FeaturesBody extends StatelessWidget {
  const FeaturesBody({super.key});

  static const _allFeatures = [
    AppFeature(
      title: "Anonymous Reporting",
      description:
          "Capture incidents in a safe, guided flow without forcing personal details.",
      icon: Icons.lock_outline,
    ),
    AppFeature(
      title: "Safety Planning",
      description:
          "Build a personalised safety plan one small step at a time, at your own pace.",
      icon: Icons.shield_outlined,
    ),
    AppFeature(
      title: "Resource Finder",
      description:
          "Quickly find local hotlines, shelters, legal aid, and psychosocial support.",
      icon: Icons.map_outlined,
    ),
    AppFeature(
      title: "Knowledge & Rights",
      description:
          "Access plain-language information about GBV, your rights, and available options.",
      icon: Icons.menu_book_outlined,
    ),
    AppFeature(
      title: "Organisation Toolkit",
      description:
          "Support organisations with content, guidelines, and tools to improve GBV response.",
      icon: Icons.business_center_outlined,
    ),
    AppFeature(
      title: "Data & Insights (optional)",
      description:
          "For partners, configure privacy-safe analytics to see trends and patterns (opt-in only).",
      icon: Icons.insights_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: "All Features",
      subtitle:
          "Explore the tools and journeys that support survivors, allies, and organisations.",
      children: [
        PageSection(
          title: "Designed for real-world GBV work",
          subtitle:
              "Each feature is built with safety, consent, and real-life limitations in mind.",
          child: LayoutBuilder(
            builder: (context, constraints) {
              final isWide = constraints.maxWidth > 800;
              final crossAxisCount = isWide ? 3 : 1;

              return GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: _allFeatures.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: crossAxisCount,
                  mainAxisSpacing: 16,
                  crossAxisSpacing: 16,
                  childAspectRatio: isWide ? 1.3 : 1.7,
                ),
                itemBuilder: (context, index) {
                  final feature = _allFeatures[index];
                  return FeatureCard(
                    icon: feature.icon,
                    title: feature.title,
                    description: feature.description,
                  );
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
