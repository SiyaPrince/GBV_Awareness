import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/product.dart';
import 'package:gbv_awareness/common/services/firebase_product_service.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';

import 'product_overview_body.dart';

class ProductOverviewPage extends StatelessWidget {
  const ProductOverviewPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FirebaseProductService.instance;

    return StreamBuilder<List<Product>>(
      stream: service.streamProducts(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error
        if (snapshot.hasError) {
          return const AppPage(
            title: "",
            subtitle: "",
            children: [
              // We keep this minimal – it's not product copy,
              // just a generic error state.
              SizedBox(height: 24),
              Text("Unable to load products."),
            ],
          );
        }

        final products = snapshot.data ?? const [];

        if (products.isEmpty) {
          return const AppPage(
            title: "",
            subtitle: "",
            children: [
              SizedBox(height: 24),
              Text("No products configured."),
            ],
          );
        }

        // Pass ALL products into the body – no hardcoded text there.
        return ProductOverviewBody(products: products);
      },
    );
  }
}
