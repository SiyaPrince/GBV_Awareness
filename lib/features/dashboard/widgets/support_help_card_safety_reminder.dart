import 'package:flutter/material.dart';

class SupportHelpCardSafetyReminder extends StatelessWidget {
  const SupportHelpCardSafetyReminder({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      'Remember: You are not alone. Support is confidential and available 24/7.',
      style: Theme.of(
        context,
      ).textTheme.bodySmall?.copyWith(fontStyle: FontStyle.italic),
      textAlign: TextAlign.center,
    );
  }
}
