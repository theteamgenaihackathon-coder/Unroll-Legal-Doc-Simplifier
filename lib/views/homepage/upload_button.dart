import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/main.dart';
import 'package:legal_doc_simplifier/views/upload_screen/show_pdf_overlay.dart';
import 'package:path_provider/path_provider.dart';

IconButton uploadButton(BuildContext context) {
  return IconButton(
    icon: Icon(Icons.arrow_circle_up_rounded, size: 80, color: ourRed),
    onPressed: () async {
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
        final tempFile = await pickedFile.copy(tempPath);

        // print('PDF saved to temp: ${tempFile.path}');

        // Navigate to preview page
      } else {
        print('No file selected');
      }
    },
  );
}
