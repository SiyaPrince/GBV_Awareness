// lib/common/widgets/key_features_preview_section.dart
import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/app_features.dart';
import 'package:gbv_awareness/common/widgets/page_section.dart';
import 'package:gbv_awareness/common/widgets/feature_card.dart';

class KeyFeaturesPreviewSection extends StatelessWidget {
  const KeyFeaturesPreviewSection({super.key});

  static const _preview = [
    AppFeature(
      title: "Anonymous Reporting",
      description: "Share incidents safely without revealing your identity.",
      icon: Icons.lock_outline,
    ),
    AppFeature(
      title: "Safety Planning",
      description: "Build a personalised safety plan in small, supported steps.",
      icon: Icons.shield_outlined,
    ),
    AppFeature(
      title: "Resource Finder",
      description: "Find local hotlines, shelters, and legal support instantly.",
      icon: Icons.map_outlined,
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return PageSection(
      title: "A glimpse of what's inside",
      subtitle: "Explore the features designed with safety and care in mind.",
      child: LayoutBuilder(
        builder: (context, constraints) {
          final wide = constraints.maxWidth > 800;
          final crossAxisCount = wide ? 3 : 1;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: _preview.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: crossAxisCount,
              mainAxisSpacing: 16,
              crossAxisSpacing: 16,
              childAspectRatio: wide ? 1.3 : 1.8,
            ),
            itemBuilder: (context, index) {
              final f = _preview[index];
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
}
