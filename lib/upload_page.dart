import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/buttons.dart';
import 'dart:io';
import 'package:pdfx/pdfx.dart';

void showUploadOverlay(BuildContext context, String title, File pdfFile) {
  final overlay = Overlay.of(context);
  final pdfPinchController = PdfControllerPinch(
    document: PdfDocument.openFile(pdfFile.path),
  );

  late OverlayEntry entry;

  entry = OverlayEntry(
    builder: (context) => Stack(
      children: [
        Positioned(
          top: 140,
          left: 20,
          right: 20,
          child: Material(
            elevation: 8,
            borderRadius: BorderRadius.circular(12),
            child: Container(
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: const Color.fromARGB(255, 255, 255, 255),
                border: Border.all(color: Colors.red, width: 2.0),
                borderRadius: BorderRadius.circular(12),
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    title,
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      height: 1.2,
                    ),
                  ),
                  SizedBox(height: 10),
                  Divider(
                    height: 4,
                    thickness: 2,
                    indent: 20,
                    endIndent: 20,
                    color: Color.fromARGB(100, 227, 117, 117),
                  ),
                  SizedBox(
                    height: 600,
                    width: double.infinity, // Optional: match parent width
                    child: PdfViewPinch(
                      controller: pdfPinchController,
                      scrollDirection: Axis.vertical,
                      onDocumentLoaded: (doc) => print('PDF loaded'),
                      onPageChanged: (page) => print('Page changed to $page'),
                    ),
                  ),
                  // SizedBox(height: 0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          entry.remove();
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 24,
                          color: Colors.pink,
                        ),
                        label: Text('Back'),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      SizedBox(width: 60), // spacing between buttons
                      ElevatedButton.icon(
                        onPressed: () {},
                        label: Text('Continue'),
                        icon: Icon(
                          Icons.arrow_forward,
                          size: 24,
                          color: Colors.pink,
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: const Color.fromARGB(
                            255,
                            255,
                            255,
                            255,
                          ),
                          padding: EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                          textStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    ),
  );
  overlay.insert(entry);
}
