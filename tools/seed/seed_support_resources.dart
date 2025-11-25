// tools/seed/seed_support_resources.dart
//
// Seeder for inserting support resources into Firestore.
// Run with:
// flutter run -t tools/seed/seed_support_resources.dart
//
// ignore_for_file: avoid_print

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:gbv_awareness/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestore = FirebaseFirestore.instance;

  const seedFilePath = 'assets/seed/support_resources.json';

  print('Loading support resources from $seedFilePath ...');
  final items = await _loadSeedData(seedFilePath);

  print('Seeding support_resources collection with ${items.length} items...');
  await _seedSupportResources(firestore, items);

  print('✅ Support resources seeding completed.');
}

//
// ──────────────────────────────────────────────────────────────────────────
//   Load JSON Seed Data
// ──────────────────────────────────────────────────────────────────────────
//

Future<List<SupportResourceSeed>> _loadSeedData(String assetPath) async {
  final jsonString = await rootBundle.loadString(assetPath);

  final decoded = jsonDecode(jsonString);
  if (decoded is! List) {
    throw Exception('Seed file must contain a JSON array: $assetPath');
  }

  return decoded
      .map<SupportResourceSeed>(
        (item) => SupportResourceSeed.fromJson(item as Map<String, dynamic>),
      )
      .toList();
}

//
// ──────────────────────────────────────────────────────────────────────────
//   Insert into Firestore
// ──────────────────────────────────────────────────────────────────────────
//

Future<void> _seedSupportResources(
  FirebaseFirestore firestore,
  List<SupportResourceSeed> items,
) async {
  final collection = firestore.collection('support_resources');

  for (final item in items) {
    final docRef = collection.doc(item.id);

    final existing = await docRef.get();
    if (existing.exists) {
      print('[support_resources] Skipping existing: ${item.id}');
      continue;
    }

    await docRef.set(item.toMap());
    print('[support_resources] Inserted: ${item.id}');
  }
}

//
// ──────────────────────────────────────────────────────────────────────────
//   Seed Model (Matches SupportResource exactly)
// ──────────────────────────────────────────────────────────────────────────
//

class SupportResourceSeed {
  final String id;
  final String name;
  final String type;
  final String contact;
  final String region;
  final String hours;
  final String description;
  final bool isEmergency;
  final String url;

  SupportResourceSeed({
    required this.id,
    required this.name,
    required this.type,
    required this.contact,
    required this.region,
    required this.hours,
    required this.description,
    required this.isEmergency,
    required this.url,
  });

  /// SAFE JSON PARSER — No more "Null is not a subtype of String"
  factory SupportResourceSeed.fromJson(Map<String, dynamic> json) {
    return SupportResourceSeed(
      id: (json['id'] ?? '').toString(),
      name: (json['name'] ?? '').toString(),
      type: (json['type'] ?? '').toString(),
      contact: (json['contact'] ?? '').toString(),
      region: (json['region'] ?? '').toString(),
      hours: (json['hours'] ?? '').toString(),
      description: (json['description'] ?? '').toString(),
      isEmergency: json['isEmergency'] is bool
          ? json['isEmergency'] as bool
          : (json['isEmergency']?.toString().toLowerCase() == 'true'),
      url: (json['url'] ?? '').toString(),
    );
  }

  /// What gets written to Firestore
  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'type': type,
      'contact': contact,
      'region': region,
      'hours': hours,
      'description': description,
      'isEmergency': isEmergency,
      'url': url,
    };
  }
}
