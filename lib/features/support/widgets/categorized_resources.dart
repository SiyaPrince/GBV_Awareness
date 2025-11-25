import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/support_resource.dart';
import 'package:gbv_awareness/common/services/support_service.dart';
import 'package:gbv_awareness/features/support/widgets/support_resource_card.dart';

class CategorizedResources extends StatelessWidget {
  final SupportService supportService;
  final String selectedRegion;
  final String searchQuery;

  const CategorizedResources({
    super.key,
    required this.supportService,
    required this.selectedRegion,
    required this.searchQuery,
  });

  @override
  Widget build(BuildContext context) {
    if (searchQuery.isNotEmpty) {
      return _buildSearchResults(context);
    }

    return _buildCategorizedResources(context);
  }

  Widget _buildCategorizedResources(BuildContext context) {
    return StreamBuilder<Map<String, List<SupportResource>>>(
      stream: supportService.getResourcesGroupedByType(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        if (snapshot.hasError) {
          return _buildErrorState('Error loading support resources');
        }

        final groupedResources = snapshot.data ?? {};
        final filteredResources = _filterResourcesByRegion(groupedResources);

        if (filteredResources.isEmpty) {
          return _buildEmptyState('No support resources available');
        }

        return Column(
          children: [
            // Emergency Hotlines (always first)
            if (filteredResources['hotline']?.isNotEmpty ?? false)
              ..._buildResourceSection(
                context,
                '🆘 24/7 Emergency Hotlines',
                filteredResources['hotline']!,
              ),

            // Safe Shelters
            if (filteredResources['shelter']?.isNotEmpty ?? false)
              ..._buildResourceSection(
                context,
                '🏠 Safe Shelters',
                filteredResources['shelter']!,
              ),

            // Legal Support
            if (filteredResources['legal']?.isNotEmpty ?? false)
              ..._buildResourceSection(
                context,
                '⚖️ Legal Support',
                filteredResources['legal']!,
              ),

            // Health Services
            if (filteredResources['health']?.isNotEmpty ?? false)
              ..._buildResourceSection(
                context,
                '🏥 Health Services',
                filteredResources['health']!,
              ),

            // Support Organizations
            if (filteredResources['organization']?.isNotEmpty ?? false)
              ..._buildResourceSection(
                context,
                '🤝 Support Organizations',
                filteredResources['organization']!,
              ),

            // Other types
            for (final entry in filteredResources.entries)
              if (![
                'hotline',
                'shelter',
                'legal',
                'health',
                'organization',
              ].contains(entry.key))
                ..._buildResourceSection(
                  context,
                  '📋 ${entry.value.first.displayType}',
                  entry.value,
                ),
          ],
        );
      },
    );
  }

  Widget _buildSearchResults(BuildContext context) {
    return StreamBuilder<List<SupportResource>>(
      stream: supportService.searchResources(searchQuery),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return _buildLoadingState();
        }

        if (snapshot.hasError) {
          return _buildErrorState('Error searching resources');
        }

        final resources = snapshot.data ?? [];
        final filteredResources = _filterResourcesByRegionList(resources);

        if (filteredResources.isEmpty) {
          return _buildEmptyState('No results found for "$searchQuery"');
        }

        return Column(
          children: [
            Text(
              'Search Results (${filteredResources.length})',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            ..._buildResourceSection(context, 'Results', filteredResources),
          ],
        );
      },
    );
  }

  Map<String, List<SupportResource>> _filterResourcesByRegion(
    Map<String, List<SupportResource>> groupedResources,
  ) {
    if (selectedRegion == 'All') return groupedResources;

    final filtered = <String, List<SupportResource>>{};
    for (final entry in groupedResources.entries) {
      final regionalResources = entry.value
          .where((resource) => resource.region == selectedRegion)
          .toList();
      if (regionalResources.isNotEmpty) {
        filtered[entry.key] = regionalResources;
      }
    }
    return filtered;
  }

  List<SupportResource> _filterResourcesByRegionList(
    List<SupportResource> resources,
  ) {
    if (selectedRegion == 'All') return resources;
    return resources
        .where((resource) => resource.region == selectedRegion)
        .toList();
  }

  List<Widget> _buildResourceSection(
    BuildContext context,
    String title,
    List<SupportResource> resources,
  ) {
    return [
      const SizedBox(height: 8),
      Text(
        title,
        style: Theme.of(
          context,
        ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
      ),
      const SizedBox(height: 16),
      ...resources.map((resource) => SupportResourceCard(resource: resource)),
      const SizedBox(height: 24),
    ];
  }

  Widget _buildLoadingState() {
    return const Column(
      children: [
        Center(child: CircularProgressIndicator()),
        SizedBox(height: 16),
        Text('Loading support resources...'),
      ],
    );
  }

  Widget _buildErrorState(String error) {
    return Column(
      children: [
        Icon(Icons.error_outline, size: 48, color: Colors.red[300]),
        const SizedBox(height: 16),
        Text(
          error,
          style: const TextStyle(color: Colors.red),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }

  Widget _buildEmptyState(String message) {
    return Column(
      children: [
        Icon(Icons.search_off, size: 48, color: Colors.grey[300]),
        const SizedBox(height: 16),
        Text(
          message,
          style: const TextStyle(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
