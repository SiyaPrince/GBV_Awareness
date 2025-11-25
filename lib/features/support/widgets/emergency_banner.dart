import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/widgets/emergency_contacts.dart';

class EmergencyBanner extends StatelessWidget {
  const EmergencyBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.red,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.warning, color: Colors.white, size: 24),
              const SizedBox(width: 8),
              Text(
                "EMERGENCY CONTACTS",
                style: textTheme.titleLarge?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "If you are in immediate danger, call these numbers immediately:",
            style: textTheme.bodyLarge?.copyWith(color: Colors.white),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              EmergencyContact(label: "Police", number: "10111"),
              EmergencyContact(label: "GBV Helpline", number: "0800 428 428"),
            ],
          ),
          const SizedBox(height: 8),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const [
              EmergencyContact(label: "Lifeline", number: "0861 322 322"),
              EmergencyContact(label: "Childline", number: "0800 055 555"),
            ],
          ),
        ],
      ),
    );
  }
}
