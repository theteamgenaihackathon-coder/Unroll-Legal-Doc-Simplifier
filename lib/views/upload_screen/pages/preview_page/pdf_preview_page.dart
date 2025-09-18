import 'package:flutter/material.dart';
import 'package:pdfx/pdfx.dart';
import 'package:legal_doc_simplifier/views/upload_screen/overlays/divider.dart';

class PdfPreviewPage extends StatelessWidget {
  final String title;
  final PdfControllerPinch controller;
  final VoidCallback onNext;
  final VoidCallback onBack;

  const PdfPreviewPage({
    super.key,
    required this.title,
    required this.controller,
    required this.onNext,
    required this.onBack,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 30),
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 20),
        divider(),
        const SizedBox(height: 70),
        SizedBox(
          height: 400,
          width: double.infinity,
          child: PdfViewPinch(
            controller: controller,
            scrollDirection: Axis.vertical,
          ),
        ),
        const SizedBox(height: 70),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            ElevatedButton.icon(
              onPressed: onBack,
              icon: const Icon(Icons.arrow_back, color: Colors.pink),
              label: const Text('Back'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
            ),
            ElevatedButton.icon(
              onPressed: onNext,
              icon: const Icon(Icons.arrow_forward, color: Colors.pink),
              label: const Text('Continue'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
