import 'package:flutter/material.dart';

class EmergencyContact extends StatelessWidget {
  final String label;
  final String number;

  const EmergencyContact({
    super.key,
    required this.label,
    required this.number,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}

// List of all emergency contacts
const List<EmergencyContact> topEmergencyContacts = [
  EmergencyContact(label: "Police", number: "10111"),
  EmergencyContact(label: "GBV Helpline", number: "0800 428 428"),
];

const List<EmergencyContact> bottomEmergencyContacts = [
  EmergencyContact(label: "Lifeline", number: "0861 322 322"),
  EmergencyContact(label: "Childline", number: "0800 055 555"),
];
