import 'package:flutter/material.dart';

class SafetyGuidanceCard extends StatelessWidget {
  const SafetyGuidanceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: const Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _SafetyGuidanceHeader(),
            SizedBox(height: 12),
            _SafetyGuidanceContent(),
          ],
        ),
      ),
    );
  }
}

class _SafetyGuidanceHeader extends StatelessWidget {
  const _SafetyGuidanceHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.health_and_safety, color: Colors.green),
        SizedBox(width: 8),
        Text(
          'Your Wellbeing Matters',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.green,
          ),
        ),
      ],
    );
  }
}

class _SafetyGuidanceContent extends StatelessWidget {
  const _SafetyGuidanceContent();

  @override
  Widget build(BuildContext context) {
    return const Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'If viewing this data causes distress:',
          style: TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
        ),
        SizedBox(height: 8),
        _SafetyActionsList(),
      ],
    );
  }
}

class _SafetyActionsList extends StatelessWidget {
  const _SafetyActionsList();

  @override
  Widget build(BuildContext context) {
    return const Column(
      children: [
        SafetyActionItem(
          icon: Icons.pause,
          title: 'Take breaks as needed',
          subtitle: 'Step away and return when comfortable',
        ),
        SafetyActionItem(
          icon: Icons.support_agent,
          title: 'Contact support services',
          subtitle: 'Professional help is available 24/7',
          hasNavigation: true,
        ),
        SafetyActionItem(
          icon: Icons.people,
          title: 'Remember you\'re not alone',
          subtitle: 'Many people care and want to help',
        ),
        SafetyActionItem(
          icon: Icons.security,
          title: 'Your safety comes first',
          subtitle: 'Prioritize your emotional wellbeing',
        ),
      ],
    );
  }
}

class SafetyActionItem extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final bool hasNavigation;

  const SafetyActionItem({
    super.key,
    required this.icon,
    required this.title,
    required this.subtitle,
    this.hasNavigation = false,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, size: 20, color: Colors.green),
      title: Text(
        title,
        style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w500),
      ),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      onTap: hasNavigation
          ? () => Navigator.pushNamed(context, '/support')
          : null,
      visualDensity: VisualDensity.compact,
    );
  }
}
