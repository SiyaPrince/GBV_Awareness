import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';
import 'package:gbv_awareness/common/widgets/faq_item.dart';
import 'package:gbv_awareness/common/widgets/page_section.dart';

/// Local model used only inside FAQ page
class _FaqData {
  final String question;
  final String answer;
  final String category;

  const _FaqData({
    required this.question,
    required this.answer,
    required this.category,
  });
}

class FAQPage extends StatelessWidget {
  const FAQPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: "Frequently Asked Questions",
      subtitle:
          "Clear, supportive answers to common questions about safety, privacy, and using the platform.",
      children: [
        _buildSafetySection(),
        _buildUsingPlatformSection(),
        _buildSupportSection(),
      ],
    );
  }

  // ---------------------------------------------------------------------------
  // CATEGORY 1: Safety & Privacy
  // ---------------------------------------------------------------------------

  Widget _buildSafetySection() {
    const safetyFaqs = <_FaqData>[
      _FaqData(
        category: "Safety & Privacy",
        question: "Do I need to create an account?",
        answer:
            "No. You can access all resources without creating an account or providing any personal information.",
      ),
      _FaqData(
        category: "Safety & Privacy",
        question: "Do you track or store my activity?",
        answer:
            "No. Your browsing is private. We do not collect sensitive information about what you view or save.",
      ),
      _FaqData(
        category: "Safety & Privacy",
        question: "Is my information shared with anyone?",
        answer:
            "Never. We do not share or sell any personal details. All interactions are anonymous.",
      ),
    ];

    return PageSection(
      title: "Safety & Privacy",
      subtitle: "Designed to protect you every step of the way.",
      child: Column(
        children: [
          for (final faq in safetyFaqs) ...[
            FaqItem(question: faq.question, answer: faq.answer),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CATEGORY 2: Using the platform
  // ---------------------------------------------------------------------------

  Widget _buildUsingPlatformSection() {
    const usingFaqs = <_FaqData>[
      _FaqData(
        category: "Using the Platform",
        question: "Can I find local support organisations here?",
        answer:
            "Yes. The Resource Finder shows nearby shelters, hotlines, legal services, and community organisations.",
      ),
      _FaqData(
        category: "Using the Platform",
        question: "Is the information verified?",
        answer:
            "Yes. All resources and articles are reviewed by experienced partners working in GBV support.",
      ),
      _FaqData(
        category: "Using the Platform",
        question: "Can I use this platform offline?",
        answer:
            "Key information such as safety tips and legal basics remain available with low or limited connectivity.",
      ),
    ];

    return PageSection(
      title: "Using the Platform",
      subtitle: "How to navigate features and resources easily.",
      child: Column(
        children: [
          for (final faq in usingFaqs) ...[
            FaqItem(question: faq.question, answer: faq.answer),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // CATEGORY 3: Getting Support
  // ---------------------------------------------------------------------------

  Widget _buildSupportSection() {
    const supportFaqs = <_FaqData>[
      _FaqData(
        category: "Support",
        question: "Can I talk to someone directly?",
        answer:
            "Yes. The platform provides contact details for trusted hotlines and organisations that offer live support.",
      ),
      _FaqData(
        category: "Support",
        question: "Can I use this to support a friend or family member?",
        answer:
            "Absolutely. There are dedicated guides for allies to help you respond safely and calmly.",
      ),
      _FaqData(
        category: "Support",
        question: "Does this replace professional help?",
        answer:
            "No. This platform complements professional services, offering guidance until you can reach trained support.",
      ),
    ];

    return PageSection(
      title: "Support Options",
      subtitle:
          "Guidance for getting help, whether for yourself or someone you care about.",
      child: Column(
        children: [
          for (final faq in supportFaqs) ...[
            FaqItem(question: faq.question, answer: faq.answer),
            const SizedBox(height: 12),
          ],
        ],
      ),
    );
  }
}
