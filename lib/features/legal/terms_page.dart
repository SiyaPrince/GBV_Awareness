import 'package:flutter/material.dart';

class TermsPage extends StatelessWidget {
  const TermsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Terms and Conditions'),
        backgroundColor: colorScheme.primary,
        foregroundColor: colorScheme.onPrimary,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Terms and Conditions',
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: colorScheme.primary,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Last Updated: January 2024',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                color: colorScheme.onSurface.withOpacity(0.6),
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(height: 24),

            _buildSection(
              context,
              '1. Acceptance of Terms',
              'By accessing and using GBVInsights ("the Application"), you accept and agree to be bound by these Terms and Conditions.',
            ),

            _buildSection(
              context,
              '2. Use of the Application',
              '2.1 Eligibility\n'
                  'You must be at least 18 years old to use this Application, or have parental consent if under 18.\n\n'
                  '2.2 Appropriate Use\n'
                  'You agree to use the Application only for lawful purposes and in a way that does not infringe the rights of others.\n\n'
                  '2.3 Prohibited Activities\n'
                  'You may not:\n'
                  '• Use the Application for any illegal purpose\n'
                  '• Harass, abuse, or harm another person\n'
                  '• Interfere with the proper working of the Application\n'
                  '• Attempt to gain unauthorized access to any part of the Application',
            ),

            _buildSection(
              context,
              '3. Emergency Situations',
              '3.1 Not an Emergency Service\n'
                  'GBVInsights is not an emergency service. In case of emergency, please contact:\n'
                  '• Police: 10111\n'
                  '• GBV Command Centre: 0800 428 428\n'
                  '• Your local emergency services\n\n'
                  '3.2 Crisis Situations\n'
                  'If you are in immediate danger, please contact emergency services immediately.',
            ),

            _buildSection(
              context,
              '4. Intellectual Property',
              'All content, features, and functionality of the Application are owned by GBVInsights '
                  'and are protected by copyright and other intellectual property laws.',
            ),

            _buildSection(
              context,
              '5. Disclaimer of Warranties',
              'The Application is provided "as is" without warranties of any kind. We do not guarantee that:\n'
                  '• The Application will be available at all times\n'
                  '• The information provided is completely accurate or current\n'
                  '• The Application will meet all your requirements',
            ),

            _buildSection(
              context,
              '6. Limitation of Liability',
              'To the fullest extent permitted by law, GBVInsights shall not be liable for any indirect, '
                  'incidental, special, or consequential damages resulting from your use of the Application.',
            ),

            _buildSection(
              context,
              '7. Support Resources',
              'While we provide information about support services, we are not responsible for:\n'
                  '• The quality of services provided by third-party organizations\n'
                  '• Outcomes resulting from contacting these organizations\n'
                  '• Any charges or fees associated with third-party services',
            ),

            _buildSection(
              context,
              '8. Changes to Terms',
              'We reserve the right to modify these terms at any time. '
                  'Continued use of the Application after changes constitutes acceptance of the modified terms.',
            ),

            _buildSection(
              context,
              '9. Governing Law',
              'These Terms shall be governed by the laws of South Africa.',
            ),

            _buildSection(
              context,
              '10. Contact Information',
              'For questions about these Terms, please use our contact form within the Application.',
            ),

            const SizedBox(height: 32),
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.orange.withOpacity(0.1),
                border: Border.all(color: Colors.orange),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Column(
                children: [
                  Icon(Icons.warning, size: 40, color: Colors.orange),
                  const SizedBox(height: 8),
                  Text(
                    'Important Safety Notice',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      color: Colors.orange,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'This application provides support resources and information, '
                    'but is not a substitute for professional help or emergency services. '
                    'If you are in immediate danger, please contact emergency services.',
                    textAlign: TextAlign.center,
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

  Widget _buildSection(BuildContext context, String title, String content) {
    final colorScheme = Theme.of(context).colorScheme;

    return Padding(
      padding: const EdgeInsets.only(bottom: 24.0),
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
            content,
            style: Theme.of(
              context,
            ).textTheme.bodyLarge?.copyWith(color: colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}
