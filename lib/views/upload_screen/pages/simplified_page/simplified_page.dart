import 'dart:io';
import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/upload_screen/example_button.dart';
import 'package:legal_doc_simplifier/views/upload_screen/language_button.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/simplified_page/scroll_view.dart';
import 'package:legal_doc_simplifier/views/homepage/back_button.dart';
import 'package:legal_doc_simplifier/views/upload_screen/overlays/divider.dart';
import 'package:path_provider/path_provider.dart';

class SimplifiedPage extends StatefulWidget {
  final VoidCallback onClose;
  // final File pdfFile;
  final VoidCallback onToggleChat;

  const SimplifiedPage({
    super.key,
    required this.onClose,
    // required this.pdfFile,
    required this.onToggleChat,
  });

  @override
  State<SimplifiedPage> createState() => _SimplifiedPageState();
}

class _SimplifiedPageState extends State<SimplifiedPage> {
  double docHeightFactor = 0.6;

  void shrinkDocView() {
    setState(() {
      docHeightFactor = (docHeightFactor == 0.6) ? 0.4 : 0.6;
    });
    widget.onToggleChat(); // still triggers overlay shrink
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: getTemporaryDirectory(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }
        final filePath = '${snapshot.data!.path}/picked.pdf';
        return Stack(
          children: [
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const SizedBox(height: 20),
                Stack(
                  alignment: Alignment.center,
                  children: [
                    const Text(
                      'Simplified',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: backButton(widget.onClose),
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          chooseLanguageButton(),
                          exampleButton(shrinkDocView),
                        ],
                      ),
                    ),
                  ],
                ),
                divider(),
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: SizedBox(
                    height:
                        MediaQuery.of(context).size.height * docHeightFactor,
                    child: SimplifiedDocView(pdfFile: File(filePath)),
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
