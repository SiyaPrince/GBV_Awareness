// tools/seed/seed_product.dart
//
// Seed script for inserting product documents into Firestore.
//
// Run with:
// flutter run -t tools/seed/seed_product.dart
//
// Or via Dart (if configured):
// dart run tools/seed/seed_product.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Replace `your_app_name` with your actual package name
import 'package:gbv_awareness/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestore = FirebaseFirestore.instance;

  const productPath = 'assets/seed/product.json';

  print('Loading product data from $productPath ...');
  final products = await _loadProductsFromAssets(productPath);

  print('Seeding "product" collection with ${products.length} document(s)...');
  await _seedProductCollection(firestore, products);

  print('✅ Product seeding completed.');
}

Future<List<ProductSeed>> _loadProductsFromAssets(String assetPath) async {
  final jsonString = await rootBundle.loadString(assetPath);
  final dynamic decoded = jsonDecode(jsonString);

  if (decoded is List) {
    return decoded
        .map<ProductSeed>(
          (item) => ProductSeed.fromJson(item as Map<String, dynamic>),
        )
        .toList();
  } else if (decoded is Map<String, dynamic>) {
    return [ProductSeed.fromJson(decoded)];
  } else {
    throw Exception('Unexpected JSON format in $assetPath');
  }
}

Future<void> _seedProductCollection(
  FirebaseFirestore firestore,
  List<ProductSeed> items,
) async {
  for (final product in items) {
    final docRef = firestore.collection('product').doc(product.id);

    // Optional: avoid duplicates
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print('[product] Skipping existing product: ${product.id}');
      continue;
    }

    await docRef.set(product.toMap());
    print('[product] Seeded product: ${product.id} (${product.name})');
  }
}

class ProductSeed {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final List<dynamic> features;
  final DateTime updatedAt;
  final dynamic version; // string or number

  ProductSeed({
    required this.id,
    required this.name,
    required this.description,
    required this.imageUrl,
    required this.features,
    required this.updatedAt,
    required this.version,
  });

  factory ProductSeed.fromJson(Map<String, dynamic> json) {
    final featuresDynamic = json['features'] as List<dynamic>? ?? <dynamic>[];

    final updatedAtRaw = json['updatedAt'] as String?;
    if (updatedAtRaw == null) {
      throw Exception('Missing "updatedAt" for product id: ${json['id']}');
    }

    return ProductSeed(
      id: json['id'] as String,
      name: json['name'] as String,
      description: json['description'] as String,
      imageUrl: json['imageUrl'] as String?,
      features: featuresDynamic,
      updatedAt: DateTime.parse(updatedAtRaw),
      version: json['version'],
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'features': features,
      'updatedAt': Timestamp.fromDate(updatedAt),
      'version': version,
    };
  }
}
