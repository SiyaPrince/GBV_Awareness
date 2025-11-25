// lib/features/information_hub/presentation/widgets/information_hub_header.dart
import 'package:flutter/material.dart';

class InformationHubHeader extends StatelessWidget {
  const InformationHubHeader({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;

    return Text(
      'Information Hub',
      style: Theme.of(context).textTheme.headlineMedium?.copyWith(
        color: colors.primary,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
