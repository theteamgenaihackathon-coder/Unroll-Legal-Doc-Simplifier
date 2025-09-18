import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legal_doc_simplifier/views/homepage/camera_button.dart';
import 'package:legal_doc_simplifier/views/homepage/upload_button.dart';

const Color ourRed = Color(0xFFC10547);

class HomeBody extends StatelessWidget {
  final void Function(File) onFilePicked;
  const HomeBody({super.key, required this.onFilePicked});

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
              onPressed: () async {
                final pickedFile = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (pickedFile != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: const Text("Image captured!")),
                  );
                  // You can also store or navigate with the image here
                }
              },
            ),
          ],
        ),
      ],
    );
  }
}
