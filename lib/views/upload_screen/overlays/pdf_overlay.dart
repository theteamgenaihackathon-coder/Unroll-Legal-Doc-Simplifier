import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/final_page.dart';
import 'package:pdfx/pdfx.dart';
import 'dart:io';
import 'pdf_preview_page.dart';
import '../pages/simplified_page/simplified_page.dart';

class PdfOverlay extends StatefulWidget {
  final OverlayEntry entry;
  final String title;
  final File pdfFile;

  const PdfOverlay({
    super.key,
    required this.entry,
    required this.title,
    required this.pdfFile,
  });

  @override
  State<PdfOverlay> createState() => _PagePdfOverlayState();
}

class _PagePdfOverlayState extends State<PdfOverlay> {
  late PdfControllerPinch _pdfController;
  int _currentPage = 0;

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
      widget.entry.remove();
    }
  }

  void _goBack() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    } else {
      widget.entry.remove();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      PdfPreviewPage(
        title: widget.title,
        controller: _pdfController,
        onNext: _goNext,
        onBack: _goBack,
      ),
      SimplifiedPage(
        onClose: () => widget.entry.remove(),
        pdfFile: widget.pdfFile,
      ),
      FinalPage(),
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
                height: 725,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(color: Colors.red, width: 2),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [pages[_currentPage], const SizedBox(height: 20)],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
