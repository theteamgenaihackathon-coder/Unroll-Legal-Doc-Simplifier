import 'dart:convert';
import 'package:flutter/services.dart' show rootBundle;
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<Map<String, dynamic>> loadJsonData() async {
  final String jsonString = await rootBundle.loadString(
    'assets/jsons/temp.json',
  );
  final Map<String, dynamic> jsonData = json.decode(jsonString);

  return jsonData;
}

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
  const FirstPointCard({super.key});

  Future<String> getFirstPoint() async {
    final String jsonString = await rootBundle.loadString(
      'assets/jsons/temp.json',
    );
    final Map<String, dynamic> jsonData = json.decode(jsonString);

    return Document.fromJson(jsonData).sections[0].subsections[0].points[0];
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: getFirstPoint(),
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
