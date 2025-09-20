import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/svg.dart';
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
    SvgPicture bgImage = SvgPicture.asset(
      'assets/images/bgimage2.svg',
      height: MediaQuery.of(context).size.height * 0.4,
    );

    const Text getStarted = Text(
      "GET STARTED WITH A DOCUMENT NOW !!!",
      style: TextStyle(fontFamily: "ComingSoon", fontSize: 18),
    );

    Row buttonRow = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        UploadButton(),
        SizedBox(width: MediaQuery.of(context).size.width * 0.25),
        CameraButton(),
      ],
    );

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            top: 120,
            bottom: 40,
          ),
          child: bgImage,
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: getStarted,
        ),
        buttonRow,
      ],
    );
  }
}
