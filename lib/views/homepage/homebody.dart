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
      height: MediaQuery.of(context).size.height * 0.36,
      // width: MediaQuery.of(context).size.width * 0.01,
    );

    const Text getStarted = Text(
      "GET STARTED WITH A DOCUMENT NOW !!!",
      style: TextStyle(fontFamily: "ComingSoon", fontSize: 18),
      textAlign: TextAlign.center,
    );

    Row buttonRow = Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [UploadButton(), CameraButton()],
    );

    return SafeArea(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Padding(
            padding: EdgeInsets.only(
              top: MediaQuery.of(context).size.width * 0.2,
            ),
            child: bgImage,
          ),
          Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width * 0.05,
            ),
            child: getStarted,
          ),
          buttonRow,
        ],
      ),
    );
  }
}
