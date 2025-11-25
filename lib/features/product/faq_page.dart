// lib/features/product/faq_page.dart

import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/faq_item.dart';
import 'package:gbv_awareness/common/services/firebase_product_service.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';

import 'faq_body.dart';

class ProductFaqPage extends StatelessWidget {
  const ProductFaqPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FirebaseProductService.instance;

    return StreamBuilder<List<FaqItem>>(
      stream: service.streamFaqItems(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error
        if (snapshot.hasError) {
          return const AppPage(
            title: "Frequently Asked Questions",
            subtitle: "We couldn't load the FAQs right now.",
            children: [
              SizedBox(height: 24),
              Text(
                "Please check your connection or try again later.",
                style: TextStyle(fontSize: 15),
              ),
            ],
          );
        }

        final items = snapshot.data ?? const [];
        if (items.isEmpty) {
          return const AppPage(
            title: "Frequently Asked Questions",
            subtitle: "FAQs will be available here soon.",
            children: [
              SizedBox(height: 24),
              Text(
                "Once configured, this page will show answers to common questions.",
                style: TextStyle(fontSize: 15),
              ),
            ],
          );
        }

        return ProductFaqBody(items: items);
      },
    );
  }
}
