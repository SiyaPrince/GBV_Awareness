// lib/common/widgets/product_overview_cta_section.dart
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gbv_awareness/common/widgets/page_section.dart';
import 'package:gbv_awareness/common/widgets/primary_button.dart';

class ProductOverviewCtaSection extends StatelessWidget {
  const ProductOverviewCtaSection({super.key});

  @override
  Widget build(BuildContext context) {
    return PageSection(
      title: "See how everything works together",
      child: PrimaryButton(
        label: "Explore How It Works",
        onPressed: () => context.go('/product/how-it-works'),
      ),
    );
  }
}
