import 'package:flutter/material.dart';

class SupportSearchBar extends StatelessWidget {
  final TextEditingController searchController;
  final String searchQuery;
  final Function(String) onSearchQueryChanged;
  final VoidCallback onClearSearch;

  const SupportSearchBar({
    super.key,
    required this.searchController,
    required this.searchQuery,
    required this.onSearchQueryChanged,
    required this.onClearSearch,
  });

  @override
  Widget build(BuildContext context) {
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
                controller: searchController,
                decoration: const InputDecoration(
                  hintText: 'Search for support services...',
                  border: InputBorder.none,
                  contentPadding: EdgeInsets.zero,
                ),
                onChanged: onSearchQueryChanged,
              ),
            ),
            if (searchQuery.isNotEmpty)
              IconButton(
                icon: const Icon(Icons.clear, size: 20),
                onPressed: onClearSearch,
              ),
          ],
        ),
      ),
    );
  }
}
