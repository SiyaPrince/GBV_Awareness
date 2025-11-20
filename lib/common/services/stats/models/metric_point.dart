import 'package:cloud_firestore/cloud_firestore.dart';

class MetricPoint {
  final String id;

  final String metricId;
  final DateTime timestamp;
  final double value;

  final String? region;
  final Map<String, dynamic> breakdown;
  final String? notes;

  const MetricPoint({
    required this.id,
    required this.metricId,
    required this.timestamp,
    required this.value,
    this.region,
    this.breakdown = const {},
    this.notes,
  });

  // ---------- Firestore helpers ----------

  factory MetricPoint.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};

    return MetricPoint(
      id: doc.id,
      metricId: data['metricId'] as String? ?? '',
      timestamp: (data['timestamp'] as Timestamp?)?.toDate() ?? DateTime.now(),
      value: (data['value'] as num?)?.toDouble() ?? 0.0,
      region: data['region'] as String?,
      breakdown: Map<String, dynamic>.from(
        (data['breakdown'] as Map<String, dynamic>?) ?? {},
      ),
      notes: data['notes'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'metricId': metricId,
      'timestamp': Timestamp.fromDate(timestamp),
      'value': value,
      'region': region,
      'breakdown': breakdown,
      'notes': notes,
    };
  }

  MetricPoint copyWith({
    String? id,
    String? metricId,
    DateTime? timestamp,
    double? value,
    String? region,
    Map<String, dynamic>? breakdown,
    String? notes,
  }) {
    return MetricPoint(
      id: id ?? this.id,
      metricId: metricId ?? this.metricId,
      timestamp: timestamp ?? this.timestamp,
      value: value ?? this.value,
      region: region ?? this.region,
      breakdown: breakdown ?? this.breakdown,
      notes: notes ?? this.notes,
    );
  }
}
