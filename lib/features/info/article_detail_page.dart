import 'package:flutter/material.dart';

class ArticleDetailPage extends StatelessWidget {
  final String id;
  const ArticleDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Article Detail Page — ID: $id"));
  }
}
