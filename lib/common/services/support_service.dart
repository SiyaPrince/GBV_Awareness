import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:gbv_awareness/common/models/support_resource.dart';

class SupportService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  // Get all available regions from resources
  Stream<List<String>> getAvailableRegions() {
    return _firestore.collection('support_resources').snapshots().map((
      snapshot,
    ) {
      final regions = <String>{};
      for (final doc in snapshot.docs) {
        final resource = SupportResource.fromFirestore(doc.data(), doc.id);
        if (resource.region.isNotEmpty) {
          regions.add(resource.region);
        }
      }
      return regions.toList()..sort();
    });
  }

  // Get resources grouped by type
  Stream<Map<String, List<SupportResource>>> getResourcesGroupedByType() {
    return _firestore.collection('support_resources').snapshots().map((
      snapshot,
    ) {
      final groupedResources = <String, List<SupportResource>>{};

      for (final doc in snapshot.docs) {
        final resource = SupportResource.fromFirestore(doc.data(), doc.id);
        groupedResources.putIfAbsent(resource.type, () => []).add(resource);
      }

      // Sort resources within each category
      for (final resources in groupedResources.values) {
        resources.sort((a, b) => a.name.compareTo(b.name));
      }

      return groupedResources;
    });
  }

  // Search resources by name or description
  Stream<List<SupportResource>> searchResources(String query) {
    if (query.isEmpty) {
      return Stream.value([]);
    }

    return _firestore.collection('support_resources').snapshots().map((
      snapshot,
    ) {
      final results = <SupportResource>[];
      final lowerQuery = query.toLowerCase();

      for (final doc in snapshot.docs) {
        final resource = SupportResource.fromFirestore(doc.data(), doc.id);

        if (resource.name.toLowerCase().contains(lowerQuery) ||
            resource.description.toLowerCase().contains(lowerQuery) ||
            resource.region.toLowerCase().contains(lowerQuery) ||
            resource.type.toLowerCase().contains(lowerQuery)) {
          results.add(resource);
        }
      }

      results.sort((a, b) => a.name.compareTo(b.name));
      return results;
    });
  }

  // Get all resources (for backup/alternative implementation)
  Stream<List<SupportResource>> getAllResources() {
    return _firestore
        .collection('support_resources')
        .snapshots()
        .map(
          (snapshot) =>
              snapshot.docs
                  .map(
                    (doc) => SupportResource.fromFirestore(doc.data(), doc.id),
                  )
                  .toList()
                ..sort((a, b) => a.name.compareTo(b.name)),
        );
  }
}
