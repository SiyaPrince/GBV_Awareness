// ignore_for_file: avoid_print

// tools/seed/seed_faq_items.dart
//
// Seed script for inserting FaqItem docs into Firestore.
//
// Run with:
// flutter run -t tools/seed/seed_faq_items.dart -d chrome
// flutter run -t tools/seed/seed_faq_items.dart -d windows
//
// Or (if configured):
// dart run tools/seed/seed_faq_items.dart

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

  const faqPath = 'assets/seed/faqItems.json';

  print('Loading FAQ items from $faqPath ...');
  final faqItems = await _loadFaqFromPath(faqPath);

  print('Seeding "faqItems" collection with ${faqItems.length} items...');
  await _seedFaqCollection(firestore, faqItems);

  print('✅ FAQ seeding completed.');
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

Future<List<FaqSeed>> _loadFaqFromPath(String path) async {
  final jsonString = await _loadJsonString(path);
  final dynamic decoded = jsonDecode(jsonString);

  if (decoded is! List) {
    throw Exception('faqItems.json must contain a JSON array: $path');
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
    final docRef = firestore.collection('faqItems').doc(faq.id);

    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print('[faqItems] Skipping existing FAQ: ${faq.id}');
      continue;
    }

    await docRef.set(faq.toMap());
    print('[faqItems] Seeded FAQ item: ${faq.id}');
  }
}

class FaqSeed {
  final String id;
  final String question;
  final String answer;
  final String? category;
  final int order;
  final bool isHighlighted;

  FaqSeed({
    required this.id,
    required this.question,
    required this.answer,
    required this.category,
    required this.order,
    required this.isHighlighted,
  });

  factory FaqSeed.fromJson(Map<String, dynamic> json) {
    return FaqSeed(
      id: json['id']?.toString() ?? '',
      question: json['question']?.toString() ?? '',
      answer: json['answer']?.toString() ?? '',
      category: json['category']?.toString(),
      order: (json['order'] as num?)?.toInt() ?? 0,
      isHighlighted: (json['isHighlighted'] ?? false) as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      'category': category,
      'order': order,
      'isHighlighted': isHighlighted,
    };
  }
}
