import 'package:flutter/material.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('About GBVInsights'),
        backgroundColor: Colors.purple,
        foregroundColor: Colors.white,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Header Section
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(24.0),
              decoration: BoxDecoration(
                color: Colors.purple.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12.0),
              ),
              child: Column(
                children: [
                  Icon(Icons.heart_broken, size: 64, color: Colors.purple),
                  const SizedBox(height: 16),
                  Text(
                    'GBVInsights',
                    style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Awareness • Education • Support',
                    style: Theme.of(
                      context,
                    ).textTheme.titleLarge?.copyWith(color: Colors.purple[700]),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Mission Section
            Text(
              'Our Mission',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'GBVInsights is dedicated to raising awareness about Gender-Based Violence through education, real-time insights, and accessible support resources. We believe that knowledge and community support are powerful tools in the fight against GBV.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),

            const SizedBox(height: 24),

            // What We Offer Section
            Text(
              'What We Offer',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildFeatureCard(
              context,
              Icons.article,
              'Educational Content',
              'Comprehensive articles and blog posts covering various aspects of GBV, from understanding warning signs to recovery and legal rights.',
            ),

            _buildFeatureCard(
              context,
              Icons.insights,
              'Real-Time Dashboard',
              'Data visualization and statistics to help understand the scope and trends of GBV in different communities.',
            ),

            _buildFeatureCard(
              context,
              Icons.support,
              'Support Resources',
              'Emergency hotlines, shelters, legal aid, and counseling services readily available when needed most.',
            ),

            _buildFeatureCard(
              context,
              Icons.safety_check,
              'Safe Environment',
              'A trauma-informed design that prioritizes user safety and emotional well-being.',
            ),

            const SizedBox(height: 24),

            // Our Values Section
            Text(
              'Our Values',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),

            _buildValueItem(
              context,
              'Compassion',
              'We approach every aspect of our work with empathy and understanding for survivors.',
            ),

            _buildValueItem(
              context,
              'Safety',
              'User safety and emotional well-being are our top priorities in design and content.',
            ),

            _buildValueItem(
              context,
              'Accuracy',
              'We provide reliable, well-researched information from credible sources.',
            ),

            _buildValueItem(
              context,
              'Accessibility',
              'Making support and information available to everyone, regardless of circumstances.',
            ),

            const SizedBox(height: 32),

            // Important Notice
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Icon(Icons.warning, color: Colors.orange[800]),
                      const SizedBox(width: 8),
                      Text(
                        'Important Notice',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Colors.orange[800],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'GBVInsights is an educational and support platform, not an emergency service. '
                    'If you are in immediate danger, please contact your local emergency services or GBV helpline immediately.',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Emergency: 10111 | GBV Helpline: 0800 428 428',
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Contact Information
            Text(
              'Get in Touch',
              style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                color: Colors.purple,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 16),
            Text(
              'Have questions, suggestions, or want to collaborate? '
              'Use our contact form to reach out to our team. We\'re always looking to improve and expand our resources.',
              style: Theme.of(context).textTheme.bodyLarge,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(
    BuildContext context,
    IconData icon,
    String title,
    String description,
  ) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12.0),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: Colors.purple, size: 32),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.purple,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildValueItem(
    BuildContext context,
    String title,
    String description,
  ) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 12.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(Icons.check_circle, color: Colors.purple, size: 20),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    color: Colors.purple,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  description,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
