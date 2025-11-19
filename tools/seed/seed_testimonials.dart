// tools/seed/seed_testimonials.dart
//
// Seed script for inserting testimonial documents into Firestore.
//
// Run with:
// flutter run -t tools/seed/seed_testimonials.dart
//
// Or via Dart:
// dart run tools/seed/seed_testimonials.dart

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

  const testimonialsPath = 'assets/seed/testimonials.json';

  print('Loading testimonials from $testimonialsPath ...');
  final testimonials = await _loadTestimonialsFromAssets(testimonialsPath);

  print(
    'Seeding "testimonials" collection with ${testimonials.length} item(s)...',
  );
  await _seedTestimonialsCollection(firestore, testimonials);

  print('✅ Testimonials seeding completed.');
}

Future<List<TestimonialSeed>> _loadTestimonialsFromAssets(
  String assetPath,
) async {
  final jsonString = await rootBundle.loadString(assetPath);
  final dynamic decoded = jsonDecode(jsonString);

  if (decoded is! List) {
    throw Exception(
      'Testimonials seed file must contain a JSON array: $assetPath',
    );
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
  for (final testimonial in items) {
    final docRef = firestore.collection('testimonials').doc(testimonial.id);

    // Optional: avoid duplicates
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print('[testimonials] Skipping existing testimonial: ${testimonial.id}');
      continue;
    }

    await docRef.set(testimonial.toMap());
    print(
      '[testimonials] Seeded testimonial: ${testimonial.id} (${testimonial.name})',
    );
  }
}

class TestimonialSeed {
  final String id;
  final String name;
  final String? role;
  final String message;
  final String? imageUrl;
  final num rating;
  final DateTime timestamp;

  TestimonialSeed({
    required this.id,
    required this.name,
    required this.role,
    required this.message,
    required this.imageUrl,
    required this.rating,
    required this.timestamp,
  });

  factory TestimonialSeed.fromJson(Map<String, dynamic> json) {
    final timestampRaw = json['timestamp'] as String?;
    if (timestampRaw == null) {
      throw Exception('Missing "timestamp" for testimonial id: ${json['id']}');
    }

    return TestimonialSeed(
      id: json['id'] as String,
      name: json['name'] as String,
      role: json['role'] as String?,
      message: json['message'] as String,
      imageUrl: json['imageUrl'] as String?,
      rating: json['rating'] as num,
      timestamp: DateTime.parse(timestampRaw),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'role': role,
      'message': message,
      'imageUrl': imageUrl,
      'rating': rating,
      'timestamp': Timestamp.fromDate(timestamp),
    };
  }
}
