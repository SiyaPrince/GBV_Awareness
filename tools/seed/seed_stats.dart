// // tools/seed/seed_stats.dart
// //
// // Seed script for inserting StatMetric (metrics) and MetricPoint (metricData)
// // into Firestore from JSON assets.
// //
// // Run with:
// // flutter run -t tools/seed/seed_stats.dart -d chrome
// // flutter run -t tools/seed/seed_stats.dart -d windows
// //
// // Or via Dart (if configured):
// // dart run tools/seed/seed_stats.dart

// import 'dart:convert';
// import 'dart:io' show File;

// import 'package:flutter/foundation.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart' show rootBundle;

// import 'package:firebase_core/firebase_core.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// import 'package:gbv_awareness/firebase_options.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   final firestore = FirebaseFirestore.instance;

//   const metricsPath = 'assets/seed/metrics.json';
//   const metricDataPath = 'assets/seed/metricData.json';

//   print('Loading StatMetric data from $metricsPath ...');
//   final metrics = await _loadMetricsFromPath(metricsPath);

//   print('Loading MetricPoint data from $metricDataPath ...');
//   final metricPoints = await _loadMetricPointsFromPath(metricDataPath);

//   print('Seeding "metrics" collection with ${metrics.length} items...');
//   await _seedMetricsCollection(firestore, metrics);

//   print('Seeding "metricData" collection with ${metricPoints.length} items...');
//   await _seedMetricDataCollection(firestore, metricPoints);

//   print('✅ Stats seeding completed.');
// }

// Future<String> _loadJsonString(String path) async {
//   if (kIsWeb) {
//     // Web: always use assets
//     return await rootBundle.loadString(path);
//   } else {
//     // Desktop/mobile/CLI: use file system if present, otherwise fall back to assets
//     final file = File(path);
//     if (await file.exists()) {
//       return await file.readAsString();
//     }
//     return await rootBundle.loadString(path);
//   }
// }

// Future<List<StatMetricSeed>> _loadMetricsFromPath(String path) async {
//   final jsonString = await _loadJsonString(path);
//   final dynamic decoded = jsonDecode(jsonString);

//   if (decoded is! List) {
//     throw Exception('metrics.json must contain a JSON array: $path');
//   }

//   return decoded
//       .map<StatMetricSeed>(
//         (item) => StatMetricSeed.fromJson(item as Map<String, dynamic>),
//       )
//       .toList();
// }

// Future<List<MetricPointSeed>> _loadMetricPointsFromPath(String path) async {
//   final jsonString = await _loadJsonString(path);
//   final dynamic decoded = jsonDecode(jsonString);

//   if (decoded is! List) {
//     throw Exception('metricData.json must contain a JSON array: $path');
//   }

//   return decoded
//       .map<MetricPointSeed>(
//         (item) => MetricPointSeed.fromJson(item as Map<String, dynamic>),
//       )
//       .toList();
// }

// Future<void> _seedMetricsCollection(
//   FirebaseFirestore firestore,
//   List<StatMetricSeed> items,
// ) async {
//   for (final metric in items) {
//     final docRef = firestore.collection('metrics').doc(metric.id);

//     final snapshot = await docRef.get();
//     if (snapshot.exists) {
//       print('[metrics] Skipping existing metric: ${metric.id}');
//       continue;
//     }

//     await docRef.set(metric.toMap());
//     print('[metrics] Seeded metric: ${metric.id} (${metric.title})');
//   }
// }

// Future<void> _seedMetricDataCollection(
//   FirebaseFirestore firestore,
//   List<MetricPointSeed> items,
// ) async {
//   for (final point in items) {
//     // Use a composite id for metricData so multiple points per metric are possible
//     final docId =
//         '${point.metricId}_${point.timestamp.toIso8601String().replaceAll(':', '-')}';
//     final docRef = firestore.collection('metricData').doc(docId);

//     final snapshot = await docRef.get();
//     if (snapshot.exists) {
//       print('[metricData] Skipping existing metric point: $docId');
//       continue;
//     }

//     await docRef.set(point.toMap());
//     print('[metricData] Seeded metric point: $docId (${point.metricId})');
//   }
// }

// // ---------------------------------------------------------------------------
// // Seed models
// // ---------------------------------------------------------------------------

// class StatMetricSeed {
//   final String id;
//   final String title;
//   final String shortLabel;
//   final String description;
//   final String type; // timeseries, snapshot, ratio, percentage
//   final String unit;
//   final String frequency;
//   final String sourceName;
//   final String sourceUrl;
//   final String category;
//   final List<String> tags;
//   final String chartType; // line, bar, none
//   final bool isSensitive;
//   final String interpretationHint;
//   final String warningText;
//   final num? minExpected;
//   final num? maxExpected;
//   final int priority;

//   StatMetricSeed({
//     required this.id,
//     required this.title,
//     required this.shortLabel,
//     required this.description,
//     required this.type,
//     required this.unit,
//     required this.frequency,
//     required this.sourceName,
//     required this.sourceUrl,
//     required this.category,
//     required this.tags,
//     required this.chartType,
//     required this.isSensitive,
//     required this.interpretationHint,
//     required this.warningText,
//     required this.minExpected,
//     required this.maxExpected,
//     required this.priority,
//   });

//   factory StatMetricSeed.fromJson(Map<String, dynamic> json) {
//     final tagsDynamic = json['tags'] as List<dynamic>? ?? <dynamic>[];
//     final tags = tagsDynamic.map((e) => e.toString()).toList();

//     return StatMetricSeed(
//       id: json['id']?.toString() ?? '',
//       title: json['title']?.toString() ?? '',
//       shortLabel: json['shortLabel']?.toString() ?? '',
//       description: json['description']?.toString() ?? '',
//       type: json['type']?.toString() ?? 'timeseries',
//       unit: json['unit']?.toString() ?? '',
//       frequency: json['frequency']?.toString() ?? '',
//       sourceName: json['sourceName']?.toString() ?? '',
//       sourceUrl: json['sourceUrl']?.toString() ?? '',
//       category: json['category']?.toString() ?? '',
//       tags: tags,
//       chartType: json['chartType']?.toString() ?? 'none',
//       isSensitive: (json['isSensitive'] ?? false) as bool,
//       interpretationHint: json['interpretationHint']?.toString() ?? '',
//       warningText: json['warningText']?.toString() ?? '',
//       minExpected: json['minExpected'] as num?,
//       maxExpected: json['maxExpected'] as num?,
//       priority: (json['priority'] ?? 0) as int,
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'id': id,
//       'title': title,
//       'shortLabel': shortLabel,
//       'description': description,
//       'type': type,
//       'unit': unit,
//       'frequency': frequency,
//       'sourceName': sourceName,
//       'sourceUrl': sourceUrl,
//       'category': category,
//       'tags': tags,
//       'chartType': chartType,
//       'isSensitive': isSensitive,
//       'interpretationHint': interpretationHint,
//       'warningText': warningText,
//       'minExpected': minExpected,
//       'maxExpected': maxExpected,
//       'priority': priority,
//     };
//   }
// }

// class MetricPointSeed {
//   final String metricId;
//   final DateTime timestamp;
//   final num value;
//   final String? region;
//   final Map<String, dynamic>? breakdown;
//   final String? notes;

//   MetricPointSeed({
//     required this.metricId,
//     required this.timestamp,
//     required this.value,
//     this.region,
//     this.breakdown,
//     this.notes,
//   });

//   factory MetricPointSeed.fromJson(Map<String, dynamic> json) {
//     final tsRaw = json['timestamp'] as String?;
//     if (tsRaw == null) {
//       throw Exception('Missing "timestamp" for metricId: ${json['metricId']}');
//     }

//     return MetricPointSeed(
//       metricId: json['metricId']?.toString() ?? '',
//       timestamp: DateTime.parse(tsRaw),
//       value: json['value'] as num,
//       region: json['region']?.toString(),
//       breakdown: json['breakdown'] != null
//           ? Map<String, dynamic>.from(json['breakdown'] as Map)
//           : null,
//       notes: json['notes']?.toString(),
//     );
//   }

//   Map<String, dynamic> toMap() {
//     return {
//       'metricId': metricId,
//       'timestamp': Timestamp.fromDate(timestamp),
//       'value': value,
//       'region': region,
//       'breakdown': breakdown,
//       'notes': notes,
//     };
//   }
// }

// tools/seed/seed_stats.dart
//
// Seed script for inserting StatMetric (metrics) and MetricPoint (metricData)
// into Firestore from JSON assets, using nested structure:
//
// /stats/{metricId}
// /stats/{metricId}/metricData/{pointId}
//
// Run with:
// flutter run -t tools/seed/seed_stats.dart -d chrome
// flutter run -t tools/seed/seed_stats.dart -d windows
//
// Or via Dart (if configured):
// dart run tools/seed/seed_stats.dart

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

  const metricsPath = 'assets/seed/metrics.json';
  const metricDataPath = 'assets/seed/metricData.json';

  print('Loading StatMetric data from $metricsPath ...');
  final metrics = await _loadMetricsFromPath(metricsPath);

  print('Loading MetricPoint data from $metricDataPath ...');
  final metricPoints = await _loadMetricPointsFromPath(metricDataPath);

  print('Seeding "metrics" collection with ${metrics.length} items...');
  await _seedMetricsCollection(firestore, metrics);

  print(
    'Seeding nested "metricData" subcollections with ${metricPoints.length} items...',
  );
  await _seedMetricDataSubcollections(firestore, metricPoints);

  print('✅ Stats seeding completed.');
}

Future<String> _loadJsonString(String path) async {
  if (kIsWeb) {
    // Web: always use assets
    return await rootBundle.loadString(path);
  } else {
    // Desktop/mobile/CLI: use file system if present, otherwise fall back to assets
    final file = File(path);
    if (await file.exists()) {
      return await file.readAsString();
    }
    return await rootBundle.loadString(path);
  }
}

Future<List<StatMetricSeed>> _loadMetricsFromPath(String path) async {
  final jsonString = await _loadJsonString(path);
  final dynamic decoded = jsonDecode(jsonString);

  if (decoded is! List) {
    throw Exception('metrics.json must contain a JSON array: $path');
  }

  return decoded
      .map<StatMetricSeed>(
        (item) => StatMetricSeed.fromJson(item as Map<String, dynamic>),
      )
      .toList();
}

Future<List<MetricPointSeed>> _loadMetricPointsFromPath(String path) async {
  final jsonString = await _loadJsonString(path);
  final dynamic decoded = jsonDecode(jsonString);

  if (decoded is! List) {
    throw Exception('metricData.json must contain a JSON array: $path');
  }

  return decoded
      .map<MetricPointSeed>(
        (item) => MetricPointSeed.fromJson(item as Map<String, dynamic>),
      )
      .toList();
}

Future<void> _seedMetricsCollection(
  FirebaseFirestore firestore,
  List<StatMetricSeed> items,
) async {
  for (final metric in items) {
    final docRef = firestore.collection('stats').doc(metric.id);

    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print('[metrics] Skipping existing metric: ${metric.id}');
      continue;
    }

    await docRef.set(metric.toMap());
    print('[metrics] Seeded metric: ${metric.id} (${metric.title})');
  }
}

Future<void> _seedMetricDataSubcollections(
  FirebaseFirestore firestore,
  List<MetricPointSeed> items,
) async {
  for (final point in items) {
    final parentMetricId = point.metricId;

    // Use timestamp-based docId for uniqueness per metric
    final docId = point.timestamp.toIso8601String().replaceAll(':', '-');

    final docRef = firestore
        .collection('stats')
        .doc(parentMetricId)
        .collection('metricData')
        .doc(docId);

    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print(
        '[metricData] Skipping existing metric point: $parentMetricId/$docId',
      );
      continue;
    }

    await docRef.set(point.toMap());
    print('[metricData] Seeded metric point under $parentMetricId: $docId');
  }
}

// ---------------------------------------------------------------------------
// Seed models
// ---------------------------------------------------------------------------

class StatMetricSeed {
  final String id;
  final String title;
  final String shortLabel;
  final String description;
  final String type; // timeseries, snapshot, ratio, percentage
  final String unit;
  final String frequency;
  final String sourceName;
  final String sourceUrl;
  final String category;
  final List<String> tags;
  final String chartType; // line, bar, none
  final bool isSensitive;
  final String interpretationHint;
  final String warningText;
  final num? minExpected;
  final num? maxExpected;
  final int priority;

  StatMetricSeed({
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

  factory StatMetricSeed.fromJson(Map<String, dynamic> json) {
    final tagsDynamic = json['tags'] as List<dynamic>? ?? <dynamic>[];
    final tags = tagsDynamic.map((e) => e.toString()).toList();

    return StatMetricSeed(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      shortLabel: json['shortLabel']?.toString() ?? '',
      description: json['description']?.toString() ?? '',
      type: json['type']?.toString() ?? 'timeseries',
      unit: json['unit']?.toString() ?? '',
      frequency: json['frequency']?.toString() ?? '',
      sourceName: json['sourceName']?.toString() ?? '',
      sourceUrl: json['sourceUrl']?.toString() ?? '',
      category: json['category']?.toString() ?? '',
      tags: tags,
      chartType: json['chartType']?.toString() ?? 'none',
      isSensitive: (json['isSensitive'] ?? false) as bool,
      interpretationHint: json['interpretationHint']?.toString() ?? '',
      warningText: json['warningText']?.toString() ?? '',
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

class MetricPointSeed {
  final String metricId;
  final DateTime timestamp;
  final num value;
  final String? region;
  final Map<String, dynamic>? breakdown;
  final String? notes;

  MetricPointSeed({
    required this.metricId,
    required this.timestamp,
    required this.value,
    this.region,
    this.breakdown,
    this.notes,
  });

  factory MetricPointSeed.fromJson(Map<String, dynamic> json) {
    final tsRaw = json['timestamp'] as String?;
    if (tsRaw == null) {
      throw Exception('Missing "timestamp" for metricId: ${json['metricId']}');
    }

    return MetricPointSeed(
      metricId: json['metricId']?.toString() ?? '',
      timestamp: DateTime.parse(tsRaw),
      value: json['value'] as num,
      region: json['region']?.toString(),
      breakdown: json['breakdown'] != null
          ? Map<String, dynamic>.from(json['breakdown'] as Map)
          : null,
      notes: json['notes']?.toString(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'metricId': metricId,
      'timestamp': Timestamp.fromDate(timestamp),
      'value': value,
      'region': region,
      'breakdown': breakdown,
      'notes': notes,
    };
  }
}
