// ==========================================================
// app_shell.dart — Responsive Shell With Sliver Nav + Footer
// ==========================================================
//
// FEATURES:
// - Responsive navigation bar (desktop inline items, mobile drawer)
// - Scroll-aware SliverAppBar: hides on scroll down, shows on scroll up
// - Footer appears only when near bottom
// - Text selection enabled ONLY in page content
// - Footer quick links clickable
// - “Need Help” button ONLY in footer (Deep Rose)
// - Theme integrated (Deep Purple, Lavender, Sand, Deep Rose)
// - Uses Material 3 conventions
//
// ==========================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class AppShell extends StatefulWidget {
  final Widget child;
  const AppShell({super.key, required this.child});

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  final ScrollController _scrollController = ScrollController();
  bool _showAppBar = true;
  bool _showFooter = false;
  double _lastOffset = 0;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final offset = _scrollController.offset;

      // ---------------------------
      // NAV BAR SCROLL BEHAVIOR
      // ---------------------------
      if (offset > _lastOffset && offset > 50) {
        // scrolling down → hide navbar
        if (_showAppBar) setState(() => _showAppBar = false);
      } else {
        // scrolling up → show navbar
        if (!_showAppBar) setState(() => _showAppBar = true);
      }

      _lastOffset = offset;

      // ---------------------------
      // FOOTER VISIBILITY LOGIC
      // ---------------------------
      final maxScroll = _scrollController.position.maxScrollExtent;
      if (offset >= maxScroll - 100) {
        if (!_showFooter) setState(() => _showFooter = true);
      } else {
        if (_showFooter) setState(() => _showFooter = false);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentRoute = GoRouterState.of(context).uri.toString();

    // 👉 Decide when we treat it as "desktop"
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1000; // adjust 1000 to taste

    return Scaffold(
      // Drawer only on non-desktop
      drawer: isDesktop ? null : _MobileDrawer(currentRoute: currentRoute),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // --------------------------------------------------
          // SLIVER NAV BAR
          // --------------------------------------------------
          SliverAppBar(
            floating: true,
            snap: true,
            forceElevated: true,
            elevation: _showAppBar ? 1 : 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            surfaceTintColor: Colors.transparent,
            expandedHeight: _showAppBar ? 82 : 0,
            collapsedHeight: 70,
            pinned: false,
            titleSpacing: 0,
            automaticallyImplyLeading: true,
            title: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _showAppBar ? 1 : 0,
              child: _NavBar(currentRoute: currentRoute),
            ),
          ),

          // --------------------------------------------------
          // PAGE CONTENT (SELECTABLE, CENTERED, MAX WIDTH)
          // --------------------------------------------------
          SliverToBoxAdapter(
            child: SelectionArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1100),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: widget.child, // usually an AppPage
                  ),
                ),
              ),
            ),
          ),

          // --------------------------------------------------
          // FOOTER
          // Footer only appears near bottom of scroll
          // --------------------------------------------------
          SliverToBoxAdapter(
            child: AnimatedOpacity(
              opacity: _showFooter ? 1 : 0,
              duration: const Duration(milliseconds: 400),
              child: const _AppFooter(),
            ),
          ),
        ],
      ),
    );
  }
}

//
// ==========================================================
// NAVIGATION CONFIG
// ==========================================================
//

class _NavItem {
  final String label;
  final String route;
  const _NavItem(this.label, this.route);
}

const List<_NavItem> _primaryNavItems = [
  _NavItem('Home', '/'),
  _NavItem('About', '/about'),
  _NavItem('Info', '/info'),
  _NavItem('Product', '/product'),
  _NavItem('Support', '/support'),
  _NavItem('Contact', '/contact'),
];

//
// ==========================================================
// DESKTOP NAV BAR
// ==========================================================
//

class _NavBar extends StatelessWidget {
  final String currentRoute;
  const _NavBar({required this.currentRoute});

  bool _isSelected(_NavItem item) {
    if (currentRoute == item.route) return true;
    return currentRoute.startsWith('${item.route}/');
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = MediaQuery.of(context).size.width >= 1000;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.go('/'),
            child: Row(
              children: [
                // Logo placeholder
                Image.asset(
                  'assets/images/logo.jpg', // <-- your path
                  height: 50,
                  fit: BoxFit.contain,
                ),
                const SizedBox(width: 20),
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
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: TextButton(
                      onPressed: () => context.go(item.route),
                      style: TextButton.styleFrom(
                        foregroundColor: _isSelected(item)
                            ? Colors.white
                            : Colors.white.withOpacity(.75),
                      ),
                      child: Text(
                        item.label,
                        style: const TextStyle(fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
              ],
            ),
        ],
      ),
    );
  }
}

//
// ==========================================================
// MOBILE DRAWER NAV
// ==========================================================
//

class _MobileDrawer extends StatelessWidget {
  final String currentRoute;
  const _MobileDrawer({required this.currentRoute});

  bool _isSelected(_NavItem item) {
    if (currentRoute == item.route) return true;
    return currentRoute.startsWith('${item.route}/');
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: Theme.of(context).colorScheme.surface,
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Menu", style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 16),

              for (final item in _primaryNavItems)
                ListTile(
                  title: Text(
                    item.label,
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                      color: _isSelected(item)
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.onSurface,
                    ),
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    context.go(item.route);
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

//
// ==========================================================
// FOOTER
// ==========================================================
//

class _AppFooter extends StatelessWidget {
  const _AppFooter();

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 24),
      decoration: BoxDecoration(color: color.primary),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 700;

          return Column(
            crossAxisAlignment: isWide
                ? CrossAxisAlignment.start
                : CrossAxisAlignment.center,
            children: [
              if (isWide)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _footerInfo(context),
                    _footerQuickLinks(context),
                    _footerSocial(context),
                    _footerCTA(context),
                  ],
                )
              else ...[
                _footerInfo(context),
                const SizedBox(height: 24),
                _footerQuickLinks(context),
                const SizedBox(height: 24),
                _footerSocial(context),
                const SizedBox(height: 24),
                _footerCTA(context),
              ],

              const SizedBox(height: 32),

              Text(
                "© 2025 GBV Awareness Project — All rights reserved",
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                  color: Colors.white.withOpacity(.75),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  // ----------------------------
  // LEFT COLUMN — Info
  // ----------------------------
  Widget _footerInfo(BuildContext context) {
    return SizedBox(
      width: 280,
      child: SelectableText(
        "GBV Awareness Initiative\nProviding education, support, and resources.\n\n"
        "Address: 123 Placeholder Road\n"
        "Email: contact@example.com\n"
        "Phone: +1 234 567 890",
        style: Theme.of(
          context,
        ).textTheme.bodyMedium!.copyWith(color: Colors.white, height: 1.4),
      ),
    );
  }

  // ----------------------------
  // QUICK LINKS
  // ----------------------------
  Widget _footerQuickLinks(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Quick Links",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),

        for (final item in _primaryNavItems)
          TextButton(
            onPressed: () => context.go(item.route),
            child: Text(
              item.label,
              style: const TextStyle(color: Colors.white),
            ),
          ),

        TextButton(
          onPressed: () => context.go('/privacy'),
          child: const Text(
            "Privacy Policy",
            style: TextStyle(color: Colors.white),
          ),
        ),
        TextButton(
          onPressed: () => context.go('/terms'),
          child: const Text(
            "Terms of Service",
            style: TextStyle(color: Colors.white),
          ),
        ),
      ],
    );
  }

  // ----------------------------
  // SOCIAL ICONS
  // ----------------------------
  Widget _footerSocial(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Follow Us",
          style: Theme.of(context).textTheme.titleMedium!.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 12),

        Row(
          children: [
            _iconButton(Icons.facebook, "https://placeholder.com"),
            _iconButton(Icons.camera_alt, "https://placeholder.com"),
            _iconButton(Icons.mail, "https://placeholder.com"),
            _iconButton(Icons.play_circle_fill, "https://placeholder.com"),
          ],
        ),
      ],
    );
  }

  Widget _iconButton(IconData icon, String url) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: InkWell(
        onTap: () {},
        child: Icon(icon, color: Colors.white, size: 26),
      ),
    );
  }

  // ----------------------------
  // CTA BUTTON
  // ----------------------------
  Widget _footerCTA(BuildContext context) {
    return ElevatedButton(
      onPressed: () => context.go('/support'),
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color(0xFFC2185B), // Deep Rose
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 16),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
        elevation: 2,
      ),
      child: const Text(
        "Need Help?",
        style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
      ),
    );
  }
}
