// lib/features/product/testimonials_body.dart

import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/testimonials.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';

class ProductTestimonialsBody extends StatelessWidget {
  final List<Testimonial> items;

  const ProductTestimonialsBody({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final sorted = [...items]..sort((a, b) => a.order.compareTo(b.order));

    return AppPage(
      title: "Stories from the field",
      subtitle:
          "Reflections from organisations and practitioners working with GBV support and data.",
      children: [
        const SizedBox(height: 8),
        Column(
          children: [for (final t in sorted) _TestimonialCard(testimonial: t)],
        ),
      ],
    );
  }
}

class _TestimonialCard extends StatelessWidget {
  final Testimonial testimonial;

  const _TestimonialCard({required this.testimonial});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    final subtitleParts = [
      testimonial.role?.trim(),
      testimonial.organisation?.trim(),
    ].where((part) => part != null && part.isNotEmpty).cast<String>().toList();

    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Quote
            Text(
              '“${testimonial.quote}”',
              style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
            ),
            const SizedBox(height: 12),

            // Name
            Text(
              testimonial.name,
              style: theme.textTheme.bodyMedium?.copyWith(
                fontWeight: FontWeight.w600,
              ),
            ),

            // Role • Organisation
            if (subtitleParts.isNotEmpty)
              Text(
                subtitleParts.join(' • '),
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.textTheme.bodySmall?.color?.withValues(
                    alpha: 0.8,
                  ),
                ),
              ),

            // Optional rating
            if (testimonial.rating != null) ...[
              const SizedBox(height: 8),
              Row(
                children: List.generate(
                  testimonial.rating!.clamp(1, 5),
                  (_) => const Icon(Icons.star, size: 16),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
