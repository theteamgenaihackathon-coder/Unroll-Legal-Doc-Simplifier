import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/homepage/back_button.dart';
import 'package:legal_doc_simplifier/views/upload_screen/divider.dart';

class SimplifiedPage extends StatelessWidget {
  final VoidCallback onClose;

  const SimplifiedPage({super.key, required this.onClose});

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
        const SizedBox(height: 70),
        const Padding(
          padding: EdgeInsets.all(16.0),
          child: Text(
            "", // You can stream or inject simplified text here
            textAlign: TextAlign.center,
          ),
        ),
      ],
    );
  }
}
