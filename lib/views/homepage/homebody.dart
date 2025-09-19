import 'dart:io';
import 'package:legal_doc_simplifier/views/upload_screen/overlays/pdf_overlay.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
// import 'dart:io';
import 'package:legal_doc_simplifier/views/homepage/camera_button.dart';
import 'package:legal_doc_simplifier/views/homepage/upload_button.dart';
import 'package:legal_doc_simplifier/views/homepage/homepage.dart';
// import 'package:legal_doc_simplifier/views/upload_screen/show_pdf_overlay.dart';
import 'package:legal_doc_simplifier/views/camera_screen/pdf_generator.dart';
import 'package:legal_doc_simplifier/views/upload_screen/pages/preview_page/pdf_preview_page.dart';

const Color ourRed = Color(0xFFC10547);

class HomeBody extends StatelessWidget {
  final void Function(File) onFilePicked;
  final void Function(File) onDoneCapturing;
  const HomeBody({
    super.key,
    required this.onFilePicked,
    required this.onDoneCapturing,
  });

  // const HomeBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 120,
            bottom: 40,
          ),

          child: SvgPicture.asset(
            'assets/images/bgimage2.svg',
            height: MediaQuery.of(context).size.height * 0.4,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: const Text(
            "GET STARTED WITH A DOCUMENT NOW !!!",
            style: TextStyle(fontFamily: "ComingSoon", fontSize: 18),
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            UploadButton(onFilePicked: onFilePicked),
            SizedBox(width: MediaQuery.of(context).size.width * 0.25),
            CameraButton(
              onDoneCapturing: onDoneCapturing,
              // (List<File> imageFiles) async {
              //   final pdfFile = await generatePdfToTemp(imageFiles);
              //   onFilePicked(pdfFile);

              //   if (pdfFile.existsSync()) {
              //     Navigator.push(
              //       context,
              //       MaterialPageRoute(
              //         builder: (_) => PdfPreviewPage(
              //           title: "Your PDF",
              //           onNext: _goNext,
              //           onBack: _goBack,
              //         ),
              //       ),
              //     );
              //   } else {
              //     ScaffoldMessenger.of(context).showSnackBar(
              //       const SnackBar(content: Text('PDF generation failed')),
              //     );
              //   }
              // },
            ),
          ],
        ),
      ],
    );
  }
}
