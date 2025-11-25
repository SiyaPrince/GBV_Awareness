// lib/features/product/faq_body.dart

import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/faq_item.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';
import 'package:gbv_awareness/common/widgets/page_section.dart';

class ProductFaqBody extends StatelessWidget {
  final List<FaqItem> items;

  const ProductFaqBody({
    super.key,
    required this.items,
  });

  @override
  Widget build(BuildContext context) {
    final sorted = [...items]..sort((a, b) => a.order.compareTo(b.order));
    final grouped = _groupByCategory(sorted);

    return AppPage(
      title: "Frequently Asked Questions",
      subtitle:
          "Answers to common questions about using the GBV support platform.",
      children: [
        for (final entry in grouped.entries)
          Padding(
            padding: const EdgeInsets.only(bottom: 24),
            child: PageSection(
              title: entry.key,
              subtitle: null,
              child: _FaqCategoryList(items: entry.value),
            ),
          ),
      ],
    );
  }

  Map<String, List<FaqItem>> _groupByCategory(List<FaqItem> items) {
    final map = <String, List<FaqItem>>{};
    for (final item in items) {
      final key = item.category?.trim().isNotEmpty == true
          ? item.category!.trim()
          : 'General';
      map.putIfAbsent(key, () => []).add(item);
    }
    return map;
  }
}

class _FaqCategoryList extends StatelessWidget {
  final List<FaqItem> items;

  const _FaqCategoryList({required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        for (final item in items)
          Card(
            margin: const EdgeInsets.symmetric(vertical: 4),
            child: ExpansionTile(
              title: Text(
                item.question,
                style: const TextStyle(fontWeight: FontWeight.w600),
              ),
              childrenPadding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    item.answer,
                    style: const TextStyle(fontSize: 14, height: 1.4),
                  ),
                ),
                const SizedBox(height: 8),
              ],
            ),
          ),
      ],
    );
  }
}
