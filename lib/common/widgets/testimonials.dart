import 'package:flutter/material.dart';
import 'app_card.dart';

class TestimonialCard extends StatelessWidget {
  final String quote;
  final String attribution;
  final String? roleTag;

  const TestimonialCard({
    super.key,
    required this.quote,
    required this.attribution,
    this.roleTag,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AppCard(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '“$quote”',
            style: theme.textTheme.bodyLarge,
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                attribution,
                style: theme.textTheme.bodyMedium?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              if (roleTag != null) ...[
                const SizedBox(width: 8),
                Text(
                  '• $roleTag',
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ],
          ),
        ],
      ),
    );
  }
}
