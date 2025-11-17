// ============================
// main.dart — Integration Guide
// ============================
// PURPOSE:
// - Entry point of the app.
// - Initializes Flutter bindings and Firebase.
// - Sets up Riverpod's ProviderScope globally.
// - Bootstraps the router and global theme.
//
// YOU WILL MODIFY THIS FILE WHEN:
// - Adding analytics or crashlytics initialization.
// - Adding custom error handling for async bootstrapping.
// - Adding theme switching or localization.
//
// YOU SHOULD NOT PUT BUSINESS LOGIC HERE.
// ============================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'app_router.dart';
import 'theme/app_theme.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase for the platform (iOS/Android/Web)
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  // ProviderScope allows Riverpod providers to work everywhere
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'GBV Awareness',
      theme: AppTheme.light, // central theme file
      routerConfig: appRouter, // go_router configuration
    );
  }
}
