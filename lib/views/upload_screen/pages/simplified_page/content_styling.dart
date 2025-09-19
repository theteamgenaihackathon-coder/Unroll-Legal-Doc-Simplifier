import 'package:flutter/material.dart';

class SectionWidget extends StatelessWidget {
  final Map<String, dynamic> section;

  const SectionWidget({super.key, required this.section});

  @override
  Widget build(BuildContext context) {
    final heading = section['heading'] ?? '';
    final subsections = section['subsections'] as List<dynamic>? ?? [];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          heading,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        for (final subsection in subsections)
          SubsectionWidget(subsection: subsection as Map<String, dynamic>),
        const SizedBox(height: 16),
      ],
    );
  }
}

class SubsectionWidget extends StatelessWidget {
  final Map<String, dynamic> subsection;

  const SubsectionWidget({super.key, required this.subsection});

  @override
  Widget build(BuildContext context) {
    final subheading = subsection['subheading'] ?? '';
    final points = subsection['points'] as List<dynamic>? ?? [];

    return Padding(
      padding: const EdgeInsets.only(left: 16.0, bottom: 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            subheading,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 6),
          for (final point in points) BulletPoint(text: point.toString()),
        ],
      ),
    );
  }
}

class BulletPoint extends StatelessWidget {
  final String text;

  const BulletPoint({super.key, required this.text});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 12.0, bottom: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('• ', style: TextStyle(fontSize: 14)),
          Expanded(child: Text(text, style: const TextStyle(fontSize: 14))),
        ],
      ),
    );
  }
}
