import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:legal_doc_simplifier/views/homepage/home_providers.dart';
import 'package:path_provider/path_provider.dart';
import 'package:pdfx/pdfx.dart';
import 'package:legal_doc_simplifier/views/upload_screen/divider.dart';

class PdfPreviewPage extends ConsumerWidget {
  final String title;

  const PdfPreviewPage({super.key, required this.title});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return FutureBuilder(
      future: getTemporaryDirectory(),
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return const Center(child: CircularProgressIndicator());
        }

        final filePath = '${snapshot.data!.path}/picked.pdf';
        final controller = PdfControllerPinch(
          document: PdfDocument.openFile(filePath),
        );

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
                  onPressed: () {
                    ref.read(currentPageProvider.notifier).state = 0;
                  },
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
                  onPressed: () {
                    ref.read(currentPageProvider.notifier).state = 2;
                  },
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
      },
    );
  }
}
