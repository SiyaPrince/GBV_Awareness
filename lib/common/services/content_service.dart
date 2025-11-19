import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/article.dart';

// Riverpod Provider for ContentService
final contentServiceProvider = Provider<ContentService>(
  (ref) => ContentService(),
);

class ContentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all blog posts
  Stream<List<Article>> getBlogPosts() {
    return _firestore
        .collection('articles')
        .where('type', isEqualTo: 'blog')
        .orderBy('publishedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Article.fromMap(doc.data())).toList(),
        );
  }

  // Get all articles
  Stream<List<Article>> getArticles() {
    return _firestore
        .collection('articles')
        .where('type', isEqualTo: 'article')
        .orderBy('publishedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Article.fromMap(doc.data())).toList(),
        );
  }

  // Get featured content
  Stream<List<Article>> getFeaturedContent() {
    return _firestore
        .collection('articles')
        .where('featured', isEqualTo: true)
        .orderBy('publishedAt', descending: true)
        .limit(5)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Article.fromMap(doc.data())).toList(),
        );
  }

  // Get article by ID
  Future<Article?> getArticleById(String id) async {
    try {
      final doc = await _firestore.collection('articles').doc(id).get();
      if (doc.exists) {
        return Article.fromMap(doc.data()!);
      }
      return null;
    } catch (e) {
      // Error is handled by the UI, no need to print
      return null;
    }
  }

  // Get article by slug
  Future<Article?> getArticleBySlug(String slug) async {
    try {
      final query = await _firestore
          .collection('articles')
          .where('slug', isEqualTo: slug)
          .limit(1)
          .get();

      if (query.docs.isNotEmpty) {
        return Article.fromMap(query.docs.first.data());
      }
      return null;
    } catch (e) {
      // Error is handled by the UI, no need to print
      return null;
    }
  }

  // Search articles and blogs
  Stream<List<Article>> searchContent(String query) {
    return _firestore
        .collection('articles')
        .orderBy('publishedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => Article.fromMap(doc.data()))
              .where(
                (article) =>
                    article.title.toLowerCase().contains(query.toLowerCase()) ||
                    article.summary.toLowerCase().contains(
                      query.toLowerCase(),
                    ) ||
                    article.tags.any(
                      (tag) => tag.toLowerCase().contains(query.toLowerCase()),
                    ),
              )
              .toList(),
        );
  }

  // Get articles by tag
  Stream<List<Article>> getArticlesByTag(String tag) {
    return _firestore
        .collection('articles')
        .where('tags', arrayContains: tag)
        .orderBy('publishedAt', descending: true)
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs.map((doc) => Article.fromMap(doc.data())).toList(),
        );
  }

  // Get all unique tags
  Stream<List<String>> getAllTags() {
    return _firestore.collection('articles').snapshots().map((snapshot) {
      final allTags = <String>{};
      for (final doc in snapshot.docs) {
        final tags = List<String>.from(doc.data()['tags'] ?? []);
        allTags.addAll(tags);
      }
      return allTags.toList()..sort();
    });
  }
}
