// ==========================================================
// footer_social_section.dart — Footer Social Icons Section
// ==========================================================

import 'package:flutter/material.dart';
import 'footer_social_icon.dart';

class FooterSocialSection extends StatelessWidget {
  const FooterSocialSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Follow Us",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),

        // Social icons row
        const Row(
          children: [
            FooterSocialIcon(
              icon: Icons.facebook,
              url: "https://placeholder.com",
            ),
            FooterSocialIcon(
              icon: Icons.camera_alt,
              url: "https://placeholder.com",
            ),
            FooterSocialIcon(icon: Icons.mail, url: "https://placeholder.com"),
            FooterSocialIcon(
              icon: Icons.play_circle_fill,
              url: "https://placeholder.com",
            ),
          ],
        ),
      ],
    );
  }
}
