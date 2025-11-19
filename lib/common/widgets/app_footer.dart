// ==========================================================
// app_footer.dart — Responsive Footer (composition)
// ==========================================================

import 'package:flutter/material.dart';

import 'footer_info_section.dart';
import 'footer_quick_links_section.dart';
import 'footer_social_section.dart';
import 'footer_cta_button.dart';

class AppFooter extends StatelessWidget {
  const AppFooter({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 26),
      decoration: BoxDecoration(color: color.primary),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final maxWidth = constraints.maxWidth;
          final bool isLarge = maxWidth >= 1200; // big desktop
          final bool isMedium =
              maxWidth >= 800 && maxWidth < 1200; // tablet / small laptop

          Widget topSection;

          if (isLarge) {
            // LARGE DESKTOP: clean 4-column row
            topSection = Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                FooterInfoSection(),
                FooterQuickLinksSection(),
                FooterSocialSection(),
                FooterCTAButton(),
              ],
            );
          } else if (isMedium) {
            // MEDIUM: wrap to avoid overflow
            topSection = const Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 32,
              runSpacing: 24,
              children: [
                FooterInfoSection(),
                FooterQuickLinksSection(),
                FooterSocialSection(),
                FooterCTAButton(),
              ],
            );
          } else {
            // SMALL (MOBILE): stacked
            topSection = const Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                FooterInfoSection(),
                SizedBox(height: 24),
                FooterQuickLinksSection(),
                SizedBox(height: 24),
                FooterSocialSection(),
                SizedBox(height: 24),
                FooterCTAButton(),
              ],
            );
          }

          return Column(
            crossAxisAlignment: isLarge
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              topSection,
              const SizedBox(height: 32),
              Center(
                child: Text(
                  "© 2025 GBV Awareness Project — All rights reserved",
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(
                    color: Colors.white.withValues(alpha: 0.75),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
