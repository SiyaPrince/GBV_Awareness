// ==========================================================
// app_footer.dart — Responsive Footer
// ==========================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

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
              children: [
                _footerInfo(context),
                _footerQuickLinks(context),
                _footerSocial(context),
                _footerCTA(context),
              ],
            );
          } else if (isMedium) {
            // MEDIUM: wrap to avoid overflow
            topSection = Wrap(
              alignment: WrapAlignment.spaceBetween,
              crossAxisAlignment: WrapCrossAlignment.start,
              spacing: 32,
              runSpacing: 24,
              children: [
                _footerInfo(context),
                _footerQuickLinks(context),
                _footerSocial(context),
                _footerCTA(context),
              ],
            );
          } else {
            // SMALL (MOBILE): stacked
            topSection = Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                _footerInfo(context),
                const SizedBox(height: 24),
                _footerQuickLinks(context),
                const SizedBox(height: 24),
                _footerSocial(context),
                const SizedBox(height: 24),
                _footerCTA(context),
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

  // ----------------------------
  // LEFT COLUMN — Info
  // ----------------------------
  Widget _footerInfo(BuildContext context) {
    return SizedBox(
      width: 280,
      child: SelectableText(
        "GBV Awareness Initiative\nProviding education, support, and resources.\n\n"
        "Address: 123 Placeholder Road\n"
        "Email: contact@example.com\n"
        "Phone: +1 234 567 890",
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.white, height: 1.4),
      ),
    );
  }

  // ----------------------------
  // QUICK LINKS (GROUPED)
  // ----------------------------
  Widget _footerQuickLinks(BuildContext context) {
    Widget linkButton(String label, String route) {
      return TextButton(
        onPressed: () => context.go(route),
        style: TextButton.styleFrom(
          padding: EdgeInsets.zero,
          alignment: Alignment.centerLeft,
        ),
        child: Text(label, style: const TextStyle(color: Colors.white)),
      );
    }

    Widget linkGroup(String title, List<Widget> children) {
      return Padding(
        padding: const EdgeInsets.only(right: 32, bottom: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.titleSmall!.copyWith(
                color: Colors.white,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            ...children,
          ],
        ),
      );
    }

    return Wrap(
      alignment: WrapAlignment.start,
      runSpacing: 16,
      children: [
        // EXPLORE
        linkGroup("Explore", [
          linkButton("Home", "/"),
          linkButton("About", "/about"),
          linkButton("Info Hub", "/info"),
        ]),

        // PRODUCT
        linkGroup("Product", [
          linkButton("Overview", "/product"),
          linkButton("Features", "/product/features"),
          linkButton("How It Works", "/product/how-it-works"),
          linkButton("Testimonials", "/product/testimonials"),
        ]),

        // SUPPORT
        linkGroup("Support", [
          linkButton("Support", "/support"),
          linkButton("Contact", "/contact"),
          linkButton("FAQ", "/product/faq"),
        ]),

        // LEGAL
        linkGroup("Legal", [
          linkButton("Privacy Policy", "/privacy"),
          linkButton("Terms of Service", "/terms"),
        ]),
      ],
    );
  }

  // ----------------------------
  // SOCIAL ICONS
  // ----------------------------
  Widget _footerSocial(BuildContext context) {
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
        Row(
          children: [
            _iconButton(Icons.facebook, "https://placeholder.com"),
            _iconButton(Icons.camera_alt, "https://placeholder.com"),
            _iconButton(Icons.mail, "https://placeholder.com"),
            _iconButton(Icons.play_circle_fill, "https://placeholder.com"),
          ],
        ),
      ],
    );
  }

  Widget _iconButton(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () {
          // TODO: open url using url_launcher if desired
        },
        child: Icon(icon, color: Colors.white, size: 26),
      ),
    );
  }

  // ----------------------------
  // CTA BUTTON
  // ----------------------------
  Widget _footerCTA(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.go('/support'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC2185B), // Deep Rose
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 2,
      ),
      child: const Text(
        "Need Help?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
