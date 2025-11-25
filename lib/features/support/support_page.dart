import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/services/support_service.dart';
import 'package:gbv_awareness/common/widgets/important_notice.dart';
import 'package:gbv_awareness/features/support/widgets/emergency_banner.dart';
import 'package:gbv_awareness/features/support/widgets/support_search_bar.dart';
import 'package:gbv_awareness/features/support/widgets/region_filter.dart';
import 'package:gbv_awareness/features/support/widgets/categorized_resources.dart';

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

  void _onRegionSelected(String region) {
    setState(() {
      _selectedRegion = region;
    });
  }

  void _onSearchQueryChanged(String query) {
    setState(() {
      _searchQuery = query;
    });
  }

  void _onClearSearch() {
    setState(() {
      _searchQuery = '';
      _searchController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        children: [
          // ------------------ EMERGENCY BANNER ------------------
          const EmergencyBanner(),

          const SizedBox(height: 24),

          // ------------------ SEARCH BAR ------------------
          SupportSearchBar(
            searchController: _searchController,
            searchQuery: _searchQuery,
            onSearchQueryChanged: _onSearchQueryChanged,
            onClearSearch: _onClearSearch,
          ),

          const SizedBox(height: 16),

          // ------------------ REGION FILTER ------------------
          RegionFilter(
            supportService: _supportService,
            selectedRegion: _selectedRegion,
            onRegionSelected: _onRegionSelected,
          ),

          const SizedBox(height: 24),

          // ------------------ CATEGORIZED RESOURCES ------------------
          CategorizedResources(
            supportService: _supportService,
            selectedRegion: _selectedRegion,
            searchQuery: _searchQuery,
          ),

          const SizedBox(height: 32),

          // ------------------ IMPORTANT NOTICE ------------------
          const ImportantNotice(),
        ],
      ),
    );
  }
}
