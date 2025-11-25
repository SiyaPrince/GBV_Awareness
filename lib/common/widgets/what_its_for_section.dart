// lib/common/widgets/what_its_for_section.dart
import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/widgets/page_section.dart';
import 'package:gbv_awareness/common/widgets/personal_card.dart';

class WhoItsForSection extends StatelessWidget {
  const WhoItsForSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const PageSection(
      title: "Who it's for",
      subtitle:
          "Designed to support survivors, loved ones, and organisations responding to GBV.",
      child: Wrap(
        spacing: 16,
        runSpacing: 16,
        children: [
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
}
