// ==========================================================
// footer_info_section.dart — Footer Left Info Block
// ==========================================================

import 'package:flutter/material.dart';

class FooterInfoSection extends StatelessWidget {
  const FooterInfoSection({super.key});

  @override
  Widget build(BuildContext context) {
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
}
