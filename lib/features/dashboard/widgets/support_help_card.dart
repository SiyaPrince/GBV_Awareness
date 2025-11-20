import 'package:flutter/material.dart';

/// A reusable card that highlights emergency / support information
/// for users who may be experiencing GBV.
class SupportHelpCard extends StatelessWidget {
  const SupportHelpCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      elevation: 0,
      color: theme.colorScheme.error.withOpacity(0.06),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: DefaultTextStyle(
          style: theme.textTheme.bodySmall!,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'If you need help',
                style: theme.textTheme.titleMedium?.copyWith(
                  color: theme.colorScheme.error,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              const Text(
                'If you or someone you know is experiencing GBV, '
                'please contact local support services or emergency lines in your area.',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
