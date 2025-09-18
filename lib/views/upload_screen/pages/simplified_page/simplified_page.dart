import 'dart:io';
import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/simplified_page/scroll_view.dart';
import 'package:legal_doc_simplifier/views/homepage/back_button.dart';
import 'package:legal_doc_simplifier/views/upload_screen/overlays/divider.dart';

class SimplifiedPage extends StatelessWidget {
  final VoidCallback onClose;
  final File pdfFile;

  const SimplifiedPage({
    super.key,
    required this.onClose,
    required this.pdfFile,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(height: 20),
        Stack(
          alignment: Alignment.center,
          children: [
            const Text(
              'Simplified',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Align(alignment: Alignment.centerLeft, child: backButton(onClose)),
          ],
        ),
        divider(),
        // const SizedBox(height: 70),
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: SizedBox(
            height:
                MediaQuery.of(context).size.height *
                0.6, // or any scrollable height
            child: SimplifiedDocView(pdfFile: pdfFile),
            // child: SingleChildScrollView(
            //   child: SimplifiedJson(pdfFile: pdfFile),
          ),
        ),
      ],
    );
  }
}
