import 'dart:io';

import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/views/homepage/account_button_builder.dart';
import 'package:legal_doc_simplifier/views/homepage/homebody.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/final_page/final_page.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/preview_page/pdf_preview_page.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/simplified_page/simplified_page.dart';
import 'package:pdfx/pdfx.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late Widget _activeBody = HomeBody(onFilePicked: showPdfPreview);
  int _currentPage = 0;
  bool _isChatOpen = false;
  double _overlayHeight = 725;
  // late PdfControllerPinch _pdfController;

  List<Widget> get pages => [
    HomeBody(onFilePicked: showPdfPreview),
    PdfPreviewPage(title: "Your PDF", onNext: _goNext, onBack: _goBack),
    SimplifiedPage(
      onClose: () => setState(() => _currentPage = 0),
      onToggleChat: toggleChatMode,
    ),
    FinalPage(),
  ];

  void showPdfPreview(File pdfFile) {
    // final controller = PdfControllerPinch(
    //   document: PdfDocument.openFile(pdfFile.path),
    // );

    setState(() {
      _currentPage = 1;
    });
  }

  void toggleChatMode() {
    setState(() {
      _isChatOpen = !_isChatOpen;
      _overlayHeight = _isChatOpen ? 600 : 725; // shrink when chat opens
    });
  }

  void _goNext() {
    if (_currentPage < pages.length - 1) {
      setState(() => _currentPage++);
    }
  }

  void _goBack() {
    if (_currentPage > 0) {
      setState(() => _currentPage--);
    }
  }

  @override
  Widget build(BuildContext context) {
    // final pages = [
    //   PdfPreviewPage(
    //     // title: widget.title,
    //     title: "",
    //     // controller: _pdfController,
    //     onNext: _goNext,
    //     onBack: _goBack,
    //   ),
    //   SimplifiedPage(onClose: () {}, onToggleChat: toggleChatMode),
    //   FinalPage(),
    // ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 80,
        backgroundColor: Colors.white,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withAlpha(200),
        title: const Text("Unroll"),
        centerTitle: true,
        actions: [buildAccountButton()],
      ),

      // body: const HomeBody(),
      body: pages[_currentPage],
      backgroundColor: Colors.white,
    );
  }
}
