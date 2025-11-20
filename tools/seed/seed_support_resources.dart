// tools/seed/seed_support_resources.dart
//
// Seed script for inserting support resources into Firestore.
//
// Run with:
// flutter run -t tools/seed/seed_support_resources.dart
//
// Or with Dart (if configured):
// dart run tools/seed/seed_support_resources.dart

// ignore_for_file: avoid_print

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

  const resourcesPath = 'assets/seed/support_resources.json';

  print('Loading support resources from $resourcesPath ...');
  final resources = await _loadSupportResourcesFromAssets(resourcesPath);

  print(
    'Seeding "support_resources" collection with ${resources.length} items...',
  );
  await _seedSupportResourcesCollection(firestore, resources);

  print('✅ Support resources seeding completed.');
}

Future<List<SupportResourceSeed>> _loadSupportResourcesFromAssets(
  String assetPath,
) async {
  final jsonString = await rootBundle.loadString(assetPath);

  final dynamic decoded = jsonDecode(jsonString);
  if (decoded is! List) {
    throw Exception('Seed file must contain a JSON array: $assetPath');
  }

  return decoded
      .map<SupportResourceSeed>(
        (item) => SupportResourceSeed.fromJson(item as Map<String, dynamic>),
      )
      .toList();
}

Future<void> _seedSupportResourcesCollection(
  FirebaseFirestore firestore,
  List<SupportResourceSeed> items,
) async {
  for (final resource in items) {
    final docRef = firestore.collection('support_resources').doc(resource.id);

    // Optional: skip duplicates on re-run
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print('[support_resources] Skipping existing resource: ${resource.id}');
      continue;
    }

    await docRef.set(resource.toMap());
    print(
      '[support_resources] Seeded resource: ${resource.id} (${resource.name})',
    );
  }
}

class SupportResourceSeed {
  final String id;
  final String name;
  final String type;
  final String description;
  final String? phone;
  final String? email;
  final String? website;
  final String? address;
  final String? availableHours;
  final num priority;
  final List<String> tags;

  SupportResourceSeed({
    required this.id,
    required this.name,
    required this.type,
    required this.description,
    required this.phone,
    required this.email,
    required this.website,
    required this.address,
    required this.availableHours,
    required this.priority,
    required this.tags,
  });

  factory SupportResourceSeed.fromJson(Map<String, dynamic> json) {
    final tagsDynamic = json['tags'] as List<dynamic>? ?? <dynamic>[];
    final tags = tagsDynamic.map((e) => e.toString()).toList();

    return SupportResourceSeed(
      id: json['id'] as String,
      name: json['name'] as String,
      type: json['type'] as String,
      description: json['description'] as String,
      phone: json['phone'] as String?,
      email: json['email'] as String?,
      website: json['website'] as String?,
      address: json['address'] as String?,
      availableHours: json['availableHours'] as String?,
      priority: json['priority'] as num,
      tags: tags,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'type': type,
      'description': description,
      'phone': phone,
      'email': email,
      'website': website,
      'address': address,
      'availableHours': availableHours,
      'priority': priority,
      'tags': tags,
    };
  }
}
