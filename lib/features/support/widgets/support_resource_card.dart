import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/models/support_resource.dart';
import 'package:url_launcher/url_launcher.dart';

class SupportResourceCard extends StatelessWidget {
  final SupportResource resource;

  const SupportResourceCard({super.key, required this.resource});

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
                    color: _getColorWithOpacity(resource.color),
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
