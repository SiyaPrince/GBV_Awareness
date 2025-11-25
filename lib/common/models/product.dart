import 'package:flutter/foundation.dart';

@immutable
class Product {
  final String id;
  final String name;
  final String slug;
  final String shortDescription;
  final String longDescription;
  final String? icon;
  final String? heroImageUrl;
  final List<String> pillars;
  final String? ctaLabel;
  final String? ctaUrl;
  final bool isFeatured;
  final int order;

  const Product({
    required this.id,
    required this.name,
    required this.slug,
    required this.shortDescription,
    required this.longDescription,
    this.icon,
    this.heroImageUrl,
    this.pillars = const [],
    this.ctaLabel,
    this.ctaUrl,
    this.isFeatured = false,
    this.order = 0,
  });

  factory Product.fromMap(String id, Map<String, dynamic> data) {
    final rawPillars = data['pillars'];

    return Product(
      id: id,
      name: data['name'] as String? ?? '',
      slug: data['slug'] as String? ?? id,
      shortDescription: data['shortDescription'] as String? ?? '',
      longDescription: data['longDescription'] as String? ?? '',
      icon: data['icon'] as String?,
      heroImageUrl: data['heroImageUrl'] as String?,
      pillars: rawPillars is List
          ? rawPillars.whereType<String>().toList()
          : const [],
      ctaLabel: data['ctaLabel'] as String?,
      ctaUrl: data['ctaUrl'] as String?,
      isFeatured: data['isFeatured'] as bool? ?? false,
      order: (data['order'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'slug': slug,
      'shortDescription': shortDescription,
      'longDescription': longDescription,
      'icon': icon,
      'heroImageUrl': heroImageUrl,
      'pillars': pillars,
      'ctaLabel': ctaLabel,
      'ctaUrl': ctaUrl,
      'isFeatured': isFeatured,
      'order': order,
    };
  }
}
