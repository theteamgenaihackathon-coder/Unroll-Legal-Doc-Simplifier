// Probably not going to use this file

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/network/gemini_requests.dart';

class Document {
  final String title;
  final List<Section> sections;

  Document({required this.title, required this.sections});

  factory Document.fromJson(Map<String, dynamic> json) {
    return Document(
      title: json['title'],
      sections: (json['sections'] as List)
          .map((s) => Section.fromJson(s))
          .toList(),
    );
  }
}

class Section {
  final String heading;
  final List<Subsection> subsections;

  Section({required this.heading, required this.subsections});

  factory Section.fromJson(Map<String, dynamic> json) {
    return Section(
      heading: json['heading'],
      subsections: (json['subsections'] as List)
          .map((s) => Subsection.fromJson(s))
          .toList(),
    );
  }
}

class Subsection {
  final String subheading;
  final List<String> points;

  Subsection({required this.subheading, required this.points});

  factory Subsection.fromJson(Map<String, dynamic> json) {
    return Subsection(
      subheading: json['subheading'],
      points: List<String>.from(json['points']),
    );
  }
}

class FirstPointCard extends StatelessWidget {
  final File pdfFile;

  const FirstPointCard({super.key, required this.pdfFile});

  Future<String> getFirstPoint(File pdfFile) async {
    final String jsonString = await simplifyDocRequest(pdfFile);
    return jsonString;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getFirstPoint(pdfFile),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        return Card(
          margin: const EdgeInsets.all(16),
          elevation: 4,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Text(
              snapshot.data ?? 'No data',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        );
      },
    );
  }
}
