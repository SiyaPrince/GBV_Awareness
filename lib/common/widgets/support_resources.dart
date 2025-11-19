import 'package:flutter/material.dart';

// Enum to distinguish the type of resources
enum SupportSection { hotlines, shelters, legal, health }

class SupportResourcesSection extends StatelessWidget {
  final SupportSection section;

  const SupportResourcesSection({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    // Define resources for each section
    final List<Map<String, dynamic>> resources;
    String title;

    switch (section) {
      case SupportSection.hotlines:
        title = "24/7 Support Hotlines";
        resources = [
          {
            "title": "GBV Command Centre",
            "contact": "0800 428 428",
            "description": "24/7 national gender-based violence helpline",
            "icon": Icons.phone,
          },
          {
            "title": "SAPS Emergency",
            "contact": "10111",
            "description": "Emergency response police services",
            "icon": Icons.local_police,
          },
          {
            "title": "Lifeline Counselling",
            "contact": "0861 322 322",
            "description": "Confidential emotional support",
            "icon": Icons.psychology,
          },
        ];
        break;

      case SupportSection.shelters:
        title = "Safe Shelters & Housing";
        resources = [
          {
            "title": "POWA",
            "contact": "011 642 4345",
            "description": "Shelter, counselling and legal support in Gauteng",
            "icon": Icons.security,
          },
          {
            "title": "Saartjie Baartman Centre",
            "contact": "021 633 5287",
            "description": "24-hour emergency shelter in Western Cape",
            "icon": Icons.home_work,
          },
          {
            "title": "Ikhaya Lethemba",
            "contact": "010 223 0137",
            "description": "One-stop centre for abused women and children",
            "icon": Icons.family_restroom,
          },
        ];
        break;

      case SupportSection.legal:
        title = "Legal Support";
        resources = [
          {
            "title": "Legal Aid South Africa",
            "contact": "0800 110 110",
            "description": "Free legal services for those who qualify",
            "icon": Icons.gavel,
          },
          {
            "title": "Women's Legal Centre",
            "contact": "021 424 5660",
            "description": "Specialized legal services for women",
            "icon": Icons.balance,
          },
        ];
        break;

      case SupportSection.health:
        title = "Healthcare Services";
        resources = [
          {
            "title": "Thuthuzela Care Centres",
            "contact": "Check website for locations",
            "description": "One-stop facilities for rape survivors",
            "icon": Icons.local_hospital,
          },
        ];
        break;
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: textTheme.headlineSmall?.copyWith(
            color: colors.primary,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 16),
        ...resources.map(
          (r) => ResourceCard(
            title: r["title"],
            contact: r["contact"],
            description: r["description"],
            icon: r["icon"],
          ),
        ),
      ],
    );
  }
}

// The ResourceCard widget can also be modularized:
class ResourceCard extends StatelessWidget {
  final String title;
  final String contact;
  final String description;
  final IconData icon;

  const ResourceCard({
    super.key,
    required this.title,
    required this.contact,
    required this.description,
    required this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final colors = Theme.of(context).colorScheme;
    final textTheme = Theme.of(context).textTheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      color: colors.surface,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colors.primary, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: textTheme.titleLarge?.copyWith(
                      color: colors.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    contact,
                    style: textTheme.titleMedium?.copyWith(
                      color: colors.onSurface,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: textTheme.bodyMedium?.copyWith(
                      color: colors.onSurface,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
