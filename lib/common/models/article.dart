class Article {
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

  Article({
    required this.id,
    required this.title,
    required this.slug,
    required this.type,
    required this.summary,
    required this.body,
    required this.tags,
    required this.publishedAt,
    this.featured = false,
    this.imageUrl,
    this.author,
  });

  factory Article.fromMap(Map<String, dynamic> data) {
    return Article(
      id: data['id'] ?? '',
      title: data['title'] ?? '',
      slug: data['slug'] ?? '',
      type: data['type'] ?? 'article',
      summary: data['summary'] ?? '',
      body: data['body'] ?? '',
      tags: List<String>.from(data['tags'] ?? []),
      publishedAt: data['publishedAt']?.toDate() ?? DateTime.now(),
      featured: data['featured'] ?? false,
      imageUrl: data['imageUrl'],
      author: data['author'],
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
      'publishedAt': publishedAt,
      'featured': featured,
      'imageUrl': imageUrl,
      'author': author,
    };
  }
}
