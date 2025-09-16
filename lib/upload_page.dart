import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/buttons.dart';
import 'dart:io';
import 'package:pdfx/pdfx.dart';

/// Call this from wherever you want to show the overlay:
void showMultiPagePdfOverlay(
  BuildContext context, {
  required String title,
  required File pdfFile,
}) {
  final overlay = Overlay.of(context)!;
  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (_) =>
        _MultiPagePdfOverlay(entry: entry, title: title, pdfFile: pdfFile),
  );

  overlay.insert(entry);
}

class _MultiPagePdfOverlay extends StatefulWidget {
  final OverlayEntry entry;
  final String title;
  final File pdfFile;

  const _MultiPagePdfOverlay({
    Key? key,
    required this.entry,
    required this.title,
    required this.pdfFile,
  }) : super(key: key);

  @override
  State<_MultiPagePdfOverlay> createState() => _MultiPagePdfOverlayState();
}

class _MultiPagePdfOverlayState extends State<_MultiPagePdfOverlay> {
  late PdfControllerPinch _pdfController;
  int _currentPage = 0; // 0,1,2 → which child to show

  @override
  void initState() {
    super.initState();
    _pdfController = PdfControllerPinch(
      document: PdfDocument.openFile(widget.pdfFile.path),
    );
  }

  @override
  void dispose() {
    _pdfController.dispose();
    super.dispose();
  }

  void _goNext() {
    if (_currentPage < 2) {
      setState(() => _currentPage++);
    } else {
      // on last page, just close
      widget.entry.remove();
    }
  }

  void _goBack() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    } else {
      // on first page, close the overlay
      widget.entry.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    // Define your three “pages”
    final pages = <Widget>[
      // ─── Page 0: PDF Preview ─────────────────────────────────────
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SizedBox(height: 50),
          Text(
            widget.title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              height: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Divider(
            height: 4,
            thickness: 2,
            indent: 20,
            endIndent: 20,
            color: Color.fromARGB(100, 227, 117, 117),
          ),
          const SizedBox(height: 70),
          SizedBox(
            height: 400,
            width: double.infinity,
            child: PdfViewPinch(
              controller: _pdfController,
              scrollDirection: Axis.vertical,
              onDocumentLoaded: (doc) => print('PDF loaded'),
              onPageChanged: (page) => print('Page changed to $page'),
            ),
          ),
          SizedBox(height: 70),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ElevatedButton.icon(
                onPressed: _goBack,
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
                onPressed: _goNext,
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
      ),

      // ─── Page 1: Simplified ───────────────────────────────────────
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              backButton(() {
                widget.entry.remove();
              }),
              SizedBox(width: 20),
              Container(
                child: Text(
                  'Simplified',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // Replace with your actual simplified content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Text(
              'Here you can show a simplified version of the PDF, '
              'or any other custom UI you need.',
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),

      // ─── Page 2: example ────────────────────────────
      Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'All Set!',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 10),
          Text('You’ve reviewed both views. Tap Continue to finish.'),
        ],
      ),
    ];

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 90),
          child: Center(
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: 725, // fixed height
                padding: EdgeInsets.only(
                  top: 0, // 24 pixels of padding at the top
                  left: 16, // maintain side padding
                  right: 16, // maintain bottom padding
                ),

                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),

                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // The dynamic page content
                    pages[_currentPage],
                    const SizedBox(height: 20),

                    // Back / Continue buttons
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
