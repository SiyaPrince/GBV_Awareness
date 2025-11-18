import 'package:flutter/material.dart';
import 'package:gbv_awareness/common/widgets/app_page.dart';
import 'package:gbv_awareness/common/widgets/page_section.dart';
import 'package:gbv_awareness/common/widgets/testimonials.dart';

/// Simple local model used only on this page.
/// This avoids depending on any external Testimonial class.
class _TestimonialData {
  final String quote;
  final String attribution;
  final String? roleTag;

  const _TestimonialData({
    required this.quote,
    required this.attribution,
    this.roleTag,
  });
}

class TestimonialsPage extends StatelessWidget {
  const TestimonialsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return AppPage(
      title: "What People Say",
      subtitle:
          "Anonymous, safe-to-share reflections from those who have used the platform.",
      children: [_buildTestimonialSection(context), _buildSupportNoteSection()],
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 1: Testimonials Grid
  // ---------------------------------------------------------------------------

  Widget _buildTestimonialSection(BuildContext context) {
    const testimonials = <_TestimonialData>[
      _TestimonialData(
        quote:
            "This platform helped me understand my options without feeling overwhelmed. It felt calm and safe.",
        attribution: "Survivor, 29",
        roleTag: "Survivor",
      ),
      _TestimonialData(
        quote:
            "As a friend supporting someone facing GBV, the guidance here helped me say the right things.",
        attribution: "Lebo, 33",
        roleTag: "Ally",
      ),
      _TestimonialData(
        quote:
            "Our organisation uses the resources in training sessions. Clear, trauma-informed, and accessible.",
        attribution: "Community Worker",
        roleTag: "Organisation",
      ),
      _TestimonialData(
        quote:
            "The safety planning tool gave me structure when I was anxious. Small steps, gentle wording.",
        attribution: "User, 41",
      ),
    ];

    return PageSection(
      title: "Voices from our community",
      subtitle:
          "All testimonials are voluntary, anonymised, and approved for safe sharing.",
      child: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth > 800;
          final columns = isWide ? 2 : 1;

          return GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: testimonials.length,
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columns,
              crossAxisSpacing: 16,
              mainAxisSpacing: 16,
              childAspectRatio: isWide ? 1.6 : 1.8,
            ),
            itemBuilder: (context, index) {
              final t = testimonials[index];
              return TestimonialCard(
                quote: t.quote,
                attribution: t.attribution,
                roleTag: t.roleTag,
              );
            },
          );
        },
      ),
    );
  }

  // ---------------------------------------------------------------------------
  // SECTION 2: Safety & Authenticity Disclaimer
  // ---------------------------------------------------------------------------

  Widget _buildSupportNoteSection() {
    return PageSection(
      title: "A note on testimonials",
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: const Color(0xFFF9F8FF),
          borderRadius: BorderRadius.circular(16),
        ),
        child: const Text(
          "All stories shared here have been provided with explicit informed consent. "
          "No identifying details are included. Our goal is to uplift safe, supportive, "
          "and trauma-informed reflections from people who found value in the platform.",
          style: TextStyle(fontSize: 15, height: 1.5),
        ),
      ),
    );
  }
}
