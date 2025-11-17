// =================================
// app_shell.dart — Integration Guide
// =================================
// PURPOSE:
// - Provides the reusable layout (AppBar + footer).
// - All pages inside ShellRoute render here.
// - Ensures consistent branding + structure.
//
// Responsive behaviour:
// - Desktop: top nav bar with inline buttons.
// - Tablet/Mobile: compact dropdown menu in AppBar.
//
// DO NOT put page-specific logic here.
// =================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatelessWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();

    return LayoutBuilder(
      builder: (context, constraints) {
        final isDesktop = constraints.maxWidth >= 900;

        return Scaffold(
          appBar: AppBar(
            title: InkWell(
              onTap: () => context.go('/'),
              child: const Text('GBV Awareness'),
            ),
            centerTitle: false,
            // Desktop: show full nav bar
            // Mobile/Tablet: show dropdown menu
            actions: [
              if (isDesktop)
                _DesktopNavBar(currentRoute: currentRoute)
              else
                _MobileNavMenu(currentRoute: currentRoute),
              const SizedBox(width: 12),
            ],
          ),
          body: Column(
            children: [
              // Main content
              Expanded(
                child: Container(
                  color: Colors.white,
                  child: child,
                ),
              ),

              // Footer
              const _AppFooter(),
            ],
          ),
        );
      },
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// NAV CONFIG
///////////////////////////////////////////////////////////////////////////////

class _NavItem {
  final String label;
  final String route;
  const _NavItem(this.label, this.route);
}

// Primary items for the top nav / dropdown
const List<_NavItem> _primaryNavItems = [
  _NavItem('Home', '/'),
  _NavItem('About', '/about'),
  _NavItem('Information Hub', '/info'),
  _NavItem('Product', '/product'),
  _NavItem('Support', '/support'),
  _NavItem('Contact', '/contact'),
];

///////////////////////////////////////////////////////////////////////////////
/// DESKTOP NAV BAR
///////////////////////////////////////////////////////////////////////////////

class _DesktopNavBar extends StatelessWidget {
  final String currentRoute;
  const _DesktopNavBar({required this.currentRoute});

  bool _isSelected(_NavItem item) {
    // Highlight even if on a sub-route, e.g. /info/blog/123
    if (currentRoute == item.route) return true;
    if (item.route == '/') return currentRoute == '/';
    return currentRoute.startsWith('${item.route}/');
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        for (final item in _primaryNavItems)
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 4.0),
            child: TextButton(
              onPressed: () {
                if (!_isSelected(item)) {
                  context.go(item.route);
                }
              },
              style: TextButton.styleFrom(
                foregroundColor:
                    _isSelected(item) ? Theme.of(context).colorScheme.primary : null,
              ),
              child: Text(item.label),
            ),
          ),
      ],
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// MOBILE/TABLET DROPDOWN MENU
///////////////////////////////////////////////////////////////////////////////

class _MobileNavMenu extends StatelessWidget {
  final String currentRoute;
  const _MobileNavMenu({required this.currentRoute});

  bool _isSelected(_NavItem item) {
    if (currentRoute == item.route) return true;
    if (item.route == '/') return currentRoute == '/';
    return currentRoute.startsWith('${item.route}/');
  }

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<_NavItem>(
      icon: const Icon(Icons.menu),
      onSelected: (item) {
        context.go(item.route);
      },
      itemBuilder: (context) {
        return _primaryNavItems.map((item) {
          final selected = _isSelected(item);
          return PopupMenuItem<_NavItem>(
            value: item,
            child: Row(
              children: [
                if (selected)
                  const Icon(Icons.check, size: 16)
                else
                  const SizedBox(width: 16),
                const SizedBox(width: 8),
                Text(item.label),
              ],
            ),
          );
        }).toList();
      },
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// FOOTER
///////////////////////////////////////////////////////////////////////////////

class _AppFooter extends StatelessWidget {
  const _AppFooter();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      color: Colors.deepPurple.shade600,
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 600;

          return Column(
            crossAxisAlignment:
                isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
            children: [
              // Top footer row
              if (isWide)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    _footerLeftContent(context),
                    _footerRightContent(context),
                  ],
                )
              else ...[
                _footerLeftContent(context),
                const SizedBox(height: 12),
                _footerRightContent(context),
              ],

              const SizedBox(height: 8),

              // Bottom copyright text
              const Center(
                child: Text(
                  "© 2025 GBV Awareness Project — All rights reserved",
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.white70,
                  ),
                ),
              )
            ],
          );
        },
      ),
    );
  }

  Widget _footerLeftContent(BuildContext context) {
    return const Text(
      "GBV Awareness Initiative\nProviding help, education, and support.",
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        height: 1.4,
      ),
    );
  }

  Widget _footerRightContent(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.facebook, color: Colors.white70),
        SizedBox(width: 12),
        Icon(Icons.linked_camera, color: Colors.white70),
        SizedBox(width: 12),
        Icon(Icons.mail, color: Colors.white70),
      ],
    );
  }
}
