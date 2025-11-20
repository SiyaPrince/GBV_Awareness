import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gbv_awareness/common/widgets/article_detail_content.dart';
import 'package:gbv_awareness/common/widgets/article_detail_error_widget.dart';
import 'package:go_router/go_router.dart';
import '../../../common/services/content_service.dart';
import '../../../common/models/article.dart';

class ArticleDetailPage extends ConsumerStatefulWidget {
  final String id;

  const ArticleDetailPage({super.key, required this.id});

  @override
  ConsumerState<ArticleDetailPage> createState() => _ArticleDetailPageState();
}

class _ArticleDetailPageState extends ConsumerState<ArticleDetailPage> {
  late Future<Article?> _articleFuture;

  @override
  void initState() {
    super.initState();
    _articleFuture = _loadArticle();
  }

  Future<Article?> _loadArticle() async {
    final service = ref.read(contentServiceProvider);
    return await service.getArticleById(widget.id);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Article?>(
      future: _articleFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasError || snapshot.data == null) {
          return ArticleDetailErrorWidget(onBack: () => context.go('/info'));
        }

        final article = snapshot.data!;
        return ArticleDetailContent(article: article);
      },
    );
  }
}
