// tools/seed/seed_stats.dart
//
// Seed script for inserting StatMetric definitions into Firestore.
//
// Run with:
// flutter run -t tools/seed/seed_stats.dart
//
// Or (if configured for pure Dart execution):
// dart run tools/seed/seed_stats.dart

import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// 👇 Replace `your_app_name` with your actual app package name
import 'package:gbv_awareness/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestore = FirebaseFirestore.instance;

  const statsPath = 'assets/seed/statistics.json';

  print('Loading StatMetric seed data from $statsPath ...');
  final metrics = await _loadStatsFromAssets(statsPath);

  print(
    'Seeding "stats" collection with ${metrics.length} metric definitions...',
  );
  await _seedStatsCollection(firestore, metrics);

  print('✅ StatMetric seeding completed.');
}

Future<List<StatMetric>> _loadStatsFromAssets(String assetPath) async {
  final jsonString = await rootBundle.loadString(assetPath);

  final dynamic decoded = jsonDecode(jsonString);
  if (decoded is! List) {
    throw Exception('Seed file must contain a JSON array: $assetPath');
  }

  return decoded
      .map<StatMetric>(
        (item) => StatMetric.fromJson(item as Map<String, dynamic>),
      )
      .toList();
}

Future<void> _seedStatsCollection(
  FirebaseFirestore firestore,
  List<StatMetric> items,
) async {
  for (final metric in items) {
    final docRef = firestore.collection('stats').doc(metric.id);

    // Avoid duplicate entries by checking if the document already exists.
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print('[stats] Skipping existing metric definition: ${metric.id}');
      continue;
    }

    await docRef.set(metric.toMap());
    print('[stats] Seeded metric definition: ${metric.id} (${metric.title})');
  }
}

///
/// StatMetric model
///
/// Mirrors the structure stored in Firestore and in `stats.json`:
///
/// id
/// title
/// shortLabel
/// description
/// type
/// unit
/// frequency
/// sourceName
/// sourceUrl
/// category
/// tags
/// chartType
/// isSensitive
/// interpretationHint
/// warningText
/// minExpected
/// maxExpected
/// priority
///
class StatMetric {
  final String id;
  final String title;
  final String shortLabel;
  final String description;
  final String type; // e.g. timeseries, snapshot, ratio, percentage
  final String unit;
  final String frequency;
  final String sourceName;
  final String sourceUrl;
  final String category;
  final List<String> tags;
  final String chartType; // e.g. line, bar, none
  final bool isSensitive;
  final String interpretationHint;
  final String warningText;
  final num? minExpected;
  final num? maxExpected;
  final int priority;

  StatMetric({
    required this.id,
    required this.title,
    required this.shortLabel,
    required this.description,
    required this.type,
    required this.unit,
    required this.frequency,
    required this.sourceName,
    required this.sourceUrl,
    required this.category,
    required this.tags,
    required this.chartType,
    required this.isSensitive,
    required this.interpretationHint,
    required this.warningText,
    required this.minExpected,
    required this.maxExpected,
    required this.priority,
  });

  factory StatMetric.fromJson(Map<String, dynamic> json) {
    final tagsDynamic = json['tags'] as List<dynamic>? ?? <dynamic>[];
    final tags = tagsDynamic.map((e) => e.toString()).toList();

    return StatMetric(
      id: json['id'] as String,
      title: json['title'] as String,
      shortLabel: (json['shortLabel'] ?? '') as String,
      description: (json['description'] ?? '') as String,
      type: (json['type'] ?? 'snapshot') as String,
      unit: (json['unit'] ?? '') as String,
      frequency: (json['frequency'] ?? '') as String,
      sourceName: (json['sourceName'] ?? '') as String,
      sourceUrl: (json['sourceUrl'] ?? '') as String,
      category: (json['category'] ?? '') as String,
      tags: tags,
      chartType: (json['chartType'] ?? 'none') as String,
      isSensitive: (json['isSensitive'] ?? false) as bool,
      interpretationHint: (json['interpretationHint'] ?? '') as String,
      warningText: (json['warningText'] ?? '') as String,
      minExpected: json['minExpected'] as num?,
      maxExpected: json['maxExpected'] as num?,
      priority: (json['priority'] ?? 0) as int,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'shortLabel': shortLabel,
      'description': description,
      'type': type,
      'unit': unit,
      'frequency': frequency,
      'sourceName': sourceName,
      'sourceUrl': sourceUrl,
      'category': category,
      'tags': tags,
      'chartType': chartType,
      'isSensitive': isSensitive,
      'interpretationHint': interpretationHint,
      'warningText': warningText,
      'minExpected': minExpected,
      'maxExpected': maxExpected,
      'priority': priority,
    };
  }
}
