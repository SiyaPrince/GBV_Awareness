import 'package:flutter/material.dart';

class PrivacyPolicyPage extends StatelessWidget {
  const PrivacyPolicyPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Privacy Policy',
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: colorScheme.primary,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Last Updated: January 2024',
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: colorScheme.onSurface.withAlpha((0.6 * 255).round()),
              fontStyle: FontStyle.italic,
            ),
          ),
          const SizedBox(height: 24),

          // Sections
          _buildSection(
            context,
            '1. Introduction',
            'GBVInsights ("we," "our," or "us") is committed to protecting your privacy. '
                'This Privacy Policy explains how we collect, use, disclose, and safeguard your information '
                'when you use our GBVInsights application.',
          ),
          _buildSection(
            context,
            '2. Information We Collect',
            'We may collect limited personal information that you voluntarily provide to us, including:\n\n'
                '• Name and contact information when you use our contact form\n'
                '• Messages and inquiries you send to us\n\n'
                'We automatically collect certain information when you use our application:\n\n'
                '• Device information\n'
                '• Usage statistics\n'
                '• Browser type and version',
          ),
          _buildSection(
            context,
            '3. How We Use Your Information',
            'We use the information we collect to:\n\n'
                '• Provide and maintain our services\n'
                '• Respond to your inquiries and provide support\n'
                '• Improve our application and user experience\n'
                '• Ensure the security of our platform',
          ),
          _buildSection(
            context,
            '4. Data Security',
            'We implement appropriate security measures to protect your personal information. '
                'However, no method of transmission over the Internet is 100% secure, and we cannot guarantee absolute security.',
          ),
          _buildSection(
            context,
            '5. Third-Party Services',
            'Our application may contain links to third-party websites or services. '
                'We are not responsible for the privacy practices of these third parties.',
          ),
          _buildSection(
            context,
            '6. Your Rights',
            'You have the right to:\n\n'
                '• Access your personal information\n'
                '• Correct inaccurate information\n'
                '• Request deletion of your information\n'
                '• Object to processing of your information',
          ),
          _buildSection(
            context,
            '7. Contact Us',
            'If you have questions about this Privacy Policy, please contact us through our contact form.',
          ),
          _buildSection(
            context,
            '8. Changes to This Policy',
            'We may update this Privacy Policy from time to time. '
                'We will notify you of any changes by posting the new policy on this page.',
          ),

          const SizedBox(height: 32),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16.0),
            decoration: BoxDecoration(
              color: colorScheme.secondary.withAlpha((0.1 * 255).round()),
              borderRadius: BorderRadius.circular(8.0),
            ),
            child: Text(
              'Your privacy and safety are important to us. We handle all personal information with care and respect.',
              style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                fontStyle: FontStyle.italic,
                color: colorScheme.onSurface,
              ),
              textAlign: TextAlign.center,
            ),
          ),
        ],
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
