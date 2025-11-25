import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeWhatWeDoSection extends StatelessWidget {
  const HomeWhatWeDoSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "What this platform helps you do",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: color.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Clear guidance, supportive tools, and safe resources for those who need them most.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 900;
            final crossAxisCount = isWide ? 4 : 2;

            final items = [
              _WhatWeDoItem(
                icon: Icons.menu_book_outlined,
                title: "Awareness & Education",
                description:
                    "Learn the basics of GBV, common warning signs, and your rights.",
                route: "/info/articles",
              ),
              _WhatWeDoItem(
                icon: Icons.record_voice_over_outlined,
                title: "Stories & Voices",
                description:
                    "Read survivor-based stories and reflections in our blog.",
                route: "/info/blog",
              ),
              _WhatWeDoItem(
                icon: Icons.bar_chart_outlined,
                title: "Insights & Data",
                description:
                    "Explore high-level GBV indicators and trends (demo data).",
                route: "/dashboard",
              ),
              _WhatWeDoItem(
                icon: Icons.apps_outlined,
                title: "Supportive Tools",
                description:
                    "Discover tools designed to help survivors, supporters, and organisations.",
                route: "/product",
              ),
            ];

            return GridView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: items.length,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
                childAspectRatio: isWide ? 1.2 : 1,
              ),
              itemBuilder: (context, index) {
                final item = items[index];
                return _WhatWeDoCard(item: item);
              },
            );
          },
        ),
      ],
    );
  }
}

class _WhatWeDoItem {
  final IconData icon;
  final String title;
  final String description;
  final String route;

  const _WhatWeDoItem({
    required this.icon,
    required this.title,
    required this.description,
    required this.route,
  });
}

class _WhatWeDoCard extends StatelessWidget {
  final _WhatWeDoItem item;

  const _WhatWeDoCard({required this.item});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      child: InkWell(
        onTap: () => context.go(item.route),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Icon(item.icon, size: 28, color: color.primary),
              const SizedBox(height: 12),
              Text(
                item.title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Expanded(
                child: Text(
                  item.description,
                  style: Theme.of(
                    context,
                  ).textTheme.bodyMedium?.copyWith(height: 1.4),
                ),
              ),
              const SizedBox(height: 8),
              Text(
                "Learn more →",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
