import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/upload_screen/example_button.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/final_page/final_page.dart';
import 'package:pdfx/pdfx.dart';
import 'dart:io';
import '../pages/preview_page/pdf_preview_page.dart';
import '../pages/simplified_page/simplified_page.dart';

class PagePdf extends StatefulWidget {
  final String title;
  final File pdfFile;
  final VoidCallback onClose; // optional if you want a back button

  const PagePdf({
    super.key,
    required this.title,
    required this.pdfFile,
    required this.onClose,
  });

  @override
  State<PagePdf> createState() => _PagePdfState();
}

class _PagePdfState extends State<PagePdf> {
  late PdfControllerPinch _pdfController;
  int _currentPage = 0;
  bool _isChatOpen = false;
  double _overlayHeight = 725;
  final TextEditingController _controller = TextEditingController();
  final FocusNode _focusNode = FocusNode();

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
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void toggleChatMode() {
    setState(() {
      _isChatOpen = !_isChatOpen;
      _overlayHeight = _isChatOpen ? 600 : 725; // shrink when chat opens
    });

    if (_isChatOpen) {
      Future.delayed(const Duration(milliseconds: 100), () {
        _focusNode.requestFocus();
      });
    } else {
      _focusNode.unfocus();
    }
  }

  void _goNext() {
    if (_currentPage < 2) {
      setState(() => _currentPage++);
    } else {
      widget.onClose();
    }
  }

  void _goBack() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    } else {
      widget.onClose();
    }
  }

  @override
  Widget build(BuildContext context) {
    final pages = [
      PdfPreviewPage(
        title: widget.title,
        // controller: _pdfController,
        onNext: _goNext,
        onBack: _goBack,
      ),
      SimplifiedPage(
        onClose: () => "",
        // pdfFile: widget.pdfFile,
        onToggleChat: toggleChatMode,
      ),
      FinalPage(),
    ];

    return Stack(
      children: [
        Padding(
          padding: const EdgeInsets.only(top: 150),
          child: Align(
            alignment: Alignment.topCenter,
            child: Material(
              elevation: 8,
              borderRadius: BorderRadius.circular(12),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.9,
                height: _overlayHeight,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  border: Border.all(
                    color: const Color.fromARGB(255, 227, 187, 194),
                    width: 2,
                  ),
                  borderRadius: BorderRadius.circular(12),
                ),
                child: Stack(
                  children: [
                    Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        pages[_currentPage],
                        const SizedBox(height: 20),
                        if (_isChatOpen) ...[
                          const Divider(),
                          Row(
                            children: [
                              Expanded(
                                child: TextField(
                                  focusNode: _focusNode,
                                  controller: _controller,
                                  decoration: InputDecoration(
                                    hintText: "Type your message...",
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                              IconButton(
                                icon: const Icon(Icons.send, color: ourRed),
                                onPressed: () {
                                  // handle send
                                },
                              ),
                            ],
                          ),
                        ],
                      ],
                    ),
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
