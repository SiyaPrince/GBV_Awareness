import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HomeInsightsTeaserSection extends StatelessWidget {
  const HomeInsightsTeaserSection({super.key});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    const stats = [
      _InsightStat(label: "Reports logged\n", value: "240"),
      _InsightStat(label: "Support interactions\n", value: "95"),
      _InsightStat(label: "Articles & resources published\n", value: "24"),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "GBV insights at a glance",
          style: Theme.of(context).textTheme.headlineSmall?.copyWith(
            color: color.primary,
            fontWeight: FontWeight.w700,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          "These are demo indicators only. Real data always needs careful interpretation "
          "and context—it never represents the full story.",
          style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
        ),
        const SizedBox(height: 20),
        LayoutBuilder(
          builder: (context, constraints) {
            final isWide = constraints.maxWidth > 800;
            return Wrap(
              spacing: 16,
              runSpacing: 16,
              children: stats
                  .map(
                    (s) => SizedBox(
                      width: isWide
                          ? (constraints.maxWidth - 32) / 3
                          : constraints.maxWidth,
                      child: _InsightCard(stat: s),
                    ),
                  )
                  .toList(),
            );
          },
        ),
        const SizedBox(height: 16),
        TextButton.icon(
          onPressed: () => context.go('/dashboard'),
          icon: const Icon(Icons.bar_chart_outlined),
          label: const Text("View full dashboard"),
        ),
      ],
    );
  }
}

class _InsightStat {
  final String label;
  final String value;

  const _InsightStat({required this.label, required this.value});
}

class _InsightCard extends StatelessWidget {
  final _InsightStat stat;

  const _InsightCard({required this.stat});

  @override
  Widget build(BuildContext context) {
    final color = Theme.of(context).colorScheme;

    return Card(
      elevation: 1,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              stat.value,
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                color: color.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              stat.label,
              style: Theme.of(
                context,
              ).textTheme.bodyMedium?.copyWith(height: 1.4),
            ),
          ],
        ),
      ),
    );
  }
}

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:go_router/go_router.dart';

// /// Simple model for a metric coming from Firestore.
// /// Collection: `metrics`
// /// Expected fields:
// ///   - label: string
// ///   - value: string or number
// class InsightMetric {
//   final String id;
//   final String label;
//   final String value;

//   InsightMetric({required this.id, required this.label, required this.value});

//   factory InsightMetric.fromDoc(DocumentSnapshot<Map<String, dynamic>> doc) {
//     final data = doc.data() ?? {};
//     return InsightMetric(
//       id: doc.id,
//       label: (data['label'] as String?) ?? 'Unnamed metric',
//       value: (data['value'] ?? '--').toString(),
//     );
//   }
// }

// class HomeInsightsTeaserSection extends StatelessWidget {
//   const HomeInsightsTeaserSection({super.key});

//   @override
//   Widget build(BuildContext context) {
//     final color = Theme.of(context).colorScheme;

//     return Column(
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Text(
//           "GBV insights at a glance",
//           style: Theme.of(context).textTheme.headlineSmall?.copyWith(
//             color: color.primary,
//             fontWeight: FontWeight.w700,
//           ),
//         ),
//         const SizedBox(height: 8),
//         Text(
//           "These indicators are sample data to help demonstrate how GBV-related "
//           "trends could be visualised. Real data always needs careful interpretation.",
//           style: Theme.of(context).textTheme.bodyMedium?.copyWith(height: 1.5),
//         ),
//         const SizedBox(height: 20),

//         // --------------------------------------------------------------------
//         // Firestore metrics stream
//         // --------------------------------------------------------------------
//         StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
//           stream: FirebaseFirestore.instance
//               .collection('metrics')
//               .limit(3)
//               .snapshots(),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState == ConnectionState.waiting &&
//                 !snapshot.hasData) {
//               return const Center(
//                 child: Padding(
//                   padding: EdgeInsets.all(16),
//                   child: CircularProgressIndicator(),
//                 ),
//               );
//             }

//             if (snapshot.hasError) {
//               return Padding(
//                 padding: const EdgeInsets.all(16),
//                 child: Text(
//                   'Unable to load metrics right now.',
//                   style: TextStyle(color: color.error),
//                 ),
//               );
//             }

//             final docs = snapshot.data?.docs ?? [];
//             final metrics = docs.map((d) => InsightMetric.fromDoc(d)).toList();

//             if (metrics.isEmpty) {
//               return const Padding(
//                 padding: EdgeInsets.all(16),
//                 child: Text(
//                   'No metrics available yet. Once metrics are added in Firestore, '
//                   'they will appear here automatically.',
//                 ),
//               );
//             }

//             return LayoutBuilder(
//               builder: (context, constraints) {
//                 final isWide = constraints.maxWidth > 800;
//                 return Wrap(
//                   spacing: 16,
//                   runSpacing: 16,
//                   children: metrics
//                       .map(
//                         (m) => SizedBox(
//                           width: isWide
//                               ? (constraints.maxWidth - 32) / 3
//                               : constraints.maxWidth,
//                           child: _InsightCard(metric: m),
//                         ),
//                       )
//                       .toList(),
//                 );
//               },
//             );
//           },
//         ),

//         const SizedBox(height: 16),
//         TextButton.icon(
//           onPressed: () => context.go('/dashboard'),
//           icon: const Icon(Icons.bar_chart_outlined),
//           label: const Text("View full dashboard"),
//         ),
//       ],
//     );
//   }
// }

// class _InsightCard extends StatelessWidget {
//   final InsightMetric metric;

//   const _InsightCard({required this.metric});

//   @override
//   Widget build(BuildContext context) {
//     final color = Theme.of(context).colorScheme;

//     return Card(
//       elevation: 1,
//       child: Padding(
//         padding: const EdgeInsets.all(16),
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               metric.value,
//               style: Theme.of(context).textTheme.headlineMedium?.copyWith(
//                 color: color.primary,
//                 fontWeight: FontWeight.w700,
//               ),
//             ),
//             const SizedBox(height: 8),
//             Text(
//               metric.label,
//               style: Theme.of(
//                 context,
//               ).textTheme.bodyMedium?.copyWith(height: 1.4),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
