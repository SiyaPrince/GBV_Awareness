import 'package:flutter/material.dart';

class SupportPage extends StatelessWidget {
  const SupportPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          // Emergency Banner
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: Colors.red.withOpacity(0.9),
              borderRadius: BorderRadius.circular(12.0),
            ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Icon(Icons.warning, color: Colors.white, size: 24),
                    const SizedBox(width: 8),
                    Text(
                      'EMERGENCY CONTACTS',
                      style: Theme.of(context).textTheme.titleLarge?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  'If you are in immediate danger, call these numbers immediately:',
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildEmergencyContact('Police Emergency', '10111'),
                    _buildEmergencyContact('GBV Helpline', '0800 428 428'),
                  ],
                ),
                const SizedBox(height: 8),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _buildEmergencyContact('Lifeline', '0861 322 322'),
                    _buildEmergencyContact('Childline', '0800 055 555'),
                  ],
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          // Hotlines Section
          Text(
            '24/7 Support Hotlines',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _buildResourceCard(
            context,
            'GBV Command Centre',
            '0800 428 428',
            '24/7 national gender-based violence helpline',
            Icons.phone,
          ),
          _buildResourceCard(
            context,
            'SAPS Emergency',
            '10111',
            'South African Police Service emergency line',
            Icons.local_police,
          ),
          _buildResourceCard(
            context,
            'Lifeline Counseling',
            '0861 322 322',
            'Counselling and support for trauma',
            Icons.psychology,
          ),

          const SizedBox(height: 32),

          // Shelters Section
          Text(
            'Safe Shelters & Housing',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _buildResourceCard(
            context,
            'People Against Women Abuse (POWA)',
            '011 642 4345',
            'Shelter, counselling and legal support in Gauteng',
            Icons.security,
          ),
          _buildResourceCard(
            context,
            'Saartjie Baartman Centre',
            '021 633 5287',
            '24-hour emergency shelter in Western Cape',
            Icons.home_work,
          ),
          _buildResourceCard(
            context,
            'Ikhaya Lethemba',
            '010 223 0137',
            'One-stop centre for abused women and children',
            Icons.family_restroom,
          ),

          const SizedBox(height: 32),

          // Legal Resources
          Text(
            'Legal Support',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _buildResourceCard(
            context,
            'Legal Aid South Africa',
            '0800 110 110',
            'Free legal services for those who qualify',
            Icons.gavel,
          ),
          _buildResourceCard(
            context,
            'Women\'s Legal Centre',
            '021 424 5660',
            'Specialized legal services for women',
            Icons.balance,
          ),

          const SizedBox(height: 32),

          //Healthcare Resources
          Text(
            'Healthcare Services',
            style: Theme.of(context).textTheme.headlineSmall?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 16),

          _buildResourceCard(
            context,
            'Thuthuzela Care Centres',
            'Check website for locations',
            'One-stop facilities for rape survivors',
            Icons.local_hospital,
          ),

          const SizedBox(height: 32),

          // Important Notice
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: colorScheme.secondary.withOpacity(0.1),
              border: Border.all(color: colorScheme.secondary),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info, color: colorScheme.secondary),
                    const SizedBox(width: 8),
                    Text(
                      'Important Information',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: colorScheme.secondary,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 8),
                Text(
                  'All services listed are confidential and free of charge. '
                  'Shelters provide safe accommodation, food, and support services. '
                  'Legal aid services can help with protection orders and court proceedings.',
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    color: Theme.of(context).colorScheme.onSurface,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEmergencyContact(String label, String number) {
    return Column(
      children: [
        Text(
          label,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 4),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Text(
            number,
            style: const TextStyle(
              color: Colors.red,
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildResourceCard(
    BuildContext context,
    String title,
    String contact,
    String description,
    IconData icon,
  ) {
    final colorScheme = Theme.of(context).colorScheme;

    return Card(
      margin: const EdgeInsets.only(bottom: 16.0),
      color: colorScheme.surface,
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: colorScheme.primary, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: colorScheme.primary,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    contact,
                    style: Theme.of(context).textTheme.titleMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                      color: colorScheme.onSurface,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: colorScheme.onSurface,
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
