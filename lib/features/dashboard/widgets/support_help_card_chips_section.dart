import 'package:flutter/material.dart';

class SupportHelpCardChipsSection extends StatelessWidget {
  const SupportHelpCardChipsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Available Support:',
          style: Theme.of(
            context,
          ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: const [
            _SupportChip(icon: Icons.phone, label: '24/7 Helplines'),
            _SupportChip(icon: Icons.home, label: 'Safe Shelters'),
            _SupportChip(icon: Icons.people, label: 'Counseling'),
            _SupportChip(icon: Icons.gavel, label: 'Legal Support'),
          ],
        ),
      ],
    );
  }
}

class _SupportChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _SupportChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Chip(
      avatar: Icon(icon, size: 16),
      label: Text(label),
      backgroundColor: Colors.grey[100],
      side: BorderSide.none,
    );
  }
}
