// =================================
// app_router.dart — Integration Guide
// =================================
// PURPOSE:
// - Defines all navigation routes for the app.
// - Uses go_router for declarative and URL-based navigation.
// - Wraps all pages in AppShell via a ShellRoute.
//
// YOU WILL MODIFY THIS FILE WHEN:
// - Adding new feature pages.
// - Adding auth guards, redirects, or protected routes.
// - Adding nested shells (admin vs user layouts).
//
// DO NOT add UI code here — this file is for routing only.
// =================================

import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'features/home/home_page.dart';
import 'features/about/about_page.dart';

// INFO SECTION
import 'features/info/information_hub_page.dart';
import 'features/info/blog_list_page.dart';
import 'features/info/blog_detail_page.dart';
import 'features/info/article_list_page.dart';
import 'features/info/article_detail_page.dart';
import 'features/info/dashboard_page.dart';

// PRODUCT SECTION
import 'features/product/product_overview_page.dart';
import 'features/product/features_page.dart';
import 'features/product/how_it_works_page.dart';
import 'features/product/testimonials_page.dart';
import 'features/product/faq_page.dart';

// SUPPORT + CONTACT
import 'features/support/support_page.dart';
import 'features/contact/contact_page.dart';

// LEGAL
import 'features/legal/privacy_policy_page.dart';
import 'features/legal/terms_page.dart';

import 'common/widgets/app_shell.dart';

final appRouter = GoRouter(
  initialLocation: '/', // First page on app startup
  routes: [
    // ShellRoute gives all children the same AppShell layout
    ShellRoute(
      builder: (context, state, child) => AppShell(child: child),
      routes: [
        // -------------------------
        // CORE / TOP-LEVEL
        // -------------------------
        GoRoute(
          path: '/',
          builder: (context, state) => const HomePage(),
        ),
        GoRoute(
          path: '/about',
          builder: (context, state) => const AboutPage(),
        ),

        // -------------------------
        // INFORMATION HUB
        // -------------------------
        // Landing hub page (summary + links to blog/articles/dashboard)
        GoRoute(
          path: '/info',
          builder: (context, state) => const InformationHubPage(),
        ),

        GoRoute(
          path: '/info/blog',
          builder: (context, state) => const BlogListPage(),
        ),
        GoRoute(
          path: '/info/blog/:id',
          builder: (context, state) =>
              BlogDetailPage(id: state.pathParameters['id']!),
        ),

        GoRoute(
          path: '/info/articles',
          builder: (context, state) => const ArticleListPage(),
        ),
        GoRoute(
          path: '/info/articles/:id',
          builder: (context, state) =>
              ArticleDetailPage(id: state.pathParameters['id']!),
        ),

        GoRoute(
          path: '/info/dashboard',
          builder: (context, state) => const DashboardPage(),
        ),

        // -------------------------
        // PRODUCT SECTION
        // -------------------------
        GoRoute(
          path: '/product',
          builder: (context, state) => const ProductOverviewPage(),
        ),
        GoRoute(
          path: '/product/features',
          builder: (context, state) => const FeaturesPage(),
        ),
        GoRoute(
          path: '/product/how-it-works',
          builder: (context, state) => const HowItWorksPage(),
        ),
        GoRoute(
          path: '/product/testimonials',
          builder: (context, state) => const TestimonialsPage(),
        ),
        GoRoute(
          path: '/product/faq',
          builder: (context, state) => const FAQPage(),
        ),

        // -------------------------
        // SUPPORT + CONTACT
        // -------------------------
        GoRoute(
          path: '/support',
          builder: (context, state) => const SupportPage(),
        ),
        GoRoute(
          path: '/contact',
          builder: (context, state) => const ContactPage(),
        ),

        // -------------------------
        // LEGAL
        // -------------------------
        GoRoute(
          path: '/privacy',
          builder: (context, state) => const PrivacyPolicyPage(),
        ),
        GoRoute(
          path: '/terms',
          builder: (context, state) => const TermsPage(),
        ),
      ],
    ),
  ],
);
