// ==========================================================
// footer_quick_links_section.dart — Footer Quick Links
// ==========================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FooterQuickLinksSection extends StatelessWidget {
  const FooterQuickLinksSection({super.key});

  @override
  Widget build(BuildContext context) {
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
}
