// ignore_for_file: avoid_print

// tools/seed/seed_testimonials.dart
//
// Seed script for inserting Testimonial docs into Firestore.
//
// Run with:
// flutter run -t tools/seed/seed_testimonials.dart -d chrome
// flutter run -t tools/seed/seed_testimonials.dart -d windows
//
// Or (if configured):
// dart run tools/seed/seed_testimonials.dart

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

  const testimonialsPath = 'assets/seed/testimonials.json';

  print('Loading testimonials from $testimonialsPath ...');
  final testimonials = await _loadTestimonialsFromPath(testimonialsPath);

  print(
    'Seeding "testimonials" collection with ${testimonials.length} items...',
  );
  await _seedTestimonialsCollection(firestore, testimonials);

  print('✅ Testimonial seeding completed.');
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

Future<List<TestimonialSeed>> _loadTestimonialsFromPath(String path) async {
  final jsonString = await _loadJsonString(path);
  final dynamic decoded = jsonDecode(jsonString);

  if (decoded is! List) {
    throw Exception('testimonials.json must contain a JSON array: $path');
  }

  return decoded
      .map<TestimonialSeed>(
        (item) => TestimonialSeed.fromJson(item as Map<String, dynamic>),
      )
      .toList();
}

Future<void> _seedTestimonialsCollection(
  FirebaseFirestore firestore,
  List<TestimonialSeed> items,
) async {
  for (final t in items) {
    final docRef = firestore.collection('testimonials').doc(t.id);

    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print('[testimonials] Skipping existing testimonial: ${t.id}');
      continue;
    }

    await docRef.set(t.toMap());
    print('[testimonials] Seeded testimonial: ${t.id}');
  }
}

class TestimonialSeed {
  final String id;
  final String quote;
  final String name;
  final String? role;
  final String? organisation;
  final String? avatarUrl;
  final int order;
  final bool isFeatured;
  final int? rating;

  TestimonialSeed({
    required this.id,
    required this.quote,
    required this.name,
    required this.role,
    required this.organisation,
    required this.avatarUrl,
    required this.order,
    required this.isFeatured,
    required this.rating,
  });

  factory TestimonialSeed.fromJson(Map<String, dynamic> json) {
    return TestimonialSeed(
      id: json['id']?.toString() ?? '',
      quote: json['quote']?.toString() ?? '',
      name: json['name']?.toString() ?? '',
      role: json['role']?.toString(),
      organisation: json['organisation']?.toString(),
      avatarUrl: json['avatarUrl']?.toString(),
      order: (json['order'] as num?)?.toInt() ?? 0,
      isFeatured: (json['isFeatured'] ?? false) as bool,
      rating: (json['rating'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quote': quote,
      'name': name,
      'role': role,
      'organisation': organisation,
      'avatarUrl': avatarUrl,
      'order': order,
      'isFeatured': isFeatured,
      'rating': rating,
    };
  }
}
