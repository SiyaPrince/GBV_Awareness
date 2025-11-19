// tools/seed/seed_articles.dart
//
// Seed script for inserting articles and blog posts into Firestore.
//
// Run with (example):
// flutter run -t tools/seed/seed_articles.dart -d chrome
// or (desktop):
// flutter run -t tools/seed/seed_articles.dart -d windows

import 'dart:convert';
import 'dart:io' show File; // Only used on non-web platforms

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// 👇 Replace `your_app_name` with your actual app package name
import 'package:gbv_awareness/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ✅ Use explicit options so web works
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestore = FirebaseFirestore.instance;

  // Logical asset paths
  const articlesPath = 'assets/seed/articles.json';
  const blogPostsPath = 'assets/seed/blogPosts.json';

  final articles = await _loadItemsFromPath(articlesPath);
  final blogPosts = await _loadItemsFromPath(blogPostsPath);

  print('Seeding "articles" collection...');
  await _seedCollection(firestore, 'articles', articles);

  print('Seeding "blogPosts" collection...');
  await _seedCollection(firestore, 'blogPosts', blogPosts);

  print('Seeding completed.');
}

/// Load JSON either from assets (web) or filesystem (non-web)
Future<List<ArticleSeed>> _loadItemsFromPath(String path) async {
  String jsonString;

  if (kIsWeb) {
    // ✅ Web: load from Flutter assets
    jsonString = await rootBundle.loadString(path);
  } else {
    // ✅ Desktop/mobile/CLI: load from file system
    final file = File(path);
    if (!await file.exists()) {
      throw Exception('Seed file not found: $path');
    }
    jsonString = await file.readAsString();
  }

  final dynamic decoded = jsonDecode(jsonString);

  if (decoded is! List) {
    throw Exception('Seed file must contain a JSON array: $path');
  }

  return decoded
      .map<ArticleSeed>(
        (item) => ArticleSeed.fromJson(item as Map<String, dynamic>),
      )
      .toList();
}

Future<void> _seedCollection(
  FirebaseFirestore firestore,
  String collectionPath,
  List<ArticleSeed> items,
) async {
  for (final item in items) {
    final docRef = firestore.collection(collectionPath).doc(item.id);

    // Optional: prevent duplicate writes
    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print('[$collectionPath] Skipping existing document: ${item.id}');
      continue;
    }

    await docRef.set(item.toMap());
    print('[$collectionPath] Seeded document: ${item.id}');
  }
}

class ArticleSeed {
  final String id;
  final String title;
  final String? subtitle;
  final String content;
  final String? imageUrl;
  final List<String> tags;
  final String category;
  final String author;
  final DateTime publishedAt;
  final DateTime? updatedAt;
  final num readTime;
  final bool isFeatured;

  ArticleSeed({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.content,
    required this.imageUrl,
    required this.tags,
    required this.category,
    required this.author,
    required this.publishedAt,
    required this.updatedAt,
    required this.readTime,
    required this.isFeatured,
  });

  factory ArticleSeed.fromJson(Map<String, dynamic> json) {
    final tagsDynamic = json['tags'] as List<dynamic>? ?? <dynamic>[];
    final tags = tagsDynamic.map((e) => e.toString()).toList();

    final publishedAtRaw = json['publishedAt'] as String?;
    if (publishedAtRaw == null) {
      throw Exception('Missing "publishedAt" for id: ${json['id']}');
    }

    final updatedAtRaw = json['updatedAt'] as String?;

    return ArticleSeed(
      id: json['id'] as String,
      title: json['title'] as String,
      subtitle: json['subtitle'] as String?,
      content: json['content'] as String,
      imageUrl: json['imageUrl'] as String?,
      tags: tags,
      category: json['category'] as String,
      author: json['author'] as String,
      publishedAt: DateTime.parse(publishedAtRaw),
      updatedAt: updatedAtRaw != null ? DateTime.parse(updatedAtRaw) : null,
      readTime: json['readTime'] as num,
      isFeatured: json['isFeatured'] as bool,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'subtitle': subtitle,
      'content': content,
      'imageUrl': imageUrl,
      'tags': tags,
      'category': category,
      'author': author,
      'publishedAt': Timestamp.fromDate(publishedAt),
      'updatedAt': updatedAt != null ? Timestamp.fromDate(updatedAt!) : null,
      'readTime': readTime,
      'isFeatured': isFeatured,
    };
  }
}
