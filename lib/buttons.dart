import 'package:flutter/material.dart';
import 'package:legal_doc_simplifier/upload_page.dart';
// import 'package:legal_doc_simplifier/main.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';
import 'package:path_provider/path_provider.dart';

const Color ourRed = Color(0xFFC10547);

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
        showUploadOverlay(context, 'confirm PDF', pickedFile);

        // Save to temp directory
        final tempDir = await getTemporaryDirectory();
        final tempPath = '${tempDir.path}/${pickedFile.uri.pathSegments.last}';
        final tempFile = await pickedFile.copy(tempPath);
        print(tempPath);

        // print('PDF saved to temp: ${tempFile.path}');

        // Navigate to preview page
      } else {
        print('No file selected');
      }
    },
  );
}

IconButton cameraButton() {
  return IconButton(
    onPressed: () {},
    icon: Icon(Icons.camera_alt_rounded, color: ourRed, size: 80),
  );
}
