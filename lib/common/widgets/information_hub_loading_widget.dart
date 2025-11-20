// lib/features/information_hub/presentation/widgets/information_hub_loading_widget.dart
import 'package:flutter/material.dart';

class InformationHubLoadingWidget extends StatelessWidget {
  const InformationHubLoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(child: CircularProgressIndicator());
  }
}
