// ==========================================================
// app_navigation_drawer.dart — Mobile/Tablet Drawer
// ==========================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppNavigationDrawer extends StatelessWidget {
  final String currentRoute;

  const AppNavigationDrawer({super.key, required this.currentRoute});

  static const _items = <Map<String, String>>[
    {'label': 'Home', 'route': '/'},
    {'label': 'About', 'route': '/about'},
    {'label': 'Info Hub', 'route': '/info'},
    {'label': 'Product', 'route': '/product'},
    {'label': 'Support', 'route': '/support'},
    {'label': 'Contact', 'route': '/contact'},
  ];

  bool _isSelected(String route) {
    if (currentRoute == route) return true;
    return currentRoute.startsWith('$route/');
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      backgroundColor: theme.colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Menu", style: theme.textTheme.titleLarge),
              const SizedBox(height: 16),

              for (final item in _items)
                ListTile(
                  title: Text(
                    item['label']!,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _isSelected(item['route']!)
                          ? theme.colorScheme.primary
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.go(item['route']!);
                  },
                ),

              const Spacer(),
            ],
          ),
        ),
      ),
    );
  }
}
