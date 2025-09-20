// missing_fields_screen.dart

import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:legal_doc_simplifier/network/gemini_requests.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/simplified_page/back_to_simplied_button.dart';
import 'missing_fields_model.dart';

class MissingFieldsScreen extends ConsumerWidget {
  const MissingFieldsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder<String>(
      future: fillRequest(), // Must return a Future<String> (JSON string)
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        } else if (snapshot.hasError) {
          return Scaffold(
            body: Center(child: Text('Error: ${snapshot.error}')),
          );
        } else if (snapshot.hasData && snapshot.data != null) {
          // Decode JSON safely
          final decoded = jsonDecode(snapshot.data!);
          // print(
          // "Gemini raw text: ${decoded["candidates"]?[0]?["content"]?["parts"]?[0]?["text"]}",
          // );

          final filled = jsonDecode(
            decoded["candidates"]?[0]?["content"]?["parts"]?[0]?["text"],
          );

          print(filled);
          final response = MissingFieldsResponse.fromJson(filled);

          return Column(
            children: [
              // 🔹 pass ref correctly
              Align(
                child: backToSimplifiedButton(ref),
                alignment: Alignment.topLeft,
              ),

              Expanded(
                child: response.missingFields.isEmpty
                    ? const Center(
                        child: Text(
                          "No Missing Blanks Found",
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      )
                    : ListView.builder(
                        padding: const EdgeInsets.all(12),
                        itemCount: response.missingFields.length,
                        itemBuilder: (context, index) {
                          final field = response.missingFields[index];
                          return Card(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            color: Colors.white,
                            elevation: 3,
                            margin: const EdgeInsets.symmetric(vertical: 8),
                            child: Padding(
                              padding: const EdgeInsets.all(16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "$index) ${field.example} [${field.field}]",
                                    style: const TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                  const SizedBox(height: 6),
                                  Text("Location: ${field.location}"),
                                  const SizedBox(height: 6),
                                  if (field.reason.isNotEmpty)
                                    Text("Reason: ${field.reason}"),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        } else {
          // Default fallback when no data
          return const Scaffold(body: Center(child: Text("No data available")));
        }
      },
    );
  }
}
