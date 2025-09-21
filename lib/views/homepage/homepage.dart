import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:legal_doc_simplifier/views/homepage/home_providers.dart';
import 'package:legal_doc_simplifier/views/homepage/homebody.dart';
import 'package:legal_doc_simplifier/views/homepage/menu_popup.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/final_page/final_page.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/missing_fields_page/missing_fields_screen.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/preview_page/pdf_preview_page.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/simplified_page/simplified_page.dart';

class HomePage extends ConsumerStatefulWidget {
  const HomePage({super.key});

  @override
  ConsumerState<HomePage> createState() => _HomePageState();
}

class _HomePageState extends ConsumerState<HomePage> {
  @override
  Widget build(BuildContext context) {
    final pages = [
      HomeBody(),
      PdfPreviewPage(title: "Your PDF"),
      SimplifiedPage(),
      MissingFieldsScreen(),
      FinalPage(),
    ];

    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.width * 0.2,
        backgroundColor: const Color.fromARGB(255, 239, 144, 154), // light
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        surfaceTintColor: Colors.transparent,
        elevation: 2,
        shadowColor: Colors.black.withAlpha(200),
        title: Text(
          'UNROLL',
          style: GoogleFonts.poppins(
            fontSize: 40,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ),
      body: pages[ref.watch(currentPageProvider)],
      backgroundColor: Colors.white,
    );
  }
}
