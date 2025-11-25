// lib/features/product/features_page.dart

import 'package:flutter/material.dart';
import 'features_body.dart';

class ProductFeaturesPage extends StatelessWidget {
  const ProductFeaturesPage({super.key});

  @override
  Widget build(BuildContext context) {
    // If you later need data from Firestore for features,
    // you can wrap FeaturesBody in a StreamBuilder here.
    return const FeaturesBody();
  }
}
