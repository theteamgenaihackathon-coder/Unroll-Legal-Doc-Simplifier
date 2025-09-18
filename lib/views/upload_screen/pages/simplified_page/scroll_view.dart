import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/network/gemini_requests.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/simplified_page/extract_text.dart';
import 'content_styling.dart';

class SimplifiedDocView extends StatelessWidget {
  final File pdfFile;

  const SimplifiedDocView({super.key, required this.pdfFile});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: simplifyDocRequest(pdfFile),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }

        final String simplifiedJsonString = extractTextFromJson(
          snapshot.data ?? 'No Data',
        );

        final Map<String, dynamic> jsonObject = jsonDecode(
          simplifiedJsonString,
        );
        final title = jsonObject['title'] ?? 'Untitled';
        final sections = jsonObject['sections'] as List<dynamic>? ?? [];

        return SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              for (final section in sections)
                SectionWidget(section: section as Map<String, dynamic>),
            ],
          ),
        );
      },
    );
  }
}
