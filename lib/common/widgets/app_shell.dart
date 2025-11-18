// // // =================================
// // // app_shell.dart — Integration Guide
// // // =================================
// // // PURPOSE:
// // // - Provides the reusable layout (AppBar + footer).
// // // - All pages inside ShellRoute render here.
// // // - Ensures consistent branding + structure.
// // //
// // // Responsive behaviour:
// // // - Desktop: top nav bar with inline buttons.
// // // - Tablet/Mobile: compact dropdown menu in AppBar.
// // //
// // // DO NOT put page-specific logic here.
// // // =================================

// // import 'package:flutter/material.dart';
// // import 'package:go_router/go_router.dart';

// // class AppShell extends StatelessWidget {
// //   final Widget child;
// //   const AppShell({super.key, required this.child});

// //   @override
// //   Widget build(BuildContext context) {
// //     final currentRoute = GoRouterState.of(context).uri.toString();

// //     return LayoutBuilder(
// //       builder: (context, constraints) {
// //         final isDesktop = constraints.maxWidth >= 900;

// //         return Scaffold(
// //           appBar: AppBar(
// //             title: InkWell(
// //               onTap: () => context.go('/'),
// //               child: const Text('GBV Awareness'),
// //             ),
// //             centerTitle: false,
// //             // Desktop: show full nav bar
// //             // Mobile/Tablet: show dropdown menu
// //             actions: [
// //               if (isDesktop)
// //                 _DesktopNavBar(currentRoute: currentRoute)
// //               else
// //                 _MobileNavMenu(currentRoute: currentRoute),
// //               const SizedBox(width: 12),
// //             ],
// //           ),
// //           body: Column(
// //             children: [
// //               // Main content
// //               Expanded(
// //                 child: Container(
// //                   color: Colors.white,
// //                   child: child,
// //                 ),
// //               ),

// //               // Footer
// //               const _AppFooter(),
// //             ],
// //           ),
// //         );
// //       },
// //     );
// //   }
// // }

// // ///////////////////////////////////////////////////////////////////////////////
// // /// NAV CONFIG
// // ///////////////////////////////////////////////////////////////////////////////

// // class _NavItem {
// //   final String label;
// //   final String route;
// //   const _NavItem(this.label, this.route);
// // }

// // // Primary items for the top nav / dropdown
// // const List<_NavItem> _primaryNavItems = [
// //   _NavItem('Home', '/'),
// //   _NavItem('About', '/about'),
// //   _NavItem('Information Hub', '/info'),
// //   _NavItem('Product', '/product'),
// //   _NavItem('Support', '/support'),
// //   _NavItem('Contact', '/contact'),
// // ];

// // ///////////////////////////////////////////////////////////////////////////////
// // /// DESKTOP NAV BAR
// // ///////////////////////////////////////////////////////////////////////////////

// // class _DesktopNavBar extends StatelessWidget {
// //   final String currentRoute;
// //   const _DesktopNavBar({required this.currentRoute});

// //   bool _isSelected(_NavItem item) {
// //     // Highlight even if on a sub-route, e.g. /info/blog/123
// //     if (currentRoute == item.route) return true;
// //     if (item.route == '/') return currentRoute == '/';
// //     return currentRoute.startsWith('${item.route}/');
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Row(
// //       mainAxisSize: MainAxisSize.min,
// //       children: [
// //         for (final item in _primaryNavItems)
// //           Padding(
// //             padding: const EdgeInsets.symmetric(horizontal: 4.0),
// //             child: TextButton(
// //               onPressed: () {
// //                 if (!_isSelected(item)) {
// //                   context.go(item.route);
// //                 }
// //               },
// //               style: TextButton.styleFrom(
// //                 foregroundColor:
// //                     _isSelected(item) ? Theme.of(context).colorScheme.primary : null,
// //               ),
// //               child: Text(item.label),
// //             ),
// //           ),
// //       ],
// //     );
// //   }
// // }

// // ///////////////////////////////////////////////////////////////////////////////
// // /// MOBILE/TABLET DROPDOWN MENU
// // ///////////////////////////////////////////////////////////////////////////////

// // class _MobileNavMenu extends StatelessWidget {
// //   final String currentRoute;
// //   const _MobileNavMenu({required this.currentRoute});

// //   bool _isSelected(_NavItem item) {
// //     if (currentRoute == item.route) return true;
// //     if (item.route == '/') return currentRoute == '/';
// //     return currentRoute.startsWith('${item.route}/');
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return PopupMenuButton<_NavItem>(
// //       icon: const Icon(Icons.menu),
// //       onSelected: (item) {
// //         context.go(item.route);
// //       },
// //       itemBuilder: (context) {
// //         return _primaryNavItems.map((item) {
// //           final selected = _isSelected(item);
// //           return PopupMenuItem<_NavItem>(
// //             value: item,
// //             child: Row(
// //               children: [
// //                 if (selected)
// //                   const Icon(Icons.check, size: 16)
// //                 else
// //                   const SizedBox(width: 16),
// //                 const SizedBox(width: 8),
// //                 Text(item.label),
// //               ],
// //             ),
// //           );
// //         }).toList();
// //       },
// //     );
// //   }
// // }

// // ///////////////////////////////////////////////////////////////////////////////
// // /// FOOTER
// // ///////////////////////////////////////////////////////////////////////////////

// // class _AppFooter extends StatelessWidget {
// //   const _AppFooter();

// //   @override
// //   Widget build(BuildContext context) {
// //     return Container(
// //       width: double.infinity,
// //       color: Colors.deepPurple.shade600,
// //       padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
// //       child: LayoutBuilder(
// //         builder: (context, constraints) {
// //           final isWide = constraints.maxWidth > 600;

// //           return Column(
// //             crossAxisAlignment:
// //                 isWide ? CrossAxisAlignment.start : CrossAxisAlignment.center,
// //             children: [
// //               // Top footer row
// //               if (isWide)
// //                 Row(
// //                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
// //                   children: [
// //                     _footerLeftContent(context),
// //                     _footerRightContent(context),
// //                   ],
// //                 )
// //               else ...[
// //                 _footerLeftContent(context),
// //                 const SizedBox(height: 12),
// //                 _footerRightContent(context),
// //               ],

// //               const SizedBox(height: 8),

// //               // Bottom copyright text
// //               const Center(
// //                 child: Text(
// //                   "© 2025 GBV Awareness Project — All rights reserved",
// //                   style: TextStyle(
// //                     fontSize: 12,
// //                     color: Colors.white70,
// //                   ),
// //                 ),
// //               )
// //             ],
// //           );
// //         },
// //       ),
// //     );
// //   }

// //   Widget _footerLeftContent(BuildContext context) {
// //     return const Text(
// //       "GBV Awareness Initiative\nProviding help, education, and support.",
// //       style: TextStyle(
// //         color: Colors.white,
// //         fontSize: 14,
// //         height: 1.4,
// //       ),
// //     );
// //   }

// //   Widget _footerRightContent(BuildContext context) {
// //     return const Row(
// //       children: [
// //         Icon(Icons.facebook, color: Colors.white70),
// //         SizedBox(width: 12),
// //         Icon(Icons.linked_camera, color: Colors.white70),
// //         SizedBox(width: 12),
// //         Icon(Icons.mail, color: Colors.white70),
// //       ],
// //     );
// //   }
// // }

// // ================================================
// // app_shell.dart — Scroll-aware App Shell (SliverAppBar + Footer)
// // ================================================
// // Integration:
// // - Replace your existing AppShell with this file.
// // - Ensure app_router.dart wraps routes in:
// //     ShellRoute(builder: (context, state, child) => AppShell(child: child))
// // - The file uses SelectionArea so text inside pages is selectable on web.
// // - For external social links it uses `dart:html` to open new tabs (web only).
// //
// // Notes:
// // - Replace placeholder logo widget, contact details and social URLs later.
// // - If you need mobile external-link support later, swap to `url_launcher` +
// //   conditional imports (this file currently targets Flutter Web).
// // ================================================

// import 'dart:ui' show window; // used for scroll physics fallback
// import 'dart:html' as html; // only for web (project targets web)
// import 'package:flutter/foundation.dart' show kIsWeb;
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// class AppShell extends StatefulWidget {
//   final Widget child;
//   const AppShell({super.key, required this.child});

//   @override
//   State<AppShell> createState() => _AppShellState();
// }

// class _AppShellState extends State<AppShell> {
//   // Scroll controller used by CustomScrollView to detect scroll direction/position
//   late final ScrollController _scrollController;

//   // Track whether the SliverAppBar should be visible; SliverAppBar with floating+snap
//   // will already show/hide on scroll, but we use this for extra control if needed.
//   bool _showAppBar = true;

//   @override
//   void initState() {
//     super.initState();
//     _scrollController = ScrollController()..addListener(_onScroll);
//   }

//   @override
//   void dispose() {
//     _scrollController.removeListener(_onScroll);
//     _scrollController.dispose();
//     super.dispose();
//   }

//   // Detect scroll direction and update state if needed.
//   // This isn't strictly required for SliverAppBar floating behavior,
//   // but it's useful if you want to animate other widgets on scroll.
//   double _lastOffset = 0;
//   void _onScroll() {
//     final offset = _scrollController.offset;
//     // Simple thresholded direction detection
//     if (offset > _lastOffset + 8 && _showAppBar) {
//       // scrolling down -> hide appbar (we let SliverAppBar handle it)
//       setState(() => _showAppBar = false);
//     } else if (offset < _lastOffset - 8 && !_showAppBar) {
//       // scrolling up -> show appbar
//       setState(() => _showAppBar = true);
//     }
//     _lastOffset = offset;
//   }

//   // Helper to open external url in new tab (web)
//   void _openExternal(String url) {
//     if (kIsWeb) {
//       try {
//         html.window.open(url, '_blank');
//       } catch (_) {
//         // ignore errors on malformed urls
//       }
//     } else {
//       // Non-web: no-op — replace with url_launcher if needed
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     final currentRoute = GoRouterState.of(context).uri.toString();
//     final theme = Theme.of(context);
//     final isDesktop = MediaQuery.of(context).size.width >= 900;

//     return Scaffold(
//       // We intentionally DO NOT use the AppBar property on Scaffold.
//       // Instead the app bar is a SliverAppBar inside the CustomScrollView
//       // so it can collapse/expand with scroll.
//       body: SelectionArea(
//         // makes all descendant text selectable on the web
//         child: CustomScrollView(
//           controller: _scrollController,
//           physics: const BouncingScrollPhysics(),
//           slivers: [
//             // ===== NAV BAR (SliverAppBar) =====
//             SliverAppBar(
//               // floating: appears when user scrolls up slightly
//               floating: true,
//               // snap: when user lifts finger, snap to visible appbar
//               snap: true,
//               // expandedHeight: shows a taller header on top of content (optional)
//               expandedHeight: isDesktop ? 120 : 80,
//               backgroundColor: theme.colorScheme.primary,
//               foregroundColor: theme.colorScheme.onPrimary,
//               elevation: 2,
//               pinned: false, // not fixed
//               automaticallyImplyLeading: false,
//               flexibleSpace: LayoutBuilder(
//                 builder: (context, constraints) {
//                   // collapsed height detection
//                   final collapsed = constraints.biggest.height <= 80;

//                   return FlexibleSpaceBar(
//                     titlePadding: const EdgeInsets.symmetric(
//                       horizontal: 16,
//                       vertical: 8,
//                     ),
//                     title: Row(
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         // Placeholder logo — replace asset later
//                         InkWell(
//                           onTap: () => context.go('/'),
//                           child: Row(
//                             children: [
//                               // circular placeholder logo
//                               Container(
//                                 width: 40,
//                                 height: 40,
//                                 decoration: BoxDecoration(
//                                   color: theme.colorScheme.onPrimary
//                                       .withOpacity(0.08),
//                                   shape: BoxShape.circle,
//                                 ),
//                                 child: Center(
//                                   child: Text(
//                                     'L',
//                                     style: TextStyle(
//                                       fontFamily: 'Montserrat',
//                                       fontWeight: FontWeight.w700,
//                                       color: theme.colorScheme.onPrimary,
//                                     ),
//                                   ),
//                                 ),
//                               ),
//                               const SizedBox(width: 12),
//                               // Title — use Montserrat style from theme
//                               Text(
//                                 'GBV Awareness',
//                                 style: theme.textTheme.titleLarge?.copyWith(
//                                   color: theme.colorScheme.onPrimary,
//                                   fontFamily: 'Montserrat',
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ),

//                         const Spacer(),

//                         // Desktop inline nav or mobile menu icon
//                         if (isDesktop) ...[
//                           _DesktopNavRow(
//                             currentRoute: currentRoute,
//                             onNav: (route) => context.go(route),
//                           ),
//                           const SizedBox(width: 16),
//                           _NeedHelpButton(onTap: () => context.go('/support')),
//                         ] else ...[
//                           // Mobile: menu icon + need help icon
//                           IconButton(
//                             tooltip: 'Menu',
//                             icon: const Icon(Icons.menu),
//                             onPressed: () => _openNavDrawer(context),
//                           ),
//                           IconButton(
//                             tooltip: 'Need Help',
//                             onPressed: () => context.go('/support'),
//                             icon: Icon(
//                               Icons.help_outline,
//                               color: theme.colorScheme.onPrimary,
//                             ),
//                           ),
//                         ],
//                       ],
//                     ),
//                   );
//                 },
//               ),
//             ),

//             // ===== BODY SLOT (embedded page) =====
//             // We want each page to be wrapped in padding and be scrollable inside the sliver flow.
//             SliverToBoxAdapter(
//               child: Container(
//                 color: theme
//                     .colorScheme
//                     .surface, // use surface for page background
//                 child: SafeArea(
//                   top: false,
//                   child: Padding(
//                     padding: const EdgeInsets.symmetric(
//                       horizontal: 24,
//                       vertical: 20,
//                     ),
//                     // Place the page's widget here; allow it to size naturally.
//                     child: widget.child,
//                   ),
//                 ),
//               ),
//             ),

//             // Additional spacer so footer isn't glued to content
//             SliverToBoxAdapter(child: const SizedBox(height: 32)),

//             // ===== FOOTER (part of scroll content) =====
//             SliverToBoxAdapter(
//               child: _Footer(
//                 onOpenExternal: _openExternal,
//                 onNavigate: (route) => context.go(route),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Open a Drawer for small screens
//   void _openNavDrawer(BuildContext context) {
//     showModalBottomSheet(
//       context: context,
//       isScrollControlled: true,
//       builder: (ctx) => SafeArea(
//         child: _MobileDrawer(
//           onNavigate: (route) {
//             Navigator.of(ctx).pop();
//             context.go(route);
//           },
//         ),
//       ),
//     );
//   }
// }

// ///////////////////////////////////////////////////////////////////////////////
// /// NAV ITEMS (kept in one place so nav and footer can reuse them)
// ///////////////////////////////////////////////////////////////////////////////
// class NavItem {
//   final String label;
//   final String route;
//   const NavItem(this.label, this.route);
// }

// const List<NavItem> navItems = [
//   NavItem('Home', '/'),
//   NavItem('About', '/about'),
//   NavItem('Resources', '/resources'), // adjust route if you use /info
//   NavItem('Stories', '/stories'), // placeholder
//   NavItem('Support', '/support'),
//   NavItem('Contact', '/contact'),
// ];

// ///////////////////////////////////////////////////////////////////////////////
// /// DESKTOP NAV ROW (inline buttons)
// ///////////////////////////////////////////////////////////////////////////////
// class _DesktopNavRow extends StatelessWidget {
//   final String currentRoute;
//   final void Function(String route) onNav;
//   const _DesktopNavRow({required this.currentRoute, required this.onNav});

//   bool _isSelected(String route) {
//     if (route == '/') return currentRoute == '/';
//     return currentRoute == route || currentRoute.startsWith('$route/');
//   }

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Row(
//       children: navItems.map((item) {
//         final selected = _isSelected(item.route);
//         return Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 6.0),
//           child: TextButton(
//             onPressed: () => onNav(item.route),
//             style: TextButton.styleFrom(
//               foregroundColor: selected
//                   ? theme.colorScheme.primary
//                   : theme.colorScheme.onPrimary,
//               padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
//               backgroundColor: selected
//                   ? theme.colorScheme.onPrimary.withOpacity(0.08)
//                   : Colors.transparent,
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(12),
//               ),
//               textStyle: const TextStyle(
//                 fontFamily: 'OpenSans',
//                 fontSize: 15,
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//             child: Text(item.label),
//           ),
//         );
//       }).toList(),
//     );
//   }
// }

// ///////////////////////////////////////////////////////////////////////////////
// /// MOBILE DRAWER (bottom sheet style)
// ///////////////////////////////////////////////////////////////////////////////
// class _MobileDrawer extends StatelessWidget {
//   final void Function(String route) onNavigate;
//   const _MobileDrawer({required this.onNavigate});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     return Container(
//       padding: const EdgeInsets.symmetric(vertical: 18, horizontal: 12),
//       color: theme.colorScheme.surface,
//       child: Column(
//         mainAxisSize: MainAxisSize.min,
//         children: [
//           // Logo + close
//           Row(
//             children: [
//               // small logo placeholder
//               Container(
//                 width: 40,
//                 height: 40,
//                 decoration: BoxDecoration(
//                   color: theme.colorScheme.primary.withOpacity(0.1),
//                   shape: BoxShape.circle,
//                 ),
//                 child: Center(
//                   child: Text('L', style: TextStyle(fontFamily: 'Montserrat')),
//                 ),
//               ),
//               const SizedBox(width: 12),
//               Text(
//                 'GBV Awareness',
//                 style: theme.textTheme.titleLarge?.copyWith(
//                   fontFamily: 'Montserrat',
//                 ),
//               ),
//               const Spacer(),
//               IconButton(
//                 onPressed: () => Navigator.of(context).pop(),
//                 icon: const Icon(Icons.close),
//               ),
//             ],
//           ),
//           const SizedBox(height: 12),

//           // Nav items
//           ...navItems.map(
//             (item) => ListTile(
//               title: Text(
//                 item.label,
//                 style: const TextStyle(fontFamily: 'OpenSans'),
//               ),
//               onTap: () => onNavigate(item.route),
//             ),
//           ),

//           const SizedBox(height: 8),

//           // Need Help CTA
//           ElevatedButton(
//             onPressed: () => onNavigate('/support'),
//             style: ElevatedButton.styleFrom(
//               shape: RoundedRectangleBorder(
//                 borderRadius: BorderRadius.circular(14),
//               ),
//               padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
//             ),
//             child: const Text(
//               'Need Help',
//               style: TextStyle(
//                 fontFamily: 'Montserrat',
//                 fontWeight: FontWeight.w600,
//               ),
//             ),
//           ),

//           const SizedBox(height: 16),
//         ],
//       ),
//     );
//   }
// }

// ///////////////////////////////////////////////////////////////////////////////
// /// NEED HELP CTA (Deep Rose)
// ///////////////////////////////////////////////////////////////////////////////
// class _NeedHelpButton extends StatelessWidget {
//   final VoidCallback onTap;
//   const _NeedHelpButton({required this.onTap});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     // Use color from colorScheme.tertiary if defined as CTA, otherwise fallback.
//     final ctaColor = theme.colorScheme.tertiary ?? const Color(0xFFC2185B);

//     return ElevatedButton(
//       onPressed: onTap,
//       style: ElevatedButton.styleFrom(
//         backgroundColor: ctaColor,
//         foregroundColor: theme.colorScheme.onTertiary ?? Colors.white,
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//         shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
//         elevation: 2,
//       ),
//       child: const Text(
//         'Need Help',
//         style: TextStyle(fontFamily: 'Montserrat', fontWeight: FontWeight.w700),
//       ),
//     );
//   }
// }

// ///////////////////////////////////////////////////////////////////////////////
// /// FOOTER WIDGET (part of scroll content)
// ///////////////////////////////////////////////////////////////////////////////
// class _Footer extends StatelessWidget {
//   final void Function(String url) onOpenExternal;
//   final void Function(String route) onNavigate;
//   const _Footer({required this.onOpenExternal, required this.onNavigate});

//   @override
//   Widget build(BuildContext context) {
//     final theme = Theme.of(context);
//     final isWide = MediaQuery.of(context).size.width > 800;

//     return Container(
//       width: double.infinity,
//       color: theme.colorScheme.primary,
//       padding: const EdgeInsets.symmetric(vertical: 28, horizontal: 28),
//       child: ConstrainedBox(
//         constraints: const BoxConstraints(maxWidth: 1200),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             // Top row: Contact | Quick Links | Social + CTA (responsive)
//             if (isWide)
//               Row(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Expanded(flex: 3, child: _contactBlock(context)),
//                   Expanded(flex: 2, child: _quickLinksBlock(context)),
//                   Expanded(flex: 2, child: _socialAndCtaBlock(context)),
//                 ],
//               )
//             else
//               Column(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 children: [
//                   _contactBlock(context),
//                   const SizedBox(height: 16),
//                   _quickLinksBlock(context),
//                   const SizedBox(height: 16),
//                   _socialAndCtaBlock(context),
//                 ],
//               ),

//             const SizedBox(height: 20),
//             // bottom row: privacy/terms and copyright
//             Row(
//               mainAxisAlignment: MainAxisAlignment.spaceBetween,
//               children: [
//                 Row(
//                   children: [
//                     TextButton(
//                       onPressed: () => onNavigate('/privacy'),
//                       child: const SelectableText(
//                         'Privacy Policy',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                     const SizedBox(width: 12),
//                     TextButton(
//                       onPressed: () => onNavigate('/terms'),
//                       child: const SelectableText(
//                         'Terms',
//                         style: TextStyle(color: Colors.white),
//                       ),
//                     ),
//                   ],
//                 ),
//                 Text(
//                   '© ${DateTime.now().year} GBV Awareness Project — All rights reserved',
//                   style: const TextStyle(color: Colors.white70, fontSize: 12),
//                 ),
//               ],
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   // Contact block with placeholder address/email/phone
//   Widget _contactBlock(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: const [
//         SelectableText(
//           'Contact Us',
//           style: TextStyle(
//             fontFamily: 'Montserrat',
//             fontSize: 18,
//             color: Colors.white,
//           ),
//         ),
//         SizedBox(height: 8),
//         SelectableText(
//           '123 Awareness Ave,\nCity, Country',
//           style: TextStyle(color: Colors.white70),
//         ),
//         SizedBox(height: 6),
//         SelectableText(
//           'help@gbv-awareness.org',
//           style: TextStyle(color: Colors.white70),
//         ),
//         SizedBox(height: 6),
//         SelectableText(
//           '+27 11 000 0000',
//           style: TextStyle(color: Colors.white70),
//         ),
//       ],
//     );
//   }

//   // Quick links mirror main nav
//   Widget _quickLinksBlock(BuildContext context) {
//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: navItems.map((item) {
//         return TextButton(
//           onPressed: () => onNavigate(item.route),
//           child: SelectableText(
//             item.label,
//             style: const TextStyle(color: Colors.white),
//           ),
//         );
//       }).toList(),
//     );
//   }

//   // Social icons + CTA
//   Widget _socialAndCtaBlock(BuildContext context) {
//     final theme = Theme.of(context);
//     final iconColor = Colors.white;
//     // placeholder URLs (replace later)
//     const instagram = 'https://instagram.com/placeholder';
//     const facebook = 'https://facebook.com/placeholder';
//     const xTwitter = 'https://twitter.com/placeholder';
//     const youtube = 'https://youtube.com/placeholder';

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.end,
//       children: [
//         Row(
//           mainAxisAlignment: MainAxisAlignment.end,
//           children: [
//             _socialIconButton(
//               icon: Icons.camera_alt,
//               onTap: () => onOpenExternal(instagram),
//               color: iconColor,
//             ),
//             const SizedBox(width: 12),
//             _socialIconButton(
//               icon: Icons.facebook,
//               onTap: () => onOpenExternal(facebook),
//               color: iconColor,
//             ),
//             const SizedBox(width: 12),
//             _socialIconButton(
//               icon: Icons.alternate_email,
//               onTap: () => onOpenExternal(xTwitter),
//               color: iconColor,
//             ),
//             const SizedBox(width: 12),
//             _socialIconButton(
//               icon: Icons.play_circle_fill,
//               onTap: () => onOpenExternal(youtube),
//               color: iconColor,
//             ),
//           ],
//         ),
//         const SizedBox(height: 12),
//         ElevatedButton(
//           onPressed: () => onNavigate('/support'),
//           style: ElevatedButton.styleFrom(
//             backgroundColor:
//                 theme.colorScheme.tertiary ?? const Color(0xFFC2185B),
//             foregroundColor: theme.colorScheme.onTertiary ?? Colors.white,
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadius.circular(14),
//             ),
//             padding: const EdgeInsets.symmetric(horizontal: 22, vertical: 12),
//             elevation: 4,
//           ),
//           child: const Text(
//             'Need Help',
//             style: TextStyle(
//               fontFamily: 'Montserrat',
//               fontWeight: FontWeight.w700,
//             ),
//           ),
//         ),
//       ],
//     );
//   }

//   Widget _socialIconButton({
//     required IconData icon,
//     required VoidCallback onTap,
//     required Color color,
//   }) {
//     return InkWell(
//       onTap: onTap,
//       borderRadius: BorderRadius.circular(8),
//       child: Ink(
//         padding: const EdgeInsets.all(8),
//         decoration: BoxDecoration(borderRadius: BorderRadius.circular(8)),
//         child: Icon(icon, color: color),
//       ),
//     );
//   }
// }

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

    return Scaffold(
      drawer: _MobileDrawer(currentRoute: currentRoute),
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
          // PAGE CONTENT (SELECTABLE)
          // --------------------------------------------------
          SliverToBoxAdapter(
            child: SelectionArea(
              child: Padding(
                padding: const EdgeInsets.only(top: 16),
                child: widget.child,
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
    final isDesktop = MediaQuery.of(context).size.width >= 900;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Row(
        children: [
          InkWell(
            onTap: () => context.go('/'),
            child: Row(
              children: [
                // Logo placeholder
                Container(
                  width: 42,
                  height: 42,
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(.15),
                    borderRadius: BorderRadius.circular(8),
                  ),
                ),
                const SizedBox(width: 12),
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
                    padding: const EdgeInsets.symmetric(horizontal: 8),
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
