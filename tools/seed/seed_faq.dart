// tools/seed/seed_faq.dart
//
// Seed script for inserting FAQ items into Firestore.
//
// Run with:
// flutter run -t tools/seed/seed_faq.dart
//
// Or via Dart:
// dart run tools/seed/seed_faq.dart

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

  const faqPath = 'assets/seed/faq.json';

  print('Loading FAQ data from $faqPath ...');
  final faqItems = await _loadFaqFromAssets(faqPath);

  print('Seeding "faq" collection with ${faqItems.length} item(s)...');
  await _seedFaqCollection(firestore, faqItems);

  print('✅ FAQ seeding completed.');
}

Future<List<FaqSeed>> _loadFaqFromAssets(String assetPath) async {
  final jsonString = await rootBundle.loadString(assetPath);
  final dynamic decoded = jsonDecode(jsonString);

  if (decoded is! List) {
    throw Exception('FAQ seed file must contain a JSON array: $assetPath');
  }

  return decoded
      .map<FaqSeed>((item) => FaqSeed.fromJson(item as Map<String, dynamic>))
      .toList();
}

Future<void> _seedFaqCollection(
  FirebaseFirestore firestore,
  List<FaqSeed> items,
) async {
  for (final faq in items) {
    final docRef = firestore.collection('faq').doc(faq.id);

    // Optional: avoid duplicates
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print('[faq] Skipping existing FAQ item: ${faq.id}');
      continue;
    }

    await docRef.set(faq.toMap());
    print('[faq] Seeded FAQ item: ${faq.id}');
  }
}

class FaqSeed {
  final String id;
  final String question;
  final String answer;
  final String category;
  final num order;

  FaqSeed({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
    required this.order,
  });

  factory FaqSeed.fromJson(Map<String, dynamic> json) {
    return FaqSeed(
      id: json['id'] as String,
      question: json['question'] as String,
      answer: json['answer'] as String,
      category: json['category'] as String,
      order: json['order'] as num,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'question': question,
      'answer': answer,
      'category': category,
      'order': order,
    };
  }
}
