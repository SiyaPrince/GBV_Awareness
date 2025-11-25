// lib/common/models/testimonial.dart
import 'package:flutter/foundation.dart';

@immutable
class Testimonial {
  final String id;
  final String quote;
  final String name;
  final String? role;
  final String? organisation;
  final String? avatarUrl;
  final int order;
  final bool isFeatured;
  final int? rating;

  const Testimonial({
    required this.id,
    required this.quote,
    required this.name,
    this.role,
    this.organisation,
    this.avatarUrl,
    this.order = 0,
    this.isFeatured = false,
    this.rating,
  });

  factory Testimonial.fromMap(String id, Map<String, dynamic> data) {
    return Testimonial(
      id: id,
      quote: data['quote'] as String? ?? '',
      name: data['name'] as String? ?? '',
      role: data['role'] as String?,
      organisation: data['organisation'] as String?,
      avatarUrl: data['avatarUrl'] as String?,
      order: (data['order'] as num?)?.toInt() ?? 0,
      isFeatured: data['isFeatured'] as bool? ?? false,
      rating: (data['rating'] as num?)?.toInt(),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'quote': quote,
      'name': name,
      'role': role,
      'organisation': organisation,
      'avatarUrl': avatarUrl,
      'order': order,
      'isFeatured': isFeatured,
      'rating': rating,
    };
  }
}
