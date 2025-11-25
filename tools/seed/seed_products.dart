// ignore_for_file: avoid_print

// tools/seed/seed_products.dart
//
// Seed script for inserting Product docs into Firestore.
//
// Run with:
// flutter run -t tools/seed/seed_products.dart -d chrome
// flutter run -t tools/seed/seed_products.dart -d windows
//
// Or (if configured):
// dart run tools/seed/seed_products.dart

import 'dart:convert';
import 'dart:io' show File;

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gbv_awareness/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestore = FirebaseFirestore.instance;

  const productsPath = 'assets/seed/products.json';

  print('Loading products from $productsPath ...');
  final products = await _loadProductsFromPath(productsPath);

  print('Seeding "products" collection with ${products.length} items...');
  await _seedProductsCollection(firestore, products);

  print('✅ Product seeding completed.');
}

Future<String> _loadJsonString(String path) async {
  if (kIsWeb) {
    return await rootBundle.loadString(path);
  } else {
    final file = File(path);
    if (await file.exists()) {
      return await file.readAsString();
    }
    return await rootBundle.loadString(path);
  }
}

Future<List<ProductSeed>> _loadProductsFromPath(String path) async {
  final jsonString = await _loadJsonString(path);
  final dynamic decoded = jsonDecode(jsonString);

  if (decoded is! List) {
    throw Exception('products.json must contain a JSON array: $path');
  }

  return decoded
      .map<ProductSeed>(
        (item) => ProductSeed.fromJson(item as Map<String, dynamic>),
      )
      .toList();
}

Future<void> _seedProductsCollection(
  FirebaseFirestore firestore,
  List<ProductSeed> items,
) async {
  for (final product in items) {
    final docRef = firestore.collection('products').doc(product.id);

    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print('[products] Skipping existing product: ${product.id}');
      continue;
    }

    await docRef.set(product.toMap());
    print('[products] Seeded product: ${product.id} (${product.name})');
  }
}

class ProductSeed {
  final String id;
  final String name;
  final String slug;
  final String shortDescription;
  final String longDescription;
  final String? icon;
  final String? heroImageUrl;
  final List<String> pillars;
  final String? ctaLabel;
  final String? ctaUrl;
  final bool isFeatured;
  final int order;

  ProductSeed({
    required this.id,
    required this.name,
    required this.slug,
    required this.shortDescription,
    required this.longDescription,
    required this.icon,
    required this.heroImageUrl,
    required this.pillars,
    required this.ctaLabel,
    required this.ctaUrl,
    required this.isFeatured,
    required this.order,
  });

  factory ProductSeed.fromJson(Map<String, dynamic> json) {
    final rawPillars = json['pillars'];
    final pillars = rawPillars is List
        ? rawPillars.map((e) => e.toString()).toList()
        : <String>[];

    return ProductSeed(
      id: json['id']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      slug: json['slug']?.toString() ?? '',
      shortDescription: json['shortDescription']?.toString() ?? '',
      longDescription: json['longDescription']?.toString() ?? '',
      icon: json['icon']?.toString(),
      heroImageUrl: json['heroImageUrl']?.toString(),
      pillars: pillars,
      ctaLabel: json['ctaLabel']?.toString(),
      ctaUrl: json['ctaUrl']?.toString(),
      isFeatured: (json['isFeatured'] ?? false) as bool,
      order: (json['order'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'slug': slug,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'icon': icon,
      'heroImageUrl': heroImageUrl,
      'pillars': pillars,
      'ctaLabel': ctaLabel,
      'ctaUrl': ctaUrl,
      'isFeatured': isFeatured,
      'order': order,
    };
  }
}
