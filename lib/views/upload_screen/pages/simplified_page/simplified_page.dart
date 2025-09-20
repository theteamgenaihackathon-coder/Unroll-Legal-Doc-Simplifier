import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:legal_doc_simplifier/views/upload_screen/example_button.dart';
import 'package:legal_doc_simplifier/views/upload_screen/language_button.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/simplified_page/scroll_view.dart';
import 'package:legal_doc_simplifier/views/homepage/back_to_home_button.dart';
import 'package:legal_doc_simplifier/views/upload_screen/divider.dart';
import 'package:path_provider/path_provider.dart';

class SimplifiedPage extends ConsumerStatefulWidget {
  const SimplifiedPage({super.key});

  @override
  ConsumerState<SimplifiedPage> createState() => _SimplifiedPageState();
}

class _SimplifiedPageState extends ConsumerState<SimplifiedPage> {
  double docHeightFactor = 0.6;
  Map<String, dynamic>? _docJson;

  void updateDoc(Map<String, dynamic> newDoc) {
    setState(() {
      _docJson = newDoc;
    });
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
                      child: backToHomeButton(ref), // use ref directly
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          exampleButton(ref),
                          ChooseLanguageButton(onTranslationSuccess: updateDoc),
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
                    child: SimplifiedDocView(
                      pdfFile: File(filePath),
                      overrideDocJson: _docJson,
                    ),
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
