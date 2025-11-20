import 'package:cloud_firestore/cloud_firestore.dart';

import 'stats_service.dart';
import 'models/stat_metric.dart';
import 'models/metric_point.dart';

class FirebaseStatsService implements StatsService {
  FirebaseStatsService({
    FirebaseFirestore? firestore,
  }) : _firestore = firestore ?? FirebaseFirestore.instance;

  final FirebaseFirestore _firestore;

  CollectionReference<Map<String, dynamic>> get _metricsRef =>
      _firestore.collection('metrics');

  CollectionReference<Map<String, dynamic>> get _metricDataRef =>
      _firestore.collection('metricData');

  @override
  Stream<List<StatMetric>> streamAllMetrics() {
    return _metricsRef
        .orderBy('priority', descending: false)
        .snapshots()
        .map(
          (snapshot) => snapshot.docs
              .map((doc) => StatMetric.fromDoc(doc))
              .toList(),
        );
  }

  @override
  Stream<StatMetric?> streamMetric(String metricId) {
    return _metricsRef.doc(metricId).snapshots().map((doc) {
      if (!doc.exists) return null;
      return StatMetric.fromDoc(doc);
    });
  }

  @override
  Stream<List<MetricPoint>> streamMetricPoints(
    String metricId, {
    String? region,
    DateTime? from,
    DateTime? to,
  }) {
    Query<Map<String, dynamic>> query =
        _metricDataRef.where('metricId', isEqualTo: metricId);

    // Optional filters – safe and simple
    if (region != null) {
      query = query.where('region', isEqualTo: region);
    }
    if (from != null) {
      query = query.where(
        'timestamp',
        isGreaterThanOrEqualTo: Timestamp.fromDate(from),
      );
    }
    if (to != null) {
      query = query.where(
        'timestamp',
        isLessThanOrEqualTo: Timestamp.fromDate(to),
      );
    }

    // No orderBy – Firestore will just return all matching docs.
    return query.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => MetricPoint.fromDoc(doc))
              .toList(),
        );
  }

  @override
  Stream<List<MetricWithLatest>> streamDashboardMetrics() {
    // Simple implementation: whenever metric definitions change,
    // fetch the latest datapoint for each metric ONCE.
    return streamAllMetrics().asyncMap((metrics) async {
      final result = <MetricWithLatest>[];

      for (final metric in metrics) {
        final latestSnap = await _metricDataRef
            .where('metricId', isEqualTo: metric.id)
            .orderBy('timestamp', descending: true)
            .limit(1)
            .get();

        MetricPoint? latestPoint;
        if (latestSnap.docs.isNotEmpty) {
          latestPoint = MetricPoint.fromDoc(latestSnap.docs.first);
        }

        result.add(
          MetricWithLatest(
            metric: metric,
            latestPoint: latestPoint,
          ),
        );
      }

      return result;
    });
  }
}
