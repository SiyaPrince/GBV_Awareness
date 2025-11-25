import 'package:cloud_firestore/cloud_firestore.dart';

enum MetricType { timeseries, snapshot, ratio, percentage }
enum ChartType { line, bar, none }
enum MetricFrequency { daily, monthly, yearly, unknown }

class StatMetric {
  final String id;

  final String title;
  final String? shortLabel;
  final String? description;

  final MetricType type;
  final ChartType chartType;
  final MetricFrequency frequency;

  final String? unit;
  final String? sourceName;
  final String? sourceUrl;

  final String? category;
  final List<String> tags;

  final bool isSensitive;
  final String? interpretationHint;
  final String? warningText;

  final double? minExpected;
  final double? maxExpected;

  final int priority;

  const StatMetric({
    required this.id,
    required this.title,
    this.shortLabel,
    this.description,
    this.type = MetricType.timeseries,
    this.chartType = ChartType.line,
    this.frequency = MetricFrequency.unknown,
    this.unit,
    this.sourceName,
    this.sourceUrl,
    this.category,
    this.tags = const [],
    this.isSensitive = false,
    this.interpretationHint,
    this.warningText,
    this.minExpected,
    this.maxExpected,
    this.priority = 0,
  });

  // ---------- Firestore helpers ----------

  factory StatMetric.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data() ?? {};

    return StatMetric(
      id: doc.id,
      title: data['title'] as String? ?? 'Untitled metric',
      shortLabel: data['shortLabel'] as String?,
      description: data['description'] as String?,
      type: _metricTypeFromString(data['type'] as String?),
      chartType: _chartTypeFromString(data['chartType'] as String?),
      frequency: _frequencyFromString(data['frequency'] as String?),
      unit: data['unit'] as String?,
      sourceName: data['sourceName'] as String?,
      sourceUrl: data['sourceUrl'] as String?,
      category: data['category'] as String?,
      tags: (data['tags'] as List<dynamic>?)
              ?.map((e) => e.toString())
              .toList() ??
          const [],
      isSensitive: (data['isSensitive'] as bool?) ?? false,
      interpretationHint: data['interpretationHint'] as String?,
      warningText: data['warningText'] as String?,
      minExpected: (data['minExpected'] as num?)?.toDouble(),
      maxExpected: (data['maxExpected'] as num?)?.toDouble(),
      priority: (data['priority'] as num?)?.toInt() ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'shortLabel': shortLabel,
      'description': description,
      'type': type.name,
      'chartType': chartType.name,
      'frequency': frequency.name,
      'unit': unit,
      'sourceName': sourceName,
      'sourceUrl': sourceUrl,
      'category': category,
      'tags': tags,
      'isSensitive': isSensitive,
      'interpretationHint': interpretationHint,
      'warningText': warningText,
      'minExpected': minExpected,
      'maxExpected': maxExpected,
      'priority': priority,
    };
  }

  // ---------- Enum helpers ----------

  static MetricType _metricTypeFromString(String? value) {
    switch (value) {
      case 'snapshot':
        return MetricType.snapshot;
      case 'ratio':
        return MetricType.ratio;
      case 'percentage':
        return MetricType.percentage;
      case 'timeseries':
      default:
        return MetricType.timeseries;
    }
  }

  static ChartType _chartTypeFromString(String? value) {
    switch (value) {
      case 'bar':
        return ChartType.bar;
      case 'none':
        return ChartType.none;
      case 'line':
      default:
        return ChartType.line;
    }
  }

  static MetricFrequency _frequencyFromString(String? value) {
    switch (value) {
      case 'daily':
        return MetricFrequency.daily;
      case 'monthly':
        return MetricFrequency.monthly;
      case 'yearly':
        return MetricFrequency.yearly;
      default:
        return MetricFrequency.unknown;
    }
  }

  // ---------- copyWith ----------

  StatMetric copyWith({
    String? id,
    String? title,
    String? shortLabel,
    String? description,
    MetricType? type,
    ChartType? chartType,
    MetricFrequency? frequency,
    String? unit,
    String? sourceName,
    String? sourceUrl,
    String? category,
    List<String>? tags,
    bool? isSensitive,
    String? interpretationHint,
    String? warningText,
    double? minExpected,
    double? maxExpected,
    int? priority,
  }) {
    return StatMetric(
      id: id ?? this.id,
      title: title ?? this.title,
      shortLabel: shortLabel ?? this.shortLabel,
      description: description ?? this.description,
      type: type ?? this.type,
      chartType: chartType ?? this.chartType,
      frequency: frequency ?? this.frequency,
      unit: unit ?? this.unit,
      sourceName: sourceName ?? this.sourceName,
      sourceUrl: sourceUrl ?? this.sourceUrl,
      category: category ?? this.category,
      tags: tags ?? this.tags,
      isSensitive: isSensitive ?? this.isSensitive,
      interpretationHint: interpretationHint ?? this.interpretationHint,
      warningText: warningText ?? this.warningText,
      minExpected: minExpected ?? this.minExpected,
      maxExpected: maxExpected ?? this.maxExpected,
      priority: priority ?? this.priority,
    );
  }
}
