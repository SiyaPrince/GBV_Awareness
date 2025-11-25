import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SupportHelpCardActionButton extends StatelessWidget {
  const SupportHelpCardActionButton({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return SizedBox(
      width: double.infinity,
      child: FilledButton.icon(
        onPressed: () {
          // Use go_router navigation
          context.push('/support');
        },
        style: FilledButton.styleFrom(
          backgroundColor: theme.colorScheme.error,
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        ),
        icon: const Icon(Icons.support_agent),
        label: const Text('View All Support Resources'),
      ),
    );
  }
}
