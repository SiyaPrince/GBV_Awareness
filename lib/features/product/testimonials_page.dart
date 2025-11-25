// lib/features/product/testimonials_page.dart

import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/testimonials.dart';
import 'package:gbv_awareness/common/services/firebase_product_service.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';
import 'package:gbv_awareness/features/product/testimonies_body.dart';


class ProductTestimonialsPage extends StatelessWidget {
  const ProductTestimonialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FirebaseProductService.instance;

    return StreamBuilder<List<Testimonial>>(
      stream: service.streamTestimonials(),
      builder: (context, snapshot) {
        // Loading
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        // Error
        if (snapshot.hasError) {
          return const AppPage(
            title: "Stories from the field",
            subtitle: "We couldn’t load testimonials right now.",
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

        // Empty state
        if (items.isEmpty) {
          return const AppPage(
            title: "Stories from the field",
            subtitle: "Testimonials will be available here soon.",
            children: [
              SizedBox(height: 24),
              Text(
                "Once configured, this page will show reflections from partners and practitioners.",
                style: TextStyle(fontSize: 15),
              ),
            ],
          );
        }

        // Normal state
        return ProductTestimonialsBody(items: items);
      },
    );
  }
}
