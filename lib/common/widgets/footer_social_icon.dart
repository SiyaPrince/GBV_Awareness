// ==========================================================
// footer_social_icon.dart — Single Social Icon Button
// ==========================================================

import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class FooterSocialIcon extends StatelessWidget {
  final IconData icon;
  final String url;

  const FooterSocialIcon({super.key, required this.icon, required this.url});

  Future<void> _openLink() async {
    final uri = Uri.parse(url);

    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      debugPrint("Could not launch $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: _openLink,
        borderRadius: BorderRadius.circular(6),
        child: Icon(icon, color: Colors.white, size: 26),
      ),
    );
  }
}
