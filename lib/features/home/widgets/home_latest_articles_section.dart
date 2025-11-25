import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeLatestArticlesSection extends StatelessWidget {
  const HomeLatestArticlesSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    // Placeholder data. Later Dev B can replace this with a Firestore stream.
    const articles = [
      _ArticlePreview(
        id: "placeholder-1",
        title: "What is Gender-Based Violence?",
        summary:
            "A gentle introduction to what GBV is, how it shows up, and why language matters.",
        route: "/info/articles", // will be replaced with `/info/articles/:id`
      ),
      _ArticlePreview(
        id: "placeholder-2",
        title: "Recognising Early Warning Signs",
        summary:
            "Subtle behaviours that may indicate controlling or abusive patterns in relationships.",
        route: "/info/articles",
      ),
      _ArticlePreview(
        id: "placeholder-3",
        title: "How to Support a Friend",
        summary:
            "Simple, non-judgemental ways to support someone who shares that they are not safe.",
        route: "/info/blog",
      ),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "From the Information Hub",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: color.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "Short, clear pieces to help you understand GBV, know your options, "
          "and support others more safely.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 20),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return _ArticleCard(article: article);
          },
        ),
      ],
    );
  }
}

class _ArticlePreview {
  final String id;
  final String title;
  final String summary;
  final String route;

  const _ArticlePreview({
    required this.id,
    required this.title,
    required this.summary,
    required this.route,
  });
}

class _ArticleCard extends StatelessWidget {
  final _ArticlePreview article;

  const _ArticleCard({required this.article});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      elevation: 1,
      child: InkWell(
        onTap: () {
          // For now, just go to general route.
          // Later, Dev B can change this to `/info/articles/${article.id}` etc.
          context.go(article.route);
        },
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                article.title,
                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w700),
              ),
              const SizedBox(height: 8),
              Text(
                article.summary,
                maxLines: 3,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(height: 1.4),
              ),
              const SizedBox(height: 8),
              Text(
                "Read more →",
                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  color: color.primary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
