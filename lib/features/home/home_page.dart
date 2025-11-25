import 'package:flutter/material.dart';

import 'widgets/home_hero_section.dart';
import 'widgets/home_what_we_do_section.dart';
import 'widgets/home_latest_articles_section.dart';
import 'widgets/home_insights_teaser_section.dart';
import 'widgets/home_product_highlight_section.dart';
import 'widgets/home_support_cta_section.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    // NOTE:
    // AppShell already wraps this in padding + maxWidth + scroll.
    // So this should just be pure content.
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: const [
        HomeHeroSection(),
        SizedBox(height: 32),
        HomeWhatWeDoSection(),
        SizedBox(height: 32),
        HomeLatestArticlesSection(),
        SizedBox(height: 32),
        HomeInsightsTeaserSection(),
        SizedBox(height: 32),
        HomeProductHighlightSection(),
        SizedBox(height: 32),
        HomeSupportCTASection(),
        SizedBox(height: 16),
      ],
    );
  }
}
