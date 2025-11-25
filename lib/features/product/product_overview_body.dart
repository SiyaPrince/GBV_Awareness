import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'package:gbv_awareness/common/models/product.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';
import 'package:gbv_awareness/common/widgets/primary_button.dart';

class ProductOverviewBody extends StatelessWidget {
  final List<Product> products;

  const ProductOverviewBody({
    super.key,
    required this.products,
  });

  @override
  Widget build(BuildContext context) {
    // Title is also dynamic: if single product, use its name.
    final title = products.length == 1 ? products.first.name : "";
    final subtitle =
        products.length == 1 ? products.first.shortDescription : "";

    return AppPage(
      title: title,
      subtitle: subtitle,
      children: [
        if (products.length == 1)
          _SingleProductView(product: products.first)
        else
          _ProductsGridView(products: products),
      ],
    );
  }
}

/// Full-width view for a single product.
class _SingleProductView extends StatelessWidget {
  final Product product;

  const _SingleProductView({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage = product.heroImageUrl != null &&
        product.heroImageUrl!.trim().isNotEmpty;
    final hasCta = product.ctaLabel != null &&
        product.ctaLabel!.trim().isNotEmpty &&
        product.ctaUrl != null &&
        product.ctaUrl!.trim().isNotEmpty;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (hasImage) ...[
          ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Image.network(
              product.heroImageUrl!,
              height: 220,
              width: double.infinity,
              fit: BoxFit.cover,
            ),
          ),
          const SizedBox(height: 16),
        ],
        if (product.longDescription.isNotEmpty) ...[
          Text(
            product.longDescription,
            style: theme.textTheme.bodyMedium?.copyWith(height: 1.4),
          ),
          const SizedBox(height: 16),
        ],
        if (product.pillars.isNotEmpty) ...[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              for (final p in product.pillars) ...[
                Text(
                  "• $p",
                  style: const TextStyle(fontSize: 14),
                ),
                const SizedBox(height: 4),
              ],
            ],
          ),
          const SizedBox(height: 16),
        ],
        if (hasCta)
          PrimaryButton(
            label: product.ctaLabel!,
            onPressed: () {
              final url = product.ctaUrl!;
              if (url.startsWith('/')) {
                context.go(url);
              } else {
                // external URL (e.g. https://example.org/gbv-aware-hub)
                // You can plug in url_launcher here later.
              }
            },
          ),
      ],
    );
  }
}

/// Grid view when there are multiple products.
class _ProductsGridView extends StatelessWidget {
  final List<Product> products;

  const _ProductsGridView({required this.products});

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final isWide = constraints.maxWidth > 800;
        final crossAxisCount = isWide ? 3 : 1;

        return GridView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: products.length,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 16,
            mainAxisSpacing: 16,
            childAspectRatio: isWide ? 1.2 : 1.5,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return _ProductCard(product: product);
          },
        );
      },
    );
  }
}

class _ProductCard extends StatelessWidget {
  final Product product;

  const _ProductCard({required this.product});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final hasImage = product.heroImageUrl != null &&
        product.heroImageUrl!.trim().isNotEmpty;
    final hasCta = product.ctaLabel != null &&
        product.ctaLabel!.trim().isNotEmpty &&
        product.ctaUrl != null &&
        product.ctaUrl!.trim().isNotEmpty;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (hasImage)
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: Image.network(
                  product.heroImageUrl!,
                  height: 100,
                  width: double.infinity,
                  fit: BoxFit.cover,
                ),
              ),
            const SizedBox(height: 8),
            Text(
              product.name,
              style: theme.textTheme.titleMedium,
            ),
            if (product.shortDescription.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(
                product.shortDescription,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: theme.textTheme.bodySmall,
              ),
            ],
            if (product.pillars.isNotEmpty) ...[
              const SizedBox(height: 8),
              Expanded(
                child: ListView(
                  shrinkWrap: true,
                  children: [
                    for (final p in product.pillars.take(3))
                      Text(
                        "• $p",
                        style: const TextStyle(fontSize: 12),
                      ),
                  ],
                ),
              ),
            ] else
              const Spacer(),
            if (hasCta)
              Align(
                alignment: Alignment.bottomLeft,
                child: TextButton(
                  onPressed: () {
                    final url = product.ctaUrl!;
                    if (url.startsWith('/')) {
                      context.go(url);
                    } else {
                      // external URL (future: url_launcher)
                    }
                  },
                  child: Text(product.ctaLabel!),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
