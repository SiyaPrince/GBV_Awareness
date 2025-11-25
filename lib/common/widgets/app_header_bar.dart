// ==========================================================
// app_header_bar.dart — Top Navigation Bar
// ==========================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppHeaderBar extends StatelessWidget {
  final String currentRoute;
  final bool isDesktop;

  const AppHeaderBar({
    super.key,
    required this.currentRoute,
    required this.isDesktop,
  });

  bool _isSelected(String route) {
    if (currentRoute == route) return true;
    return currentRoute.startsWith('$route/');
  }

  static const _primaryNavItems = <Map<String, String>>[
    {'label': 'Home', 'route': '/'},
    {'label': 'About', 'route': '/about'},
    {'label': 'Info', 'route': '/info'},
    {'label': 'Product', 'route': '/product'},
    {'label': 'Support', 'route': '/support'},
    {'label': 'Contact', 'route': '/contact'},
  ];

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final double fullHeight = constraints.maxHeight;

        return Padding(
          padding: const EdgeInsets.symmetric(horizontal: 60),
          child: Row(
            children: [
              InkWell(
                onTap: () => context.go('/'),
                child: Row(
                  children: [
                    // Logo fills the header height
                    SizedBox(
                      height: fullHeight,
                      child: FittedBox(
                        fit: BoxFit.cover,
                        child: Image.asset('assets/images/logo.jpg'),
                      ),
                    ),
                    const SizedBox(width: 40),
                    Text(
                      "GBV Awareness",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),

              const Spacer(),

              if (isDesktop)
                Row(
                  children: [
                    for (final item in _primaryNavItems)
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 30),
                        child: TextButton(
                          onPressed: () => context.go(item['route']!),
                          style: TextButton.styleFrom(
                            foregroundColor: _isSelected(item['route']!)
                                ? Colors.white
                                : Colors.white.withValues(alpha: 0.75),
                          ),
                          child: Text(
                            item['label']!,
                            style: const TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                  ],
                ),
            ],
          ),
        );
      },
    );
  }
}
