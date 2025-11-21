import 'package:flutter/material.dart';

class DataContextCard extends StatelessWidget {
  const DataContextCard({super.key});

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
            _DataContextHeader(),
            SizedBox(height: 12),
            _DataContextPoints(),
          ],
        ),
      ),
    );
  }
}

class _DataContextHeader extends StatelessWidget {
  const _DataContextHeader();

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        Icon(Icons.data_usage, color: Colors.orange),
        SizedBox(width: 8),
        Text(
          'About This Data',
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.orange,
          ),
        ),
      ],
    );
  }
}

class _DataContextPoints extends StatelessWidget {
  const _DataContextPoints();

  @override
  Widget build(BuildContext context) {
    const points = [
      "GBV is significantly underreported globally",
      "Increased reporting can indicate growing trust in support systems",
      "Data helps target resources and measure prevention efforts",
      "All data is anonymized and aggregated for safety",
      "Statistics inform action but don't define individual experiences",
    ];

    return Column(
      children: points
          .map(
            (point) => Padding(
              padding: const EdgeInsets.only(bottom: 8),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    '• ',
                    style: TextStyle(fontSize: 16, color: Colors.orange),
                  ),
                  Expanded(
                    child: Text(
                      point,
                      style: const TextStyle(fontSize: 14, height: 1.4),
                    ),
                  ),
                ],
              ),
            ),
          )
          .toList(),
    );
  }
}
