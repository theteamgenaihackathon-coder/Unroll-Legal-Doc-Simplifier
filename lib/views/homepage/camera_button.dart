import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:legal_doc_simplifier/views/camera_screen/pdf_generator.dart';

const Color ourRed = Color(0xFFC10547);

class CameraButton extends StatelessWidget {
  final Function(File) onDoneCapturing;

  const CameraButton({super.key, required this.onDoneCapturing});

  void cameraPreviewPage(List<File> imageFiles) async {
    final pdfFile = await generatePdfToTemp(imageFiles);
    //   onDoneCapturing(pdfFile);

    if (pdfFile.existsSync()) {
      onDoneCapturing(pdfFile);
      // Navigator.push(
      //   context,
      //   MaterialPageRoute(
      //     builder: (_) => PdfPreviewPage(
      //       title: "Your PDF",
      //       onNext: _goNext,
      //       onBack: _goBack,
      //     ),
      //   ),
      // );
    } else {
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('PDF generation failed')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(Icons.camera_alt_rounded, color: ourRed, size: 80),
      onPressed: () async {
        final picker = ImagePicker();
        final List<File> capturedImages = [];
        bool capturing = true;

        while (capturing) {
          final pickedFile = await picker.pickImage(source: ImageSource.camera);
          if (pickedFile != null) {
            final imageFile = File(pickedFile.path);
            capturedImages.add(imageFile);
          } else {
            capturing = false;
            break;
          }

          capturing =
              await showDialog<bool>(
                context: context,
                builder: (ctx) => AlertDialog(
                  title: const Text('Add another image?'),
                  actions: [
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, false),
                      child: const Text('No'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.pop(ctx, true),
                      child: const Text('Yes'),
                    ),
                  ],
                ),
              ) ??
              false;
        }

        if (capturedImages.isNotEmpty) {
          cameraPreviewPage(capturedImages);
        }
      },
    );
  }
}
