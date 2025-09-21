import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
// import 'dart:io';
import 'package:legal_doc_simplifier/views/homepage/camera_button.dart';
import 'package:legal_doc_simplifier/views/homepage/upload_button.dart';
// import 'package:legal_doc_simplifier/views/upload_screen/show_pdf_overlay.dart';

const Color ourRed = Color(0xFFC10547);

class HomeBody extends ConsumerWidget {
  const HomeBody({super.key});

  // const HomeBody({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final getStarted = Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          "Get Started With a",
          style: GoogleFonts.poppins(
            fontSize: 22,
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
        Text(
          "Document Now !!!",
          style: GoogleFonts.poppins(
            fontSize: 22, // Match the top line
            fontWeight: FontWeight.w600,
            color: const Color.fromARGB(255, 255, 255, 255),
          ),
        ),
      ],
    );

    Row buttonRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [UploadButton(), CameraButton()],
    );

    return SafeArea(
      child: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              'assets/images/HomePageBG.png',
              fit: BoxFit.cover,
            ),
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Padding(
                padding: EdgeInsets.only(
                  bottom: 25, // Moves text up from the bottom
                  left: MediaQuery.of(context).size.width * 0.05,
                  right: MediaQuery.of(context).size.width * 0.05,
                ),
                child: getStarted,
              ),

              buttonRow,
            ],
          ),
        ],
      ),
    );
  }
}
