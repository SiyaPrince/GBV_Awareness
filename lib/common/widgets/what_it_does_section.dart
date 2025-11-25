// lib/common/widgets/what_it_does_section.dart

import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/widgets/page_section.dart';

class WhatItDoesSection extends StatelessWidget {
  /// Optional dynamic bullets from Product.pillars
  final List<String>? bullets;

  const WhatItDoesSection({super.key, this.bullets});

  @override
  Widget build(BuildContext context) {
    final effectiveBullets = (bullets == null || bullets!.isEmpty)
        ? const [
            "Understand your rights and options",
            "Get non-judgmental guidance on next steps",
            "Access trusted support and safety resources",
          ]
        : bullets!;

    return PageSection(
      title: "What this platform helps you do",
      subtitle:
          "Clear guidance, supportive tools, and safe resources for those who need them most.",
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (final line in effectiveBullets) ...[
            Text(
              "- $line",
              style: const TextStyle(fontSize: 15),
            ),
            const SizedBox(height: 6),
          ],
        ],
      ),
    );
  }
}
