import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/article.dart';

/// Service instance provider
final contentServiceProvider = Provider<ContentService>(
  (ref) => ContentService(),
);

/// Shared tags stream – used by all pages
final tagsStreamProvider = StreamProvider.autoDispose<List<String>>((ref) {
  final service = ref.watch(contentServiceProvider);
  return service.getAllTags();
});

/// Shared articles stream – raw list of "article" type content
final articlesStreamProvider = StreamProvider.autoDispose<List<Article>>((ref) {
  final service = ref.watch(contentServiceProvider);
  return service.getArticles();
});

/// Shared blogs stream – raw list of "blog" type content
final blogPostsStreamProvider = StreamProvider.autoDispose<List<Article>>((
  ref,
) {
  final service = ref.watch(contentServiceProvider);
  return service.getBlogPosts();
});

class ContentService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all blog posts (no composite index needed)
  Stream<List<Article>> getBlogPosts() {
    return _firestore
        .collection('articles')
        .where('type', isEqualTo: 'blog')
        .snapshots()
        .map((snapshot) {
          final list = snapshot.docs
              .map((doc) => Article.fromMap(doc.data()))
              .toList();
          list.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
          return list;
        });
  }

  // Get all articles (no composite index needed)
  Stream<List<Article>> getArticles() {
    return _firestore
        .collection('articles')
        .where('type', isEqualTo: 'article')
        .snapshots()
        .map((snapshot) {
          final list = snapshot.docs
              .map((doc) => Article.fromMap(doc.data()))
              .toList();
          list.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
          return list;
        });
  }

  // Get featured content (no composite index needed)
  Stream<List<Article>> getFeaturedContent() {
    return _firestore
        .collection('articles')
        .where('featured', isEqualTo: true)
        .snapshots()
        .map((snapshot) {
          final list = snapshot.docs
              .map((doc) => Article.fromMap(doc.data()))
              .toList();
          list.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
          return list.take(5).toList();
        });
  }

  // Get article by ID
  Future<Article?> getArticleById(String id) async {
    try {
      final doc = await _firestore.collection('articles').doc(id).get();
      if (doc.exists) {
        return Article.fromMap(doc.data()!);
      }
      return null;
    } catch (_) {
      // Error is handled by the UI
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
    } catch (_) {
      // Error is handled by the UI
      return null;
    }
  }

  // Search articles and blogs (no composite orderBy; sort in Dart)
  Stream<List<Article>> searchContent(String query) {
    final lower = query.toLowerCase();
    return _firestore.collection('articles').snapshots().map((snapshot) {
      final list = snapshot.docs
          .map((doc) => Article.fromMap(doc.data()))
          .where((article) {
            return article.title.toLowerCase().contains(lower) ||
                article.summary.toLowerCase().contains(lower) ||
                article.tags.any((tag) => tag.toLowerCase().contains(lower));
          })
          .toList();
      list.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
      return list;
    });
  }

  // Get articles by tag (no composite index needed)
  Stream<List<Article>> getArticlesByTag(String tag) {
    return _firestore
        .collection('articles')
        .where('tags', arrayContains: tag)
        .snapshots()
        .map((snapshot) {
          final list = snapshot.docs
              .map((doc) => Article.fromMap(doc.data()))
              .toList();
          list.sort((a, b) => b.publishedAt.compareTo(a.publishedAt));
          return list;
        });
  }

  // Get all unique tags
  Stream<List<String>> getAllTags() {
    return _firestore.collection('articles').snapshots().map((snapshot) {
      final allTags = <String>{};
      for (final doc in snapshot.docs) {
        final tags = List<String>.from(doc.data()['tags'] ?? []);
        allTags.addAll(tags);
      }
      final list = allTags.toList();
      list.sort();
      return list;
    });
  }
}
