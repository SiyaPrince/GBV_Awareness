// =================================
// app_shell.dart — Integration Guide
// =================================
// PURPOSE:
// - Provides the reusable layout (AppBar + footer).
// - All pages inside ShellRoute render here.
// - Ensures consistent branding + structure.
//
// YOU WILL MODIFY THIS FILE WHEN:
// - Adding a logo, drawer, sidebar, or responsive layout.
// - Adding “quick escape”, safety, or accessibility features.
// - Adding global navigation items.
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

    return Scaffold(
      appBar: AppBar(
        title: const Text('GBV Awareness'),
      ),

      // Mobile Drawer Navigation
      drawer: _AppDrawer(currentRoute: currentRoute),

      body: Column(
        children: [
          Expanded(
            child: Row(
              children: [
                // Show NavigationRail only on tablet/desktop
                LayoutBuilder(
                  builder: (context, constraints) {
                    if (constraints.maxWidth > 800) {
                      return _AppNavRail(currentRoute: currentRoute);
                    }
                    return const SizedBox.shrink();
                  },
                ),

                // Main content
                Expanded(
                  child: Container(
                    color: Colors.white,
                    child: child,
                  ),
                ),
              ],
            ),
          ),

          // Footer
          const _AppFooter(),
        ],
      ),
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// DRAWER MENU (Mobile)
///////////////////////////////////////////////////////////////////////////////
class _AppDrawer extends StatelessWidget {
  final String currentRoute;
  const _AppDrawer({required this.currentRoute});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: Colors.deepPurple),
            child: Text(
              "Menu",
              style: TextStyle(fontSize: 22, color: Colors.white),
            ),
          ),

          _drawerItem(
            context,
            icon: Icons.home,
            label: "Home",
            route: "/",
            currentRoute: currentRoute,
          ),
          _drawerItem(
            context,
            icon: Icons.info_outline,
            label: "About",
            route: "/about",
            currentRoute: currentRoute,
          ),
          _drawerItem(
            context,
            icon: Icons.article,
            label: "Blog",
            route: "/blog",
            currentRoute: currentRoute,
          ),
          _drawerItem(
            context,
            icon: Icons.menu_book,
            label: "Articles",
            route: "/articles",
            currentRoute: currentRoute,
          ),
          _drawerItem(
            context,
            icon: Icons.support_agent,
            label: "Support",
            route: "/support",
            currentRoute: currentRoute,
          ),
          _drawerItem(
            context,
            icon: Icons.contact_mail,
            label: "Contact",
            route: "/contact",
            currentRoute: currentRoute,
          ),
        ],
      ),
    );
  }

  Widget _drawerItem(
    BuildContext context, {
    required IconData icon,
    required String label,
    required String route,
    required String currentRoute,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(label),
      selected: currentRoute == route,
      onTap: () {
        Navigator.pop(context); // closes drawer
        context.go(route);
      },
    );
  }
}

///////////////////////////////////////////////////////////////////////////////
/// NAVIGATION RAIL (Tablet/Desktop)
///////////////////////////////////////////////////////////////////////////////
class _AppNavRail extends StatelessWidget {
  final String currentRoute;

  const _AppNavRail({required this.currentRoute});

  static const _routes = [
    "/",
    "/about",
    "/blog",
    "/articles",
    "/support",
    "/contact",
  ];

  int _selectedIndex() {
    return _routes.indexWhere((r) => r == currentRoute).clamp(0, _routes.length - 1);
  }

  @override
  Widget build(BuildContext context) {
    return NavigationRail(
      selectedIndex: _selectedIndex(),
      labelType: NavigationRailLabelType.all,
      onDestinationSelected: (index) {
        context.go(_routes[index]);
      },
      destinations: const [
        NavigationRailDestination(
          icon: Icon(Icons.home_outlined),
          selectedIcon: Icon(Icons.home),
          label: Text("Home"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.info_outline),
          selectedIcon: Icon(Icons.info),
          label: Text("About"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.article_outlined),
          selectedIcon: Icon(Icons.article),
          label: Text("Blog"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.menu_book_outlined),
          selectedIcon: Icon(Icons.menu_book),
          label: Text("Articles"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.support_agent_outlined),
          selectedIcon: Icon(Icons.support_agent),
          label: Text("Support"),
        ),
        NavigationRailDestination(
          icon: Icon(Icons.contact_mail_outlined),
          selectedIcon: Icon(Icons.contact_mail),
          label: Text("Contact"),
        ),
      ],
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
                    _footerLeftContent(),
                    _footerRightContent(),
                  ],
                )
              else ...[
                _footerLeftContent(),
                const SizedBox(height: 12),
                _footerRightContent(),
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

  Widget _footerLeftContent() {
    return const Text(
      "GBV Awareness Initiative\nProviding help, education, and support.",
      style: TextStyle(
        color: Colors.white,
        fontSize: 14,
        height: 1.4,
      ),
    );
  }

  Widget _footerRightContent() {
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
