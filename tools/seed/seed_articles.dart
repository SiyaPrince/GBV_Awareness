// tools/seed/seed_articles.dart
//
// Seed script for inserting articles and blog posts into Firestore,
// using the current Article model.
//
// Run with (example):
// flutter run -t tools/seed/seed_articles.dart -d chrome
// or (desktop):
// flutter run -t tools/seed/seed_articles.dart -d windows

// ignore_for_file: avoid_print

import 'dart:convert';
import 'dart:io' show File; // Only used on non-web platforms

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

// Already set to your app package
import 'package:gbv_awareness/firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final firestore = FirebaseFirestore.instance;

  const articlesPath = 'assets/seed/articles.json';
  // const blogPostsPath = 'assets/seed/blogPosts.json';

  final articles = await _loadItemsFromPath(articlesPath);
  // final blogPosts = await _loadItemsFromPath(blogPostsPath);

  print('Seeding "articles" collection...');
  await _seedCollection(firestore, 'articles', articles);

  // print('Seeding "blogPosts" collection...');
  // await _seedCollection(firestore, 'blogPosts', blogPosts);

  print('✅ Seeding completed.');
}

/// Load JSON either from assets (web) or filesystem (non-web)
Future<List<ArticleSeed>> _loadItemsFromPath(String path) async {
  String jsonString;

  if (kIsWeb) {
    jsonString = await rootBundle.loadString(path);
  } else {
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

    final snapshot = await docRef.get();
    if (snapshot.exists) {
      print('[$collectionPath] Skipping existing document: ${item.id}');
      continue;
    }

    await docRef.set(item.toMap());
    print('[$collectionPath] Seeded document: ${item.id} (${item.type})');
  }
}

/// ArticleSeed model (matches your Article data model)
class ArticleSeed {
  final String id;
  final String title;
  final String slug;
  final String type; // "blog" or "article"
  final String summary;
  final String body;
  final List<String> tags;
  final DateTime publishedAt;
  final bool featured;
  final String? imageUrl;
  final String? author;

  ArticleSeed({
    required this.id,
    required this.title,
    required this.slug,
    required this.type,
    required this.summary,
    required this.body,
    required this.tags,
    required this.publishedAt,
    required this.featured,
    this.imageUrl,
    this.author,
  });

  factory ArticleSeed.fromJson(Map<String, dynamic> json) {
    final tagsDynamic = json['tags'] as List<dynamic>? ?? <dynamic>[];
    final tags = tagsDynamic.map((e) => e.toString()).toList();

    final publishedAtRaw = json['publishedAt'] as String?;
    if (publishedAtRaw == null) {
      throw Exception('Missing "publishedAt" for id: ${json['id']}');
    }

    // Defensive conversions: tolerate missing/nullable fields in JSON
    final id = json['id']?.toString() ?? '';
    final title = json['title']?.toString() ?? '';
    final slug =
        json['slug']?.toString() ??
        title
            .toLowerCase()
            .replaceAll(RegExp(r'[^a-z0-9]+'), '-')
            .replaceAll(RegExp(r'-+'), '-')
            .replaceAll(RegExp(r'^-|-$'), '');
    final type = json['type']?.toString() ?? 'article';
    final summary = json['summary']?.toString() ?? '';
    final body = json['body']?.toString() ?? '';
    final featured = (json['featured'] ?? false) as bool;
    final imageUrl = json['imageUrl']?.toString();
    final author = json['author']?.toString();

    return ArticleSeed(
      id: id,
      title: title,
      slug: slug,
      type: type,
      summary: summary,
      body: body,
      tags: tags,
      publishedAt: DateTime.parse(publishedAtRaw),
      featured: featured,
      imageUrl: imageUrl,
      author: author,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'slug': slug,
      'type': type,
      'summary': summary,
      'body': body,
      'tags': tags,
      'publishedAt': Timestamp.fromDate(publishedAt),
      'featured': featured,
      'imageUrl': imageUrl,
      'author': author,
    };
  }
}
