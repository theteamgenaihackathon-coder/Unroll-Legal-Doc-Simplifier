import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/main.dart';
import 'package:legal_doc_simplifier/views/upload_screen/overlays/show_pdf_overlay.dart';
import 'package:path_provider/path_provider.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({super.key});

  Future<void> _handleUpload(BuildContext context) async {
    final result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );

    if (result != null && result.files.single.path != null) {
      final pickedFile = File(result.files.single.path!);

      // Show overlay
      showPdfOverlay(context, title: 'Confirm PDF', pdfFile: pickedFile);

      // Save to temp directory
      final tempDir = await getTemporaryDirectory();
      final tempPath = '${tempDir.path}/${pickedFile.uri.pathSegments.last}';
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
