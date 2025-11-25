import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/support_service.dart';

class RegionFilter extends StatelessWidget {
  final SupportService supportService;
  final String selectedRegion;
  final Function(String) onRegionSelected;

  const RegionFilter({
    super.key,
    required this.supportService,
    required this.selectedRegion,
    required this.onRegionSelected,
  });

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<List<String>>(
      stream: supportService.getAvailableRegions(),
      builder: (context, snapshot) {
        final regions =
            snapshot.data ??
            ['National', 'Gauteng', 'Western Cape', 'KwaZulu-Natal'];
        return _buildRegionFilterContent(context, regions);
      },
    );
  }

  Widget _buildRegionFilterContent(BuildContext context, List<String> regions) {
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
                final isSelected = selectedRegion == region;
                return FilterChip(
                  label: Text(region),
                  selected: isSelected,
                  onSelected: (selected) {
                    onRegionSelected(selected ? region : 'All');
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
}
