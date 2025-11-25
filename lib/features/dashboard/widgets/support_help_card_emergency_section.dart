import 'package:flutter/material.dart';

class SupportHelpCardEmergencySection extends StatelessWidget {
  const SupportHelpCardEmergencySection({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: theme.colorScheme.error.withAlpha(25),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            '🆘 Emergency Contacts',
            style: theme.textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.bold,
              color: theme.colorScheme.error,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'If you are in immediate danger:',
            style: theme.textTheme.bodyMedium,
          ),
          const SizedBox(height: 8),
          _EmergencyContactRow(service: 'Police Emergency', number: '10111'),
          _EmergencyContactRow(service: 'Ambulance', number: '10177'),
          _EmergencyContactRow(
            service: 'GBV Command Centre',
            number: '0800 428 428',
          ),
        ],
      ),
    );
  }
}

class _EmergencyContactRow extends StatelessWidget {
  final String service;
  final String number;

  const _EmergencyContactRow({required this.service, required this.number});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          SizedBox(
            width: 150,
            child: Text(
              service,
              style: const TextStyle(fontWeight: FontWeight.w500),
            ),
          ),
          Text(
            number,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }
}
