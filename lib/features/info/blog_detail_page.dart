import 'package:flutter/material.dart';

class BlogDetailPage extends StatelessWidget {
  final String id;
  const BlogDetailPage({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Center(child: Text("Blog Detail Page — ID: $id"));
  }
}
