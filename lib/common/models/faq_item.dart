// lib/common/models/faq_item.dart
import 'package:flutter/foundation.dart';

@immutable
class FaqItem {
  final String id;
  final String question;
  final String answer;
  final String? category;
  final int order;
  final bool isHighlighted;

  const FaqItem({
    required this.id,
    required this.question,
    required this.answer,
    this.category,
    this.order = 0,
    this.isHighlighted = false,
  });

  factory FaqItem.fromMap(String id, Map<String, dynamic> data) {
    return FaqItem(
      id: id,
      question: data['question'] as String? ?? '',
      answer: data['answer'] as String? ?? '',
      category: data['category'] as String?,
      order: (data['order'] as num?)?.toInt() ?? 0,
      isHighlighted: data['isHighlighted'] as bool? ?? false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'question': question,
      'answer': answer,
      'category': category,
      'order': order,
      'isHighlighted': isHighlighted,
    };
  }
}
