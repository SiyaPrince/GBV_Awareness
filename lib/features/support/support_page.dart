import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/support_resource.dart';
import 'package:gbv_awareness/common/services/support_service.dart';
import 'package:gbv_awareness/common/widgets/emergency_contacts.dart';
import 'package:gbv_awareness/common/widgets/important_notice.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  final SupportService _supportService = SupportService();
  String _selectedRegion = 'All';
  String _searchQuery = '';
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ------------------ EMERGENCY BANNER ------------------
          Container(
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
                    EmergencyContact(
                      label: "GBV Helpline",
                      number: "0800 428 428",
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: const [
                    EmergencyContact(label: "Lifeline", number: "0861 322 322"),
                    EmergencyContact(
                      label: "Childline",
                      number: "0800 055 555",
                    ),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 24),

          // ------------------ SEARCH BAR ------------------
          _buildSearchBar(),

          const SizedBox(height: 16),

          // ------------------ REGION FILTER ------------------
          StreamBuilder<List<String>>(
            stream: _supportService.getAvailableRegions(),
            builder: (context, snapshot) {
              final regions =
                  snapshot.data ??
                  ['National', 'Gauteng', 'Western Cape', 'KwaZulu-Natal'];
              return _buildRegionFilter(regions);
            },
          ),

          const SizedBox(height: 24),

          // ------------------ CATEGORIZED RESOURCES ------------------
          _buildCategorizedResources(),

          const SizedBox(height: 32),

          // ------------------ IMPORTANT NOTICE ------------------
          const ImportantNotice(),
        ],
      ),
    );
  }

  Widget _buildSearchBar() {
    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            const Icon(Icons.search, color: Colors.grey),
            const SizedBox(width: 12),
            Expanded(
              child: TextField(
                controller: _searchController,
                decoration: const InputDecoration(
                  hintText: 'Search for support services...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: (value) {
                  setState(() {
                    _searchQuery = value;
                  });
                },
              ),
            ),
            if (_searchQuery.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear, size: 20),
                onPressed: () {
                  setState(() {
                    _searchQuery = '';
                    _searchController.clear();
                  });
                },
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildRegionFilter(List<String> regions) {
    final allRegions = ['All', ...regions];

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Filter by Region',
              style: Theme.of(
                context,
              ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: allRegions.map((region) {
                final isSelected = _selectedRegion == region;
                return FilterChip(
                  label: Text(region),
                  selected: isSelected,
                  onSelected: (selected) {
                    setState(() {
                      _selectedRegion = selected ? region : 'All';
                    });
                  },
                  backgroundColor: isSelected
                      ? Colors.blue[100]
                      : Colors.grey[100],
                  selectedColor: Colors.blue[200],
                  checkmarkColor: Colors.blue[800],
                );
              }).toList(),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategorizedResources() {
    if (_searchQuery.isNotEmpty) {
      return _buildSearchResults();
    }

    return StreamBuilder<Map<String, List<SupportResource>>>(
      stream: _supportService.getResourcesGroupedByType(),
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
                '🆘 24/7 Emergency Hotlines',
                filteredResources['hotline']!,
              ),

            // Safe Shelters
            if (filteredResources['shelter']?.isNotEmpty ?? false)
              ..._buildResourceSection(
                '🏠 Safe Shelters',
                filteredResources['shelter']!,
              ),

            // Legal Support
            if (filteredResources['legal']?.isNotEmpty ?? false)
              ..._buildResourceSection(
                '⚖️ Legal Support',
                filteredResources['legal']!,
              ),

            // Health Services
            if (filteredResources['health']?.isNotEmpty ?? false)
              ..._buildResourceSection(
                '🏥 Health Services',
                filteredResources['health']!,
              ),

            // Support Organizations
            if (filteredResources['organization']?.isNotEmpty ?? false)
              ..._buildResourceSection(
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
                  '📋 ${entry.value.first.displayType}',
                  entry.value,
                ),
          ],
        );
      },
    );
  }

  Widget _buildSearchResults() {
    return StreamBuilder<List<SupportResource>>(
      stream: _supportService.searchResources(_searchQuery),
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
          return _buildEmptyState('No results found for "$_searchQuery"');
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
            ..._buildResourceSection('Results', filteredResources),
          ],
        );
      },
    );
  }

  Map<String, List<SupportResource>> _filterResourcesByRegion(
    Map<String, List<SupportResource>> groupedResources,
  ) {
    if (_selectedRegion == 'All') return groupedResources;

    final filtered = <String, List<SupportResource>>{};
    for (final entry in groupedResources.entries) {
      final regionalResources = entry.value
          .where((resource) => resource.region == _selectedRegion)
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
    if (_selectedRegion == 'All') return resources;
    return resources
        .where((resource) => resource.region == _selectedRegion)
        .toList();
  }

  List<Widget> _buildResourceSection(
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
      ...resources.map((resource) => _SupportResourceCard(resource: resource)),
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
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.red),
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
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: Colors.grey),
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}

class _SupportResourceCard extends StatelessWidget {
  final SupportResource resource;

  const _SupportResourceCard({required this.resource});

  Future<void> _launchUrl(String url) async {
    if (url.isEmpty) return;
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  Future<void> _launchCall(String number) async {
    if (number.isEmpty) return;
    final Uri uri = Uri.parse('tel:$number');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  // Helper method to get color with opacity without using deprecated withOpacity
  Color _getColorWithOpacity(Color color) {
    // ignore: deprecated_member_use
    return Color.fromRGBO(color.red, color.green, color.blue, 0.1);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header with icon and name
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Icon
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    color: _getColorWithOpacity(
                      resource.color,
                    ), // Fixed: using helper method
                    borderRadius: BorderRadius.circular(24),
                  ),
                  child: Icon(resource.icon, color: resource.color, size: 24),
                ),
                const SizedBox(width: 16),
                // Content
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        resource.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        resource.displayType,
                        style: TextStyle(
                          fontSize: 14,
                          color: resource.color,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ],
                  ),
                ),
                // Emergency badge
                if (resource.isEmergency)
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: Colors.red,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: const Text(
                      'EMERGENCY',
                      style: TextStyle(
                        fontSize: 10,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
              ],
            ),

            const SizedBox(height: 12),

            // Contact information
            if (resource.contact.isNotEmpty)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => _launchCall(resource.contact),
                    child: Row(
                      children: [
                        Icon(Icons.phone, size: 16, color: Colors.blue[700]),
                        const SizedBox(width: 8),
                        Text(
                          resource.contact,
                          style: TextStyle(
                            fontSize: 16,
                            color: Colors.blue[700],
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 8),
                ],
              ),

            // Region
            if (resource.region.isNotEmpty && resource.region != 'National')
              Row(
                children: [
                  Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    resource.region,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),

            // Hours
            if (resource.hours.isNotEmpty) ...[
              const SizedBox(height: 8),
              Row(
                children: [
                  Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
                  const SizedBox(width: 8),
                  Text(
                    resource.hours,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
            ],

            // Description
            if (resource.description.isNotEmpty) ...[
              const SizedBox(height: 12),
              Text(
                resource.description,
                style: const TextStyle(fontSize: 14, height: 1.4),
              ),
            ],

            // Actions
            const SizedBox(height: 16),
            Row(
              children: [
                if (resource.hasContact)
                  ElevatedButton.icon(
                    onPressed: () => _launchCall(resource.contact),
                    icon: const Icon(Icons.phone, size: 16),
                    label: const Text('Call'),
                    style: ElevatedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
                const SizedBox(width: 8),
                if (resource.hasWebsite)
                  OutlinedButton.icon(
                    onPressed: () => _launchUrl(resource.url),
                    icon: const Icon(Icons.open_in_new, size: 16),
                    label: const Text('Website'),
                    style: OutlinedButton.styleFrom(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 12,
                        vertical: 8,
                      ),
                    ),
                  ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
