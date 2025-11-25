import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "About This Project",
            style: textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          Text(
            "This GBV Awareness platform aims to provide easily accessible "
            "information, support resources, educational articles, and "
            "blog posts related to Gender-Based Violence. Our goal is to "
            "create a safe digital space for learning, support, and empowerment.",
            style: textTheme.bodyLarge,
          ),

          const SizedBox(height: 28),

          Text(
            "Project Mission",
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          Text(
            "• To educate communities about the signs, risks, and impact of GBV.\n"
            "• To provide verified support contacts such as hotlines, NGOs, and shelters.\n"
            "• To encourage victims and families to seek help safely.\n"
            "• To raise awareness and spark meaningful conversation.",
            style: textTheme.bodyLarge,
          ),

          const SizedBox(height: 28),

          Text(
            "Why This Matters",
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          Text(
            "GBV continues to affect millions of people across South Africa and "
            "the world. By creating this platform, we hope to make reliable "
            "information and support easy to access for everyone.",
            style: textTheme.bodyLarge,
          ),

          const SizedBox(height: 28),

          Text(
            "Credits",
            style: textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 12),

          Text(
            "This project was developed by a dedicated team of students who "
            "aim to make a difference in their community through technology.",
            style: textTheme.bodyLarge,
          ),
        ],
      ),
    );
  }
}
