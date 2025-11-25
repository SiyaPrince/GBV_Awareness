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
          (snapshot) =>
              snapshot.docs.map((doc) => StatMetric.fromDoc(doc)).toList(),
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

    // We don't order in Firestore – we sort in Dart where needed.
    return query.snapshots().map(
          (snapshot) => snapshot.docs
              .map((doc) => MetricPoint.fromDoc(doc))
              .toList(),
        );
  }

  @override
  Stream<List<MetricWithLatest>> streamDashboardMetrics() {
    // Whenever the metric definitions change, recompute
    // "metric + latest datapoint" for each metric.
    //
    // IMPORTANT: no orderBy() here → no composite index required.
    // We fetch all points for a metric, then sort in Dart and pick the last.
    return streamAllMetrics().asyncMap((metrics) async {
      final result = <MetricWithLatest>[];

      for (final metric in metrics) {
        try {
          final snap = await _metricDataRef
              .where('metricId', isEqualTo: metric.id)
              .get();

          MetricPoint? latestPoint;

          if (snap.docs.isNotEmpty) {
            final points = snap.docs
                .map((doc) => MetricPoint.fromDoc(doc))
                .toList()
              ..sort(
                (a, b) => a.timestamp.compareTo(b.timestamp),
              ); // oldest → newest

            latestPoint = points.last; // newest value
          }

          result.add(
            MetricWithLatest(
              metric: metric,
              latestPoint: latestPoint,
            ),
          );
        } catch (_) {
          // If anything goes wrong for this metric, still include it
          // but with no latestPoint so the UI can show "--".
          result.add(
            MetricWithLatest(
              metric: metric,
              latestPoint: null,
            ),
          );
        }
      }

      return result;
    });
  }
}
