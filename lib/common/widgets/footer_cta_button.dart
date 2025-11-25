// ==========================================================
// footer_cta_button.dart — Footer CTA ("Need Help?")
// ==========================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class FooterCTAButton extends StatelessWidget {
  const FooterCTAButton({super.key});

  @override
  Widget build(BuildContext context) {
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
