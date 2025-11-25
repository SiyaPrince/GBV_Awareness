import 'package:flutter/material.dart';

class ImportantNotice extends StatelessWidget {
  const ImportantNotice({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: colors.secondary.withAlpha((0.1 * 255).round()),
        borderRadius: BorderRadius.circular(8),
        border: Border.all(color: colors.secondary),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.info, color: colors.secondary),
              const SizedBox(width: 8),
              Text(
                "Important Information",
                style: textTheme.titleMedium?.copyWith(
                  color: colors.secondary,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          Text(
            "All services listed are confidential and free of charge. "
            "Shelters offer safe accommodation, food, and legal support.",
            style: textTheme.bodyMedium,
          ),
        ],
      ),
    );
  }
}
