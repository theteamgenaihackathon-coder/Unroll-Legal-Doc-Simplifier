import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/main.dart';
import 'package:path_provider/path_provider.dart';

class UploadButton extends StatelessWidget {
  final void Function(File) onFilePicked;
  const UploadButton({super.key, required this.onFilePicked});

  Future<void> _handleUpload(BuildContext context) async {
    // Picking File
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final pickedFile = File(result.files.single.path!);
      onFilePicked(pickedFile);

      // PagePdf(title: "Your PDF", pdfFile: pickedFile, onClose: () => {});

      // Save to temp directory
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/picked.pdf';
      await pickedFile.copy(tempPath);
    } else {
      debugPrint('No file selected');
    }
  }

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_circle_up_rounded, size: 80, color: ourRed),
      onPressed: () => _handleUpload(context),
    );
  }
}
