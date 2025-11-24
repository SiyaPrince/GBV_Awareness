import 'package:flutter/material.dart';
import 'support_help_card_emergency_section.dart';
import 'support_help_card_chips_section.dart';
import 'support_help_card_action_button.dart';
import 'support_help_card_safety_reminder.dart';

class SupportHelpCard extends StatelessWidget {
  const SupportHelpCard({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      elevation: 0,
      color: theme.colorScheme.error.withAlpha(20),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: theme.colorScheme.error.withAlpha(76)),
      ),
      child: const Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header
            _SupportHelpCardHeader(),
            SizedBox(height: 16),

            // Emergency Contacts Section
            SupportHelpCardEmergencySection(),
            SizedBox(height: 16),

            // Support Chips Section
            SupportHelpCardChipsSection(),
            SizedBox(height: 16),

            // Action Button Section
            SupportHelpCardActionButton(),
            SizedBox(height: 8),

            // Safety Reminder
            SupportHelpCardSafetyReminder(),
          ],
        ),
      ),
    );
  }
}

class _SupportHelpCardHeader extends StatelessWidget {
  const _SupportHelpCardHeader();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Row(
      children: [
        Icon(Icons.emergency, color: theme.colorScheme.error),
        const SizedBox(width: 12),
        Expanded(
          child: Text(
            'Support & Safety Resources',
            style: theme.textTheme.titleMedium?.copyWith(
              color: theme.colorScheme.error,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
