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
// - “Need Help” button ONLY in footer
// - Uses Material 3 conventions
//
// ==========================================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:gbv_awareness/common/widgets/app_header_bar.dart';
import 'package:gbv_awareness/common/widgets/app_navigation_drawer.dart';
import 'package:gbv_awareness/common/widgets/app_footer.dart';

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

  static const double _headerHeight = 72;

  @override
  void initState() {
    super.initState();

    _scrollController.addListener(() {
      final offset = _scrollController.offset;

      // NAV BAR SCROLL BEHAVIOR
      if (offset > _lastOffset && offset > 50) {
        // scrolling down → hide navbar
        if (_showAppBar) setState(() => _showAppBar = false);
      } else {
        // scrolling up → show navbar
        if (!_showAppBar) setState(() => _showAppBar = true);
      }
      _lastOffset = offset;

      // FOOTER VISIBILITY LOGIC
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

    // Decide when we treat it as "desktop"
    final width = MediaQuery.of(context).size.width;
    final bool isDesktop = width >= 1100; // tweak if needed

    return Scaffold(
      // Drawer only on non-desktop (mobile/tablet)
      drawer: isDesktop
          ? null
          : AppNavigationDrawer(currentRoute: currentRoute),
      body: CustomScrollView(
        controller: _scrollController,
        slivers: [
          // ==================================================
          // SLIVER NAV BAR (using flexibleSpace for full control)
          // ==================================================
          SliverAppBar(
            floating: true,
            snap: true,
            forceElevated: true,
            elevation: _showAppBar ? 1 : 0,
            backgroundColor: Theme.of(context).colorScheme.primary,
            surfaceTintColor: Colors.transparent,
            expandedHeight: _showAppBar ? _headerHeight : 0,
            collapsedHeight: _headerHeight,
            toolbarHeight: _headerHeight,
            pinned: false,
            automaticallyImplyLeading: !isDesktop,
            titleSpacing: 0,
            title: null,
            flexibleSpace: AnimatedOpacity(
              duration: const Duration(milliseconds: 250),
              opacity: _showAppBar ? 1 : 0,
              child: SafeArea(
                bottom: false,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: AppHeaderBar(
                    currentRoute: currentRoute,
                    isDesktop: isDesktop,
                  ),
                ),
              ),
            ),
          ),

          // ==================================================
          // PAGE CONTENT (SELECTABLE, CENTERED, MAX WIDTH)
          // ==================================================
          SliverToBoxAdapter(
            child: SelectionArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: ConstrainedBox(
                  constraints: const BoxConstraints(maxWidth: 1200),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24,
                      vertical: 32,
                    ),
                    child: widget.child, // your page content
                  ),
                ),
              ),
            ),
          ),

          // ==================================================
          // FOOTER (fades in near bottom)
          // ==================================================
          SliverToBoxAdapter(
            child: AnimatedOpacity(
              opacity: _showFooter ? 1 : 0,
              duration: const Duration(milliseconds: 400),
              child: const AppFooter(),
            ),
          ),
        ],
      ),
    );
  }
}
